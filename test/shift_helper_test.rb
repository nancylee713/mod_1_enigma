require './test/test_helper'

class ShiftHelperTest < Minitest::Test

  def setup
    @enigma = Enigma.new
    @shift = Shift.new
  end

  def test_generate_hash_with_four_keys
    arr = [3, 0, 19, 20]
    expected = {:A=>3, :B=>0, :C=>19, :D=>20}

    assert_equal expected, @shift.generate_hash_with_four_keys(arr)
  end

  def test_find_shift
    ciphertext = "vjqtbeaweqihssi"
    date = "291018"

    assert_equal [14, 5, 5, 8], @enigma.find_shift(ciphertext, date)
  end

  def test_find_shift_offset_pair
    skip
    ciphertext = "vjqtbeaweqihssi"
    date = "291018"
    expected = [[14, 6], [5, 3], [5, 2], [8, 4]]

    assert_equal expected, @enigma.find_shift_offset_pair(ciphertext, date)
  end

  def test_find_key
    skip
    ciphertext = "vjqtbeaweqihssi"
    date = "291018"

    expected = [["08", "02"], ["02", "03"], ["03", "04"]]

    assert_equal expected, @enigma.find_key_pair(ciphertext, date)
  end

  def test_stringify_key
    skip
    ciphertext = "vjqtbeaweqihssi"
    date = "291018"

    assert_equal "08304", @enigma.stringify_key(ciphertext, date)
  end
end
