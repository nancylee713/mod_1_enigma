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
    assert_equal [3, 27, 73, 20], shift.combine_key_and_offset
  end

  def test_generate_final_shift
    key = Key.new('02715')
    offset = Offset.new('040895')
    mock = mock(:key => '82639', :date => '260719')

    key_default = Key.new(mock.key)
    offset_default = Offset.new(mock.date)

    # both key and date are given
    shift_0 = Shift.new(key, offset)
    assert_equal ({:A=>3, :B=>27, :C=>73, :D=>20}), shift_0.generate_final_shift

    # only key is given, mock out date obj
    shift_1 = Shift.new(key, offset_default)
    assert_equal ({:A=>8, :B=>36, :C=>77, :D=>16}), shift_1.generate_final_shift

    # only offset is given, mock out key obj
    shift_2 = Shift.new(key_default, offset)
    assert_equal ({:A=>83, :B=>26, :C=>65, :D=>44}), shift_2.generate_final_shift

    # default, mock out key and date obj
    shift_3 = Shift.new(key_default, offset_default)
    assert_equal ({:A=>88, :B=>35, :C=>69, :D=>40}), shift_3.generate_final_shift
  end

  def test_convert_chr_to_ord
    expected = [[104, 101, 108, 108], [111, 96, 119, 111], [114, 108, 100]]

    assert_equal expected, @shift.convert_chr_to_ord("hello world")
  end

  def test_apply_shift
    key = Key.new("02715")
    offset = Offset.new("040895")
    shift = Shift.new(key, offset)

    expected = [[107, 128, 181, 128], [114, 123, 192, 131], [117, 135, 173]]

    assert_equal expected, shift.apply_shift("hello world")
  end
end
