require './test/test_helper'

class KeyTest < Minitest::Test

  def test_it_exists
    key = Key.new("02715")

    assert_instance_of Key, key
  end

  def test_attributes
    key = Key.new("02715")

    assert_equal "02715", key.string
    assert_equal 5, key.string.length
  end

  def test_all_digits
    key_valid = Key.new("11111")
    key_invalid = Key.new("hello")

    assert key_valid.all_digits?
    refute key_invalid.all_digits?
  end

  def test_is_five
    key_short = Key.new("123")
    refute key_short.is_five?

    key_short.pad_zero
    assert key_short.is_five?
    assert_equal "00123", key_short.string

    key_long = Key.new("123456")
    refute key_long.is_five?
  end

  def test_generate_five_digits
    key_default = Key.new

    assert_equal 5, key_default.generate_five_digits.length
  end

  def test_split_by_letter
    mock = mock(:key => '21450')
    key_default = Key.new(mock.key)

    assert_equal [21, 14, 45, 50], key_default.split_by_letter

    key = Key.new("02715")

    assert_equal [02, 27, 71, 15], key.split_by_letter
  end


end
