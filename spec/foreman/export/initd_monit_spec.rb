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
  let(:options) { Hash.new }
  let(:engine) { Foreman::Engine.new().load_procfile(procfile) }
  let(:initd) { Foreman::Export::InitdMonit.new('/tmp/monit', engine, options) }

  it 'exports to the filesystem' do
    initd.export
    File.read('/tmp/monit/app-foo').should == spec_resource('initd_monit/app-foo')
    File.read('/tmp/monit/app-bar').should == spec_resource('initd_monit/app-bar')
  end
end
