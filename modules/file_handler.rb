module FileHandler

  def read(file_path)
    handle = File.open(file_path, "r")
    message = handle.read
    handle.close
    message
  end

  def write(output_path, info, task)
    writer = File.open(output_path, "w")
    writer.write(info[task])
    writer.close

    puts "Created #{output_path} with the key #{info[:key]} and date #{info[:date]}"
  end
end
