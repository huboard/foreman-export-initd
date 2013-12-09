require 'fileutils'

class Initd::Script

  def initialize(path, command)
    @path = path
    @command = command
  end

  def content
    @command
  end

  def export
    FileUtils.mkdir_p(File.dirname(@path))
    File.new(@path, 'w').write(content)
    File.chmod(0755, @path)
  end
end
