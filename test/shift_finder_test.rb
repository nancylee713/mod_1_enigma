require './test/test_helper'

class ShiftFinderTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_attributes
    assert_equal 27, @enigma.char_set.length
  end

  def test_generate_final_shift
    mock = mock(:key => '82639', :date => '260719')

    assert_equal ({:A=>3, :B=>0, :C=>19, :D=>20}), @enigma.shift_by_class("02715", "040895")
    assert_equal ({:A=>2, :B=>26, :C=>11, :D=>17}), @enigma.shift_by_class(mock.key, "040895")
    assert_equal ({:A=>8, :B=>9, :C=>23, :D=>16}), @enigma.shift_by_class("02715", mock.date)
  end

end
