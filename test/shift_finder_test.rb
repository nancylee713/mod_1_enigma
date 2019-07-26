require './test/test_helper'

class ShiftFinderTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_attributes
    assert_equal 27, @enigma.char_set.length
  end

  def test_generate_five_digits
    mock_five = stub(:generate_five_digits => "02715")

    assert_equal 5, @enigma.generate_five_digits.length
  end

  def test_generate_date
    assert_equal "260719", @enigma.generate_date
  end

  def test_generate_keys
    mock = mock(:key => '82639')

    assert_equal [82, 26, 63, 39], @enigma.generate_keys(mock.key)
    assert_equal [02, 27, 71, 15], @enigma.generate_keys("02715")
  end

  def test_generate_offsets
    mock = mock(:date => '260719')

    assert_equal [1, 0, 2, 5], @enigma.generate_offsets("040895")
    assert_equal [6, 9, 6, 1], @enigma.generate_offsets(mock.date)
  end

  def test_generate_final_shift
    mock = mock(:key => '82639', :date => '260719')

    assert_equal ({:A=>3, :B=>0, :C=>19, :D=>20}), @enigma.shift_by_class("02715", "040895")
    assert_equal ({:A=>2, :B=>26, :C=>11, :D=>17}), @enigma.shift_by_class(mock.key, "040895")
    assert_equal ({:A=>8, :B=>9, :C=>23, :D=>16}), @enigma.shift_by_class("02715", mock.date)
  end

end
