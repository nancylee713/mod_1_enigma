module FileHandler

  def read(file_path)
    handle = File.open(file_path, "r")
    message = handle.read
    handle.close
    message
  end

  def write_encrypt(output_path, info)
    writer = File.open(output_path, "w")
    writer.write(info[:encryption])
    writer.close

    puts "Created #{output_path} with the key #{info[:key]} and date #{info[:date]}"
  end

  def write_decrypt(output_path, info)
    writer = File.open(output_path, "w")
    writer.write(info[:decryption])
    writer.close

    puts "Created #{output_path} with the key #{info[:key]} and date #{info[:date]}"
  end
end
