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

  def test_preprocess_input
    keys = ["2715", 2715, true, "123456", "abcde", ""]
    expected = ["02715", nil, nil, nil, nil, "00000"]
    actual = keys.map { |k| Key.preprocess_input(k) }

    assert_equal expected, actual
  end

  def test_default_that_generates_five_digits
    assert_equal 5, Key.default.length
  end

  def test_split_by_letter
    mock = mock(:key => '21450')
    key_default = Key.new(mock.key)

    assert_equal [21, 14, 45, 50], key_default.split_by_letter

    key = Key.new("02715")

    assert_equal [02, 27, 71, 15], key.split_by_letter
  end


end
