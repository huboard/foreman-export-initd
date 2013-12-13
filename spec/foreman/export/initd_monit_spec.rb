require 'spec_helper'
require 'foreman-export-initd'
require 'foreman/engine'
require 'tmpdir'

describe Foreman::Export::InitdMonit, :fakefs do
  let(:procfile) do
    FileUtils.mkdir_p('/tmp/app')
    File.open('/tmp/app/Procfile', 'w') do |file|
      file.write spec_resource('Procfile')
      file.path
    end
  end
  let(:options) { {:app => 'custom-app', :user => 'dummy'} }
  let(:engine) { Foreman::Engine.new().load_procfile(procfile) }
  let(:initd) { Foreman::Export::InitdMonit.new('/tmp/monit', engine, options) }

  it 'exports to the filesystem' do
    initd.export
    File.read('/tmp/monit/custom-app-foo').should == spec_resource('initd_monit/custom-app-foo')
    File.read('/tmp/monit/custom-app-bar').should == spec_resource('initd_monit/custom-app-bar')
  end
end
