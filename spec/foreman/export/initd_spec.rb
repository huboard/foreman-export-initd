require 'foreman-export-initd'
require 'spec_helper'
require 'foreman/engine'
require 'tmpdir'

describe Foreman::Export::Initd, :fakefs do

  class Foreman::Export::Initd

    attr_reader :commands_run

    def exec_command command
      @commands_run ||= []
      @commands_run.push command
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
    initd.commands_run.should == ['update-rc.d custom-app-bar defaults', 'update-rc.d custom-app-foo defaults']
    File.read('/etc/init.d/custom-app-foo').should == spec_resource('initd/custom-app-foo')
    File.read('/etc/init.d/custom-app-bar').should == spec_resource('initd/custom-app-bar')


    engine = Foreman::Engine.new().load_procfile(procfile_changed)
    initd = Foreman::Export::Initd.new('/etc/init.d', engine, options)
    initd.export
    initd.commands_run.should == ['update-rc.d custom-app-bar defaults', 'update-rc.d -f custom-app-foo remove']
    File.exists?('/etc/init.d/custom-app-foo').should == false
    File.read('/etc/init.d/custom-app-bar').should == spec_resource('initd/custom-app-bar')
  end
end
