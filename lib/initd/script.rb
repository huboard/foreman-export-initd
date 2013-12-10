class Initd::Script

  attr_reader :daemon, :name, :description

  def templates_dir
    Pathname.new(__FILE__).dirname.dirname.dirname.join('templates')
  end

  def initialize(path, script, args, user)
    @path = path
    @daemon = {
        :name => path.basename.to_s,
        :script => script,
        :args => args.join(' '),
        :user => user,
    }
    @name = @daemon[:name]
    @description = @daemon[:name]
  end

  def pidfile
    Pathname.new('/var/run').join(@daemon[:name]).join("#{@daemon[:name]}.pid")
  end

  def content
    template = templates_dir.join('script.erb')
    ERB.new(template.read, nil, '<>').result(binding)
  end
end
