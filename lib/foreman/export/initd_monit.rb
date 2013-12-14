require 'foreman-export-initd'

class Foreman::Export::InitdMonit < Foreman::Export::Base
  include Initd::Export

  def export
    error('Must specify a location') unless location
    setup
    engine.each_process do |name, process|
      concurrency = concurrency name
      path = path name
      if concurrency > 0
        say 'Warning: Initd exporter ignores concurrency > 1' if concurrency > 1
        contents = Initd::MonitConfig.new(app, path).content
        export_file path, contents
      end
    end
    cleanup
  end
end
