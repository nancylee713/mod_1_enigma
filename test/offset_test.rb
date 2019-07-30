require './test/test_helper'

class OffsetTest < Minitest::Test
  def test_it_exists
    offset = Offset.new("260719")

    assert_instance_of Offset, offset
  end

  def test_attributes
    offset = Offset.new("260719")

    assert_equal "260719", offset.date
    assert_equal 6, offset.date.length
  end

  def test_generate_offsets
    offset = Offset.new("040895")
    assert_equal [1, 0, 2, 5], offset.generate_offsets

    mock = stub(:date => '260719')
    offset_default = Offset.new(mock.date)
    assert_equal [6, 9, 6, 1], offset_default.generate_offsets
  end
end
