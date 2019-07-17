require 'minitest'
require_relative '../../../lib/calculator.rb'


module TestWorld
  include Minitest::Assertions
  attr_writer :assertions

  def assertions
    @assertions ||= 0
  end
end

World TestWorld