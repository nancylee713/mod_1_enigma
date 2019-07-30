require './test/test_helper'

class EnigmaTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_attributes
    assert_instance_of Key, @enigma.key
    assert_instance_of Offset, @enigma.offset
  end

  def test_encrypt
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }
    assert_equal expected, @enigma.encrypt("hello world", "02715", "040895")

    expected_2 = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }
    assert_equal expected_2, @enigma.encrypt("hello world", "2715", "040895")
  end

  def test_encrypt_with_todays_date
    # skip
    mock = mock(:date => "260719")

    expected = {
      encryption: "pnhawisdzu ",
      key: "02715",
      date: "260719"
    }

    assert_equal expected, @enigma.encrypt("hello world", "02715", mock.date)
    # assert_equal expected, @enigma.encrypt("hello world", "02715")
  end

  def test_encrypt_with_random_key
    # skip
    mock = mock(:key => "12345")
    mock_2 = mock(:key => "123")

    expected = {
      encryption: "uauhawekdhm",
      key: "12345",
      date: "040895"
    }

    assert_equal expected, @enigma.encrypt("hello world", mock.key, "040895")

    expected_2 = {
      encryption: "ifzmpajpsmr",
      key: "00123",
      date: "040895"
    }

    assert_equal expected_2, @enigma.encrypt("hello world", mock_2.key, "040895")
  end

  def test_encrypt_random_keydate
    # skip
    mock = mock(:key => "12345", :date => "260719")

    expected = {
      encryption: "zjydfeigiqq",
      key: "12345",
      date: "260719"
    }

    assert_equal expected, @enigma.encrypt("hello world", mock.key, mock.date)
  end

  def test_decrypt
    # skip
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @enigma.decrypt("keder ohulw", "02715", "040895")

    expected_2 = {
      decryption: "012345",
      key: "02715",
      date: "040895"
    }

    assert_equal expected_2, @enigma.decrypt("012345", "02715", "040895")


    expected_3 = {
      decryption: "!_as_is.",
      key: "02715",
      date: "040895"
    }

    assert_equal expected_3, @enigma.decrypt("!_tl_ik.", "02715", "040895")
  end

  def test_decrypt_with_todays_date
    # skip
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
    # skip
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
    # skip
    mock = mock(:key => "12345", :date => "260719")

    expected = {
      decryption: "hello world",
      key: "12345",
      date: "260719"
    }

    assert_equal expected, @enigma.decrypt("zjydfeigiqq", mock.key, mock.date)
  end

  def test_find_shift
    # skip
    ciphertext = "vjqtbeaweqihssi"
    date = "291018"

    assert_equal [14, 5, 5, 8], @enigma.find_shift(ciphertext, date)
  end

  def test_find_shift_offset_pair
    # skip
    ciphertext = "vjqtbeaweqihssi"
    date = "291018"
    expected = [[14, 6], [5, 3], [5, 2], [8, 4]]

    assert_equal expected, @enigma.find_shift_offset_pair(ciphertext, date)
  end

  def test_find_key
    # skip
    ciphertext = "vjqtbeaweqihssi"
    date = "291018"

    expected = [["08", "02"], ["02", "03"], ["03", "04"]]

    assert_equal expected, @enigma.find_key_pair(ciphertext, date)
  end

  def test_stringify_key
    # skip
    ciphertext = "vjqtbeaweqihssi"
    date = "291018"

    assert_equal "08304", @enigma.stringify_key(ciphertext, date)
  end

  def test_crack
    # skip
    cipher = @enigma.encrypt("hello world end", "08304", "291018")[:encryption]

    expected = {
      decryption: "hello world end",
      date: "291018",
      key: "08304"
    }

    assert_equal expected, @enigma.crack(cipher, "291018")
  end

  def test_crack_without_date
    # skip
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
