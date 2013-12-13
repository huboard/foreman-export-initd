class Foreman::Export::Initd < Foreman::Export::Base

  def export
    error('Must specify a location') unless location

    cwd = Pathname.new(engine.root)
    export_path = Pathname.new(location)
    say "creating: #{export_path}"
    FileUtils.mkdir_p(export_path)

    existing = []
    Dir.glob export_path.join("#{app}-*") do |filename|
      contents = File.new(filename, 'r').read
      existing.push(filename) if contents.match(/# Autogenerated by foreman/)
    end

    exported = []
    engine.each_process do |name, process|
      path = export_path.join("#{app}-#{name}")
      args = Shellwords.split(process.command)
      script = Pathname.new(cwd).join(args.shift)
      concurrency = engine.formation[name]
      if concurrency > 0
        say 'Warning: Initd exporter ignores concurrency > 1' if concurrency > 1
        contents = Initd::Script.new(path, script, args, user).content
        write_file(path, contents)
        File.chmod(0755, path)
        exported.push path.to_s
      end
    end

    to_remove = existing - exported
    to_remove.each do |filename|
      say 'removing ' + filename
      File.unlink filename
    end
  end
end
