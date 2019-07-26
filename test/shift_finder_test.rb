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

    assert_equal "02715", mock_five.generate_five_digits
  end

  def test_generate_date
    # need to update today's date
    assert_equal "260719", @enigma.generate_date
  end

  def test_generate_keys
    mock = mock(:key => '82639')

    assert_equal [82, 26, 63, 39], @enigma.generate_keys(mock.key)
    assert_equal [02, 27, 71, 15], @enigma.generate_keys("02715")
  end

  def test_generate_offsets
    # need to update today's date
    assert_equal [1, 0, 2, 5], @enigma.generate_offsets("040895")
    assert_equal [6, 9, 6, 1], @enigma.generate_offsets
  end

  def test_generate_final_shift
    mock_shift = mock(shift_by_class: {A: 3, B: 27, C: 73, D: 20})

    assert_equal ({A: 3, B: 27, C: 73, D: 20}), mock_shift.shift_by_class
  end

end
