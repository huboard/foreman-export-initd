require 'fakefs/safe'
require 'fakefs/spec_helpers'

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true

  c.before(:all) do
    FakeFS.activate!
  end

  c.after(:all) do
    FakeFS.deactivate!
  end
end

def write_procfile (path)
  File.open(path, 'w') do |file|
    file.puts 'foo: ./foo-script'
    file.puts 'bar: ./bar-script'
  end
  File.expand_path(path)
end

def spec_resource (name)
  FakeFS.deactivate!
  path = Pathname.new(File.expand_path('../resources/stubs', __FILE__)).join(name)
  contents = File.new(path ,'r').read
  FakeFS.activate!
  contents
end
