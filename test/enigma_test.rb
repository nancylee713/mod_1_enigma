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
    expected_encrypt = [["k", "r", "u"], ["e", " ", "l"], ["d", "o", "w"], ["e", "h", nil]]
    expected_decrypt = [["h", "o", "r"], ["e", " ", "l"], ["l", "w", "d"], ["l", "o", nil]]
    
    assert_equal expected_encrypt, @enigma.generate_transposed_chars("hello world", "02715", "040895", "right")
    assert_equal expected_decrypt, @enigma.generate_transposed_chars("keder ohulw", "02715", "040895", "left")
  end

  def test_generate_encrypted_string
    assert_equal "keder ohulw", @enigma.generate_encrypted_string("hello world", "02715", "040895")
    assert_equal "keder ohulw", @enigma.generate_encrypted_string("HELLO WORLD", "02715", "040895")
    assert_equal "keder ohulw", @enigma.generate_encrypted_string("special_!_char_as_IS.", "02715", "040895")
  end

  def test_encrypt
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }
    assert_equal expected, @enigma.encrypt("hello world", "02715", "040895")
  end

  def test_encrypt_with_todays_date
    mock = mock(:date => "260719")

    expected = {
      encryption: "pnhawisdzu ",
      key: "02715",
      date: "260719"
    }

    assert_equal expected, @enigma.encrypt("hello world", "02715", mock.date)
  end

  def test_encrypt_with_random_key
    mock = mock(:key => "12345")
    mock_2 = mock(:key => "123")

    expected = {
      encryption: "uauhawekdhm",
      key: "12345",
      date: "040895"
    }

    expected_2 = {
      encryption: "ifzmpajpsmr",
      key: "00123",
      date: "040895"
    }

    assert_equal expected, @enigma.encrypt("hello world", mock.key, "040895")
    assert_equal expected_2, @enigma.encrypt("hello world", mock_2.key, "040895")
  end

  def test_encrypt_random_keydate
    mock = mock(:key => "12345", :date => "260719")

    expected = {
      encryption: "zjydfeigiqq",
      key: "12345",
      date: "260719"
    }

    assert_equal expected, @enigma.encrypt("hello world", mock.key, mock.date)
  end

  def test_decrypt
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @enigma.decrypt("keder ohulw", "02715", "040895")
  end

  def test_decrypt_with_todays_date
    mock = stub(:date => "260719")

    expected = {
      decryption: "hello world",
      key: "02715",
      date: "260719"
    }

    assert_equal expected, @enigma.decrypt("pnhawisdzu ", "02715", mock.date)

    encrypted = @enigma.encrypt("hello world", "02715", mock.date)
    assert_equal expected, @enigma.decrypt(encrypted[:encryption], "02715", mock.date)
  end

  def test_decrypt_with_random_key
    mock = stub(:key => "12345")
    mock_2 = stub(:key => "123")

    expected = {
      decryption: "hello world",
      key: "12345",
      date: "040895"
    }

    expected_2 = {
      decryption: "hello world",
      key: "00123",
      date: "040895"
    }

    assert_equal expected, @enigma.decrypt("uauhawekdhm", mock.key, "040895")
    assert_equal expected_2, @enigma.decrypt("ifzmpajpsmr", mock_2.key, "040895")
  end

  def test_decrypt_random_keydate
    mock = mock(:key => "12345", :date => "260719")

    expected = {
      decryption: "hello world",
      key: "12345",
      date: "260719"
    }

    assert_equal expected, @enigma.decrypt("zjydfeigiqq", mock.key, mock.date)
  end
end