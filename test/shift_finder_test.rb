require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/shift_finder'
require 'mocha/minitest'

class ShiftFinderTest < Minitest::Test

  def test_it_exists
    shift_finder = ShiftFinder.new

    assert_instance_of ShiftFinder, shift_finder
  end

  def test_attributes
    shift_finder = ShiftFinder.new

    assert_equal 27, shift_finder.charset.length
  end

  def test_generate_random_inputs
    random_input= mock(key: "02715", date: "040895")

    assert_equal "02715", random_input.key
    assert_equal "040895", random_input.date
  end


end
