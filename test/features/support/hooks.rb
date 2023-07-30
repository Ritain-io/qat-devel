require 'vcr'

Before do |scenario|
  cassette_name = scenario.name.downcase.tr(" ", "-")
  VCR.eject_cassette&.tap do |cassette|
    puts "CLOSED VCR CASSETTE '#{cassette.name}' -> #{cassette.file}"
  end
  VCR.insert_cassette(cassette_name).tap{|i| STDOUT.puts i.file}
  set_environment_variable 'VCR_CASSETTE_NAME', scenario.name.downcase.tr(" ", "-")
end

After '@env' do
  reset_env!
end

After '@tag_creation' do
  old_id               = ENV['CI_PROJECT_ID']
  ENV['CI_PROJECT_ID'] = '255'

  QAT::Devel::GitLab::Client.new.client.delete_tag(255, '2.0.0')

  ENV['CI_PROJECT_ID'] = old_id
end

BeforeAll do
  VCR.configure do |config|
    config.cassette_library_dir = File.join(File.dirname(__FILE__), '..', '..', 'fixtures', 'cassettes')
    config.hook_into :webmock
    #config.default_cassette_options = {allow_unused_http_interactions: false, decode_compressed_response: true, record: :none}
    config.default_cassette_options = {decode_compressed_response: true, record: :new_episodes}
  end
end

at_exit do
  VCR.eject_cassette&.tap do |cassette|
    puts "CLOSED VCR CASSETTE '#{cassette.name}' -> #{cassette.file}"
  end
end