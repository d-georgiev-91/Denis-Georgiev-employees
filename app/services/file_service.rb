class FileService
  def save(file)
    return error_response('File is missing') unless file.present?
    return error_response('Invalid content type') unless valid_content_type? file
    return error_response('Invalid file extension') unless valid_extension? file

    save_file file
  end

  def exist?(filename)
    File.exist? file_path filename
  end

  def file_path(filename)
    Rails.root.join 'tmp', sanitize(filename)
  end

  private

  def valid_content_type?(file)
    file.content_type == 'text/csv'
  end

  def valid_extension?(file)
    File.extname(file.original_filename).casecmp('.csv').zero?
  end

  def save_file(file)
    file_path = file_path file.original_filename

    begin
      File.open(file_path, 'wb') { |f| f.write file.read }
    rescue Errno::ENOENT, Errno::EACCES, Errno::ENOSPC, IOError, StandardError => e
      # Here should be logs
      return error_response('Something bad have happened, contact support!')
    end

    { success: true, file_path: file_path }
  end

  def sanitize(filename)
    File.basename filename.gsub /[^a-zA-Z0-9\-\_\.]+/, '_'
  end

  def error_response(message)
    { success: false, error: message }
  end
end
