require './test/test_helper'

class EnigmaTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_attributes
    assert_equal 27, @enigma.char_set.length
  end

  def test_generate_transposed_chars
    expected = [["k", "r", "u"], ["e", " ", "l"], ["d", "o", "w"], ["e", "h", nil]]

    assert_equal expected, @enigma.generate_transposed_chars("hello world", "02715", "040895")
  end

  def test_generate_encrypted_string
    assert_equal "keder ohulw", @enigma.generate_encrypted_string("hello world", "02715", "040895")
  end

  def test_encrypt
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }
    assert_equal expected, @enigma.encrypt("hello world", "02715", "040895")
  end
end
