class String

  def erb(options = {})
    Easyrb::Runner.new(self).run(options)
  end

end

class File

  def self.erb(filename, options = {})
    File.read(filename).erb(options)
  end

  def erb(options = {})
    self.read.erb(options)
  end

end
