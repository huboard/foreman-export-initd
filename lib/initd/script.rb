class Initd::Script

  attr_reader :daemon, :path, :description

  def templates_dir
    Pathname.new(__FILE__).dirname.dirname.dirname.join('templates')
  end

  def initialize(path, script, args, user)
    @path = path
    @daemon = {
        :name => name,
        :script => script,
        :args => args,
        :user => user,
    }
    @description = name
  end

  def name
    path.basename.to_s
  end

  def pidfile
    Pathname.new('/var/run').join(@daemon[:name]).join("#{@daemon[:name]}.pid")
  end

  def content
    template = templates_dir.join('script.erb')
    ERB.new(template.read, nil, '<>').result(binding)
  end
end
