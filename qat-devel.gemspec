#encoding: utf-8

Gem::Specification.new do |gem|
  gem.name        = 'qat-devel'
  gem.version     = '9.0.0'
  gem.summary     = %q{Support gem for QAT development.}
  gem.description = <<-DESC
  QAT Devel is a tool for executing common tasks in the development of QAT modules:
    - DoD metric validation
      - Code Coverage
      - Code Documentation
      - Code Quality
    - (more coming soon...)

  DESC
  #Change
  gem.email    = 'qatoolkit@readinessit.com'
  gem.homepage = 'https://www.ritain.io'

  gem.metadata    = {
      'source_code_uri'   => 'https://github.com/Ritain-io/qat-devel'
  }
  gem.authors = ['QAT']
  gem.license = 'GPL-3.0'

  extra_files = %w[LICENSE]
  gem.files   = Dir.glob('{lib}/**/*') + extra_files

  gem.required_ruby_version = '~> 3.2'

  # GEM dependencies
  gem.add_dependency 'activesupport', '~> 7.0'
  gem.add_dependency 'contracts', '~> 0.17.0'
  gem.add_dependency 'cucumber', '~> 8.0'
  gem.add_dependency 'rake', '~> 13.0.1'
  gem.add_dependency 'yard', '~> 0.9.9', '>= 0.9.9'
  gem.add_dependency 'kramdown', '~> 2.4'
  gem.add_dependency 'rubycritic', '~> 3.1'
  gem.add_dependency 'simplecov', '~> 0.10'
  gem.add_dependency 'simplecov-json', '~> 0.2'
  gem.add_dependency 'simplecov-rcov', '~> 0.2'
  gem.add_dependency 'minitest', '~> 5.10'
  gem.add_dependency 'aruba', '~> 2.1'
  gem.add_dependency 'retriable'
  gem.add_dependency 'nokogiri', '~> 1.7'
  gem.add_dependency 'nexus', '~> 1.3'
  gem.add_dependency 'gitlab', '~> 4.19.0'

  # Development dependencies
  gem.add_development_dependency 'vcr', '~> 5.0', '>= 5.0.0'
  gem.add_development_dependency 'webmock', '~> 3.6', '>= 3.6.0'
end
