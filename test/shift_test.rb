require './test/test_helper'

class ShiftTest < Minitest::Test

  def setup
    @key = Key.new
    @offset = Offset.new
    @shift = Shift.new(@key, @offset)

  end

  def test_it_exists
    assert_instance_of Shift, @shift
  end

  def test_attributes
    key = Key.new("02715")
    offset = Offset.new("040895")
    shift = Shift.new(key, offset)

    assert_equal "02715", shift.key.string
    assert_equal "040895", shift.offset.date
  end

  def test_combine_key_and_offset
    key = Key.new("02715")
    offset = Offset.new("040895")
    shift = Shift.new(key, offset)
    assert_equal [3, 0, 19, 20], shift.combine_key_and_offset
  end

  def test_generate_final_shift
    key = Key.new('02715')
    offset = Offset.new('040895')
    mock = mock(:key => '82639', :date => '260719')

    key_default = Key.new(mock.key)
    offset_default = Offset.new(mock.date)

    # both key and date are given
    shift_0 = Shift.new(key, offset)
    assert_equal ({:A=>3, :B=>0, :C=>19, :D=>20}), shift_0.generate_final_shift

    # only key is given, mock out date obj
    shift_1 = Shift.new(key, offset_default)
    assert_equal ({:A=>8, :B=>9, :C=>23, :D=>16}), shift_1.generate_final_shift

    # only offset is given, mock out key obj
    shift_2 = Shift.new(key_default, offset)
    assert_equal ({:A=>2, :B=>26, :C=>11, :D=>17}), shift_2.generate_final_shift

    # default, mock out key and date obj
    shift_3 = Shift.new(key_default, offset_default)
    assert_equal ({:A=>7, :B=>8, :C=>15, :D=>13}), shift_3.generate_final_shift
  end

  def test_shift_chars
    key = Key.new('02715')
    offset = Offset.new('040895')
    shift = Shift.new(key, offset)

    expected_1 = [107, 101, 127, 127, 114, 32, 138, 114, 117, 127, 119]
    expected_2 = [107, "1", "2", 121, 111, 111, 130, 52, 122, "!", 130, 134, 111, 100, "."]

    assert_equal expected_1, shift.shift_chars("hello world")
    assert_equal expected_2, shift.shift_chars("h12ello w!orld.")
  end
end
