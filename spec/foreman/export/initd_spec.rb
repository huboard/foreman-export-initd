require 'foreman-export-initd'
require 'spec_helper'
require 'foreman/engine'
require 'tmpdir'

describe Foreman::Export::Initd, :fakefs do

  class Foreman::Export::Initd
    def exec_command command
      # Ignore command
    end
  end

  let(:procfile_initial) do
    FileUtils.mkdir_p('/tmp/app')
    File.open('/tmp/app/Procfile-initial', 'w') do |file|
      file.write spec_resource('Procfile-initial')
      file.path
    end
  end
  let(:procfile_changed) do
    FileUtils.mkdir_p('/tmp/app')
    File.open('/tmp/app/Procfile-changed', 'w') do |file|
      file.write spec_resource('Procfile-changed')
      file.path
    end
  end
  let(:options) { {:app => 'custom-app', :user => 'dummy'} }

  it 'exports to the filesystem' do
    engine = Foreman::Engine.new().load_procfile(procfile_initial)
    initd = Foreman::Export::Initd.new('/etc/init.d', engine, options)
    initd.export
    File.read('/etc/init.d/custom-app-foo').should == spec_resource('initd/custom-app-foo')
    File.read('/etc/init.d/custom-app-bar').should == spec_resource('initd/custom-app-bar')

    engine = Foreman::Engine.new().load_procfile(procfile_changed)
    initd = Foreman::Export::Initd.new('/etc/init.d', engine, options)
    initd.export
    File.exists?('/etc/init.d/custom-app-foo').should == false
    File.read('/etc/init.d/custom-app-bar').should == spec_resource('initd/custom-app-bar')
  end
end
