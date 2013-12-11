require 'spec_helper'
require 'foreman-export-initd'
require 'foreman/engine'
require 'foreman/export/launchd'
require 'tmpdir'

describe Foreman::Export::Initd, :fakefs do
  let(:procfile) { FileUtils.mkdir_p('/tmp/app'); write_procfile('/tmp/app/Procfile') }
  let(:options) { Hash.new }
  let(:engine) { Foreman::Engine.new().load_procfile(procfile) }
  let(:initd) { Foreman::Export::Initd.new('/tmp/initd', engine, options) }

  it 'exports to the filesystem' do
    initd.export
    File.read('/tmp/initd/app-foo').should == spec_resource('initd/app-foo')
    File.read('/tmp/initd/app-bar').should == spec_resource('initd/app-bar')
  end
end
