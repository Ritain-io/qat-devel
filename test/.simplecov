# -*- encoding : utf-8 -*-
# Code coverage
require 'simplecov-json'
require 'simplecov-rcov'

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::JSONFormatter,
  SimpleCov::Formatter::RcovFormatter
]

eval_dir                  = ::File.realpath(::File.join(SimpleCov.root, '..', 'lib'))
ENV['SIMPLECOV_EVAL_DIR'] = eval_dir

SimpleCov.start do
  coverage_dir(ENV['SIMPLECOV_COVERAGE_DIR'])
  command_name(::File.basename(Dir.pwd))
  profiles.delete(:root_filter)
  filters.clear
  add_filter do |src|
    src.filename =~ /^#{SimpleCov.root}/ ||
      !(src.filename =~ /^#{SimpleCov.root}/) unless src.filename =~ /^#{eval_dir}/
  end
end