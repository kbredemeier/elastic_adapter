module ElasticAdapter
  module Responses
    class SuggestionResponse < BaseResponse
      # This class represents a search term and it's
      # suggested options
      class TermSuggestion
        attr_reader :text, :options

        def initialize(params)
          @text = params[:text]
          @options = params[:options]
        end
      end

      # This class represents a single named suggestion
      # returned by elaticsearch
      class Suggestion
        attr_reader :name, :terms

        def initialize(name, suggestions)
          @name = name
          @terms = []

          suggestions.each do |suggestion_per_term|
            @terms << TermSuggestion.new(suggestion_per_term)
          end
        end
      end

      attr_reader :suggestions

      private

      def set_instance_variables
        @suggestions = []

        object_without_shards = object.reject { |key, value| key == :shards}
        object_without_shards.each do |key, value|
          # In this context key is the named suggestion
          # returned by elasticsearch
          @suggestions << Suggestion.new(key, value)
        end
      end
    end
  end
end
