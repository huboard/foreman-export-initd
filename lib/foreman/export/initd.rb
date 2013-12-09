class Foreman::Export::Initd < Foreman::Export::Base

  def export
    error('Must specify a location') unless location

    cwd = Pathname.new(engine.root)
    export_to = Pathname.new(location)

    engine.each_process do |name, process|
      path = export_to.join("#{app}-#{name}")
      args = process.command.split(/\s+/)
      script = Pathname.new(cwd).join(args.shift)

      initscript = Initd::Script.new path, script, args
      initscript.export
    end
  end
end
