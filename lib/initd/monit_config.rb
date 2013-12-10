class Initd::MonitConfig

  attr_reader :path

  def templates_dir
    Pathname.new(__FILE__).dirname.dirname.dirname.join('templates')
  end

  def initialize(path)
    @path = path
  end

  def name
    @path.basename.to_s
  end

  def pidfile
    Pathname.new('/var/run').join(name).join("#{name}.pid")
  end

  def content
    template = templates_dir.join('monit_config.erb')
    ERB.new(template.read, nil, '<>').result(binding)
  end
end
