require 'pathname'
require 'foreman/export'
require 'foreman/cli'

class Foreman::Export::Initd < Foreman::Export::Base

  def export
    error("Must specify a location") unless location

    cwd = Pathname.new(engine.root)
    export_to = Pathname.new(location)

    engine.each_process do |name, process|
      1.upto(engine.formation[name]) do |num|
        path = export_to.join("#{app}-#{name}-#{num}")
        port = engine.port_for(process, num)
        env = engine.env.merge("PORT" => port)

        puts path
        puts port
        puts env
        puts cwd

      end
    end
  end
end
