require 'spec_helper'

set :request_pty, true

describe user('oshou') do
  it { should exist }
  it { should belong_to_group 'wheel' }
end

describe service("nginx") do
  it { should be_enabled }
  it { should be_running }
end

describe selinux do
  it { should be_disabled }
end
