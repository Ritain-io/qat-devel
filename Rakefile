#!/usr/bin/env rake
#encoding: utf-8
require 'cucumber'
require 'cucumber/rake/task'
require 'qat/devel/tasks'
require 'rake/testtask'



task :default => 'test'

namespace :test do

  def load_dependencies(task)
    task.libs << File.join(File.dirname(__FILE__), 'lib')
  end

  def clear_reports_folder!
    mkdir_p 'public'
    rm_rf ::File.join('public', '*')
  end

  desc 'Run all the tests'
  task :run do
    cd 'test' do
      Cucumber::Rake::Task.new do |task|
        clear_reports_folder!
        load_dependencies(task)
      end.runner.run
    end
  end
end

namespace :gemfile do
  desc 'Generate example gemfile for gem usage'
  task :example do
    @gem_name = 'qat-devel'

    spec = Gem::Specification::load("#{@gem_name}.gemspec")

    @gem_version              = spec.version
    @development_dependencies = spec.development_dependencies

    File.write 'Gemfile.example', ERB.new(<<ERB).result
source 'https://rubygems.org

gem '<%= @gem_name %>', '<%= @gem_version %>'
<% @development_dependencies.each do |dependency| %>gem '<%= dependency.name %>', '<%= dependency.requirements_list.reverse.join "', '"%>'
<% end %>
ERB
  end

  desc 'Generate default gemfile'
  task :default do
    File.write 'Gemfile.default', <<GEMFILE
source 'https://rubygems.org'

gemspec
GEMFILE
  end
end

desc 'Run the test'
task :test => 'test:run'

require 'kramdown'
require 'yard'
require 'yard/rake/yardoc_task'

YARD::Rake::YardocTask.new :doc do |t|
  options = [
    '--no-cache',
    '--no-private',
    '--no-api',
    '--default-return void',
    '--hide-void-return',
    '--verbose',
    '--debug',
    '--title QAT'
  ].join(' ').split(' ').map { |o| o.gsub '_', ' ' }

  t.files         = [
    'lib/**/*.rb'
  ]
  t.stats_options += ['--list-undoc', '--no-private']
  t.options       += options
end

task :vcr do
  # puts "USING VCR CASSETTE '#{ENV['VCR_CASSETTE_NAME']}'"

  require 'vcr'
  VCR.configure do |config|
    config.cassette_library_dir = "fixtures/cassettes"
    config.debug_logger = File.open('vcr_debug.log', File::CREAT | File::TRUNC | File::RDWR)
    config.hook_into :webmock
    # config.default_cassette_options = {allow_unused_http_interactions: false, decode_compressed_response: true, record: :none}
    config.default_cassette_options = {decode_compressed_response: true, record: :new_episodes}
  end

  # VCR.eject_cassette&.tap do |cassette|
  #   @cassete_name = cassette.name
  #   puts "CLOSED VCR CASSETTE '#{cassette.name}' -> #{cassette.file}"
  # end
  # VCR.insert_cassette(@cassete_name).tap{|i| STDOUT.puts i.file}

  at_exit do
    VCR.eject_cassette&.tap do |cassette|
      puts "CLOSED VCR CASSETTE '#{cassette.name}' -> #{cassette.file}"
    end
  end
end

Rake::Task['qat:devel:gitlab:milestone_issues_closed'].prerequisites.unshift :vcr
Rake::Task['qat:devel:gitlab:milestone_release_note'].prerequisites.unshift :vcr
Rake::Task['qat:devel:gitlab:milestone_tag'].prerequisites.unshift :vcr
Rake::Task['qat:devel:gitlab:check_version_tags'].prerequisites.unshift :vcr
Rake::Task['qat:devel:validate_yard_doc'].prerequisites.unshift :vcr
Rake::Task['qat:devel:static_analysis:validation'].prerequisites.unshift :vcr
Rake::Task['qat:devel:tests:run'].prerequisites.unshift :vcr