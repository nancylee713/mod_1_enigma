require './test/test_helper'

class ShiftTest < Minitest::Test

  def test_it_exists
    key = Key.new
    offset = Offset.new
    shift = Shift.new(key, offset)

    assert_instance_of Shift, shift
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
end
