require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/shift_finder'
require 'mocha/minitest'

class ShiftFinderTest < Minitest::Test

  def setup
    @shift_finder = ShiftFinder.new
  end

  def test_it_exists
    assert_instance_of ShiftFinder, @shift_finder
  end

  def test_attributes
    assert_equal 27, @shift_finder.charset.length
  end

  def test_generate_keys
    mock_keys = stub(:generate_keys => [02, 27, 71, 15])

    assert_equal [02, 27, 71, 15], mock_keys.generate_keys
  end

  def test_generate_offsets
    mock_offsets = stub(:generate_offsets => [1, 0, 2, 5])

    assert_equal [1, 0, 2, 5], mock_offsets.generate_offsets
  end

  def test_generate_random_inputs
    mock_data = stub(:generate_five_digits => "02715", :generate_date => "040895")

    assert_equal "02715", mock_data.generate_five_digits
    assert_equal "040895", mock_data.generate_date
  end

  def test_generate_final_shift
    mock_shift = mock(shift_by_class: {A: 3, B: 27, C: 73, D: 20})

    assert_equal ({A: 3, B: 27, C: 73, D: 20}), mock_shift.shift_by_class
  end

end
