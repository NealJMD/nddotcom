def support_file(filename)
  return File.new(Rails.root + 'spec/support/'+filename)
end