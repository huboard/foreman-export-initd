require 'foreman-export-initd'

class Foreman::Export::Initd < Foreman::Export::Base
  include Initd::Export

  def export
    error('Must specify a location') unless location
    setup

    engine.each_process do |name, process|
      args = Shellwords.split(process.command)
      script = Pathname.new(engine.root).join(args.shift)
      path = path(name)
      concurrency = concurrency(name)
      if concurrency > 0
        say 'Warning: Initd exporter ignores concurrency > 1' if concurrency > 1
        contents = Initd::Script.new(path, script, args, user).content
        export_file path, contents
      end
    end
    cleanup
  end
end
