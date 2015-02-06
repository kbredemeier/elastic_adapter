require "elastic_adapter"

mappings = {
  product: {
    properties: {
      name: {
        type: "string",
        index_analyzer: "simple",
        search_analyzer: "simple"
      },
      name_suggest: {
        type: "completion"
      },
      price: {
        type: "float",
        index: "not_analyzed"
      }
    }
  }
}

settings = { number_of_shards: 1 }

document_type = ElasticAdapter::DocumentType.new("product", mappings)

index = ElasticAdapter::Index.new(
  name: "product_index",
  url: "http://localhost:9200",
  log: true,
  settings: settings,
  document_type: document_type
)

# Creating an Index

response = index.create_index
response.inspect # => "{:acknowledged=>true}"
response.class # => ElasticAdapter::Response
response.success? # => true

# Indexing

doc1 = {
  id: 1,
  name: "foo",
  name_suggest: "foo",
  price: 11.12
}
doc2 = {
  id: 2,
  name_suggest: "bar",
  suggest: "bar",
  price: 1.12
}

response = index.index(doc1)
response.inspect # => "{:index=>\"product_index\", :type=>\"product\", :id=>\"1\", :version=>1, :created=>true}"
response.class # => ElasticAdapter::Response
response.success? # => true

response = index.index(doc2)
response.inspect # => "{:index=>\"product_index\", :type=>\"product\", :id=>\"2\", :version=>1, :created=>true}"
response.class # => ElasticAdapter::Response
response.success? # => true

sleep 3

# Query validation

query = { query: { match_all: {} } }
response = index.validate(query)
response.inspect # => "true"
response.class # => ElasticAdapter::Decoration::ValidationResponse

query = { foo: { match_all: {} } }
response = index.validate(query)
response.inspect # => "false"
response.class # => ElasticAdapter::Decoration::ValidationResponse

# Count documents

response = index.count(query)
response.inspect # => "{:exception=>#<Elasticsearch::Transport::Transport::Errors::BadRequest: [400] {\"count\":0,\"_shards\":{\"total\":1,\"successful\":0,\"failed\":1,\"failures\":[{\"index\":\"product_index\",\"shard\":0,\"reason\":\"BroadcastShardOperationFailedException[[product_index][0] ]; nested: QueryParsingException[[product_index] request does not support [foo]]; \"}]}}>}"
response.class # => ElasticAdapter::Response

# Get documents

response = index.get(1)
response.inspect # => "{:id=>\"1\", :name=>\"foo\", :name_suggest=>\"foo\", :price=>11.12}"
response.class # => ElasticAdapter::Decoration::HitDecorator

# Search documents

response = index.search(query)
response.inspect # => "{:exception=>#<Elasticsearch::Transport::Transport::Errors::BadRequest: [400] {\"error\":\"SearchPhaseExecutionException[Failed to execute phase [query_fetch], all shards failed; shardFailures {[XRKX3VOdSDyg0HVSm3_Wiw][product_index][0]: SearchParseException[[product_index][0]: from[-1],size[-1]: Parse Failure [Failed to parse source [{\\\"foo\\\":{\\\"match_all\\\":{}}}]]]; nested: SearchParseException[[product_index][0]: from[-1],size[-1]: Parse Failure [No parser for element [foo]]]; }]\",\"status\":400}>}"
response.class # => ElasticAdapter::Response

query = {query: {match: {name: "foo"}}}
response = index.search(query)
response.inspect # => "{:exception=>#<Elasticsearch::Transport::Transport::Errors::BadRequest: [400] {\"error\":\"SearchPhaseExecutionException[Failed to execute phase [query_fetch], all shards failed; shardFailures {[XRKX3VOdSDyg0HVSm3_Wiw][product_index][0]: SearchParseException[[product_index][0]: from[-1],size[-1]: Parse Failure [Failed to parse source [{\\\"foo\\\":{\\\"match_all\\\":{}}}]]]; nested: SearchParseException[[product_index][0]: from[-1],size[-1]: Parse Failure [No parser for element [foo]]]; }]\",\"status\":400}>}"
response.class # => ElasticAdapter::Response

# Suggestions
suggest_query = {
  product_suggest: {
    text: "fo",
    completion: {
      field: "name_suggest"
    }
  }
}

response = index.suggest(suggest_query)
response.inspect # => "{:options=>[{:text=>\"foo\", :score=>1.0}]}"
response.class # => ElasticAdapter::Decoration::SuggestionResponse

# Deleting an Index

response = index.delete_index
response.inspect # => "{:acknowledged=>true}"
response.class # => ElasticAdapter::Response
response.success? # => true

# Failing actions

response = index.delete_index
response.inspect # => "{:exception=>#<Elasticsearch::Transport::Transport::Errors::NotFound: [404] {\"error\":\"IndexMissingException[[product_index] missing]\",\"status\":404}>}"
response.class # => ElasticAdapter::Response
response.success? # => false


# !> 2015-02-06 17:52:19 +0100: PUT http://localhost:9200/product_index [status:200, request:0.053s, query:n/a]
# !> 2015-02-06 17:52:19 +0100: > {"mappings":{"product":{"properties":{"name":{"type":"string","index_analyzer":"simple","search_analyzer":"simple"},"name_suggest":{"type":"completion"},"price":{"type":"float","index":"not_analyzed"}}}},"settings":{"number_of_shards":1}}
# !> 2015-02-06 17:52:19 +0100: < {"acknowledged":true}
# !> 2015-02-06 17:52:19 +0100: PUT http://localhost:9200/product_index/product/1 [status:201, request:0.037s, query:n/a]
# !> 2015-02-06 17:52:19 +0100: > {"name":"foo","name_suggest":"foo","price":11.12}
# !> 2015-02-06 17:52:19 +0100: < {"_index":"product_index","_type":"product","_id":"1","_version":1,"created":true}
# !> 2015-02-06 17:52:19 +0100: PUT http://localhost:9200/product_index/product/2 [status:201, request:0.005s, query:n/a]
# !> 2015-02-06 17:52:19 +0100: > {"name_suggest":"bar","suggest":"bar","price":1.12}
# !> 2015-02-06 17:52:19 +0100: < {"_index":"product_index","_type":"product","_id":"2","_version":1,"created":true}
# !> 2015-02-06 17:52:22 +0100: GET http://localhost:9200/product_index/_validate/query?explain=true [status:200, request:0.006s, query:n/a]
# !> 2015-02-06 17:52:22 +0100: > {"query":{"match_all":{}}}
# !> 2015-02-06 17:52:22 +0100: < {"valid":true,"_shards":{"total":1,"successful":1,"failed":0},"explanations":[{"index":"product_index","valid":true,"explanation":"ConstantScore(*:*)"}]}
# !> 2015-02-06 17:52:22 +0100: GET http://localhost:9200/product_index/_validate/query?explain=true [status:200, request:0.004s, query:n/a]
# !> 2015-02-06 17:52:22 +0100: > {"foo":{"match_all":{}}}
# !> 2015-02-06 17:52:22 +0100: < {"valid":false,"_shards":{"total":1,"successful":1,"failed":0},"explanations":[{"index":"product_index","valid":false,"error":"org.elasticsearch.index.query.QueryParsingException: [product_index] request does not support [foo]"}]}
# !> 2015-02-06 17:52:22 +0100: GET http://localhost:9200/product_index/_count [status:400, request:0.005s, query:N/A]
# !> 2015-02-06 17:52:22 +0100: > {"foo":{"match_all":{}}}
# !> 2015-02-06 17:52:22 +0100: < {"count":0,"_shards":{"total":1,"successful":0,"failed":1,"failures":[{"index":"product_index","shard":0,"reason":"BroadcastShardOperationFailedException[[product_index][0] ]; nested: QueryParsingException[[product_index] request does not support [foo]]; "}]}}
# !> 2015-02-06 17:52:22 +0100: [400] {"count":0,"_shards":{"total":1,"successful":0,"failed":1,"failures":[{"index":"product_index","shard":0,"reason":"BroadcastShardOperationFailedException[[product_index][0] ]; nested: QueryParsingException[[product_index] request does not support [foo]]; "}]}}
# !> 2015-02-06 17:52:22 +0100: GET http://localhost:9200/product_index/product/1 [status:200, request:0.004s, query:n/a]
# !> 2015-02-06 17:52:22 +0100: < {"_index":"product_index","_type":"product","_id":"1","_version":1,"found":true,"_source":{"name":"foo","name_suggest":"foo","price":11.12}}
# !> 2015-02-06 17:52:22 +0100: GET http://localhost:9200/product_index/_search [status:400, request:0.007s, query:N/A]
# !> 2015-02-06 17:52:22 +0100: > {"foo":{"match_all":{}}}
# !> 2015-02-06 17:52:22 +0100: < {"error":"SearchPhaseExecutionException[Failed to execute phase [query_fetch], all shards failed; shardFailures {[XRKX3VOdSDyg0HVSm3_Wiw][product_index][0]: SearchParseException[[product_index][0]: from[-1],size[-1]: Parse Failure [Failed to parse source [{\"foo\":{\"match_all\":{}}}]]]; nested: SearchParseException[[product_index][0]: from[-1],size[-1]: Parse Failure [No parser for element [foo]]]; }]","status":400}
# !> 2015-02-06 17:52:22 +0100: [400] {"error":"SearchPhaseExecutionException[Failed to execute phase [query_fetch], all shards failed; shardFailures {[XRKX3VOdSDyg0HVSm3_Wiw][product_index][0]: SearchParseException[[product_index][0]: from[-1],size[-1]: Parse Failure [Failed to parse source [{\"foo\":{\"match_all\":{}}}]]]; nested: SearchParseException[[product_index][0]: from[-1],size[-1]: Parse Failure [No parser for element [foo]]]; }]","status":400}
# !> 2015-02-06 17:52:22 +0100: POST http://localhost:9200/product_index/_suggest [status:200, request:0.004s, query:n/a]
# !> 2015-02-06 17:52:22 +0100: > {"product_suggest":{"text":"fo","completion":{"field":"name_suggest"}}}
# !> 2015-02-06 17:52:22 +0100: < {"_shards":{"total":1,"successful":1,"failed":0},"product_suggest":[{"text":"fo","offset":0,"length":2,"options":[{"text":"foo","score":1.0}]}]}
# !> 2015-02-06 17:52:22 +0100: DELETE http://localhost:9200/product_index [status:200, request:0.014s, query:n/a]
# !> 2015-02-06 17:52:22 +0100: < {"acknowledged":true}
# !> 2015-02-06 17:52:22 +0100: DELETE http://localhost:9200/product_index [status:404, request:0.003s, query:N/A]
# !> 2015-02-06 17:52:22 +0100: < {"error":"IndexMissingException[[product_index] missing]","status":404}
# !> 2015-02-06 17:52:22 +0100: [404] {"error":"IndexMissingException[[product_index] missing]","status":404}
