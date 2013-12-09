require 'pathname'
require 'foreman/export'
require 'foreman/cli'

class Foreman::Export::Initd < Foreman::Export::Base

  def export
    error('Must specify a location') unless location

    cwd = Pathname.new(engine.root)
    export_to = Pathname.new(location)

    engine.each_process do |name, process|
      path = export_to.join("#{app}-#{name}")
      command = Pathname.new(cwd).join(process.command)

      initscript = Initd::Script.new path, command
      initscript.export
    end
  end
end
