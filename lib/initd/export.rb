module Initd::Export

  def export_path
    Pathname.new location
  end

  def setup
    @exported = []
    say "creating: #{export_path}"
    FileUtils.mkdir_p(export_path)
  end

  def cleanup
    Dir.glob export_path.join("#{app}-*") do |filename|
      contents = File.new(filename, 'r').read
      next unless contents.match(/# Autogenerated by foreman/)
      next if @exported.include? filename.to_s
      say 'removing ' + filename
      remove filename
    end
  end

  def remove path
    File.unlink path
  end

  def export_file (path, contents)
    write_file(path, contents)
    File.chmod(0755, path)
    @exported.push path.to_s
  end

  def concurrency(name)
    engine.formation[name]
  end

  def path(name)
    export_path.join("#{app}-#{name}")
  end

  def exec_command command
    system(command)
    raise "Command failed `#{command}`" unless $?.success?
  end
end
