require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "fileutils"
require "yard"

RSpec::Core::RakeTask.new(:spec)

task default: :spec

task :console do
  exec "irb -r elastic_adapter -I ./lib"
end

RSpec::Core::RakeTask.new(:record) do |t|
  ENV['RECORDING'] = "1"
  FileUtils.rm_rf "spec/cassettes"
  t.rspec_opts = "--tag vcr"
end

YARD::Rake::YardocTask.new(:doc) do |t|
  t.files   = ['lib/**/*.rb']
  # t.options = ['--any', '--extra', '--opts'] # optional
  # t.stats_options = ['--list-undoc']         # optional
end
