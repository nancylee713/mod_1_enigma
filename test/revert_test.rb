require './test/test_helper'

class RevertTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_find_shift
    ciphertext = "vjqtbeaweqihssi"
    date = "291018"

    assert_equal [14, 5, 5, 8], @enigma.find_shift(ciphertext, date)
  end

  def test_find_shift_offset_pair
    ciphertext = "vjqtbeaweqihssi"
    date = "291018"
    expected = [[14, 6], [5, 3], [5, 2], [8, 4]]

    assert_equal expected, @enigma.find_shift_offset_pair(ciphertext, date)
  end

  def test_find_key
    ciphertext = "vjqtbeaweqihssi"
    date = "291018"

    expected = [["08", "02"], ["02", "03"], ["03", "04"]]

    assert_equal expected, @enigma.find_key_pair(ciphertext, date)
  end

  def test_stringify_key
    ciphertext = "vjqtbeaweqihssi"
    date = "291018"

    assert_equal "08304", @enigma.stringify_key(ciphertext, date)
  end

  def test_crack
    cipher = @enigma.encrypt("hello world end", "08304", "291018")[:encryption]

    expected = {
      decryption: "hello world end",
      date: "291018",
      key: "08304"
    }

    assert_equal expected, @enigma.crack(cipher, "291018")
  end

  def test_crack_without_date
    mock = stub(:date=>"290719")

    expected = {
      :encryption=>"vpuqbketewmesym",
      :key=>"08304",
      :date=>"290719"
    }

    assert_equal expected, @enigma.encrypt("hello world end", "08304", mock.date)

    crack_expected = {
      :decryption=>"hello world end",
      :date=> "290719",
      :key=> "08304"
    }

    assert_equal crack_expected, @enigma.crack("vpuqbketewmesym", mock.date)
  end
end
