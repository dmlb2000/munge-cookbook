require 'spec_helper'

describe file('/var/log') do
  it { should_not be_writable.by('group') }
end

describe file('/etc/munge/munge.key') do
  it { should exist }
  it { should be_file }
  it { should be_mode 400 }
  it { should be_owned_by 'munge' }
  it { should be_grouped_into 'munge' }
  its(:md5sum) { should eq '6e0abc55a4201070155709ae55395a54' }
end

describe command('echo foo | munge | unmunge -m /dev/null') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should contain('foo') }
end
