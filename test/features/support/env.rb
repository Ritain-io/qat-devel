# -*- encoding : utf-8 -*-
require 'minitest'
require 'aruba/cucumber'
require 'retriable'
# Code coverage
require 'simplecov'
require_relative '../../../lib/qat/devel/lib/gitlab/client'
require_relative '../../../test/lib/env_helper'

ENV['SIMPLECOV_COVERAGE_DIR'] = ::File.join(Dir.pwd, SimpleCov.coverage_dir)

module Test
  include Minitest::Assertions

  attr_writer :assertions

  def assertions
    @assertions ||= 0
  end
end
World(Test)

Aruba.configure do |config|
  config.exit_timeout         = 6000
end
