require 'spec_helper'

set :request_pty, true

# User
%w{ ansible saito-nao matsuoka kado sugiyama }.each do |usr|
  describe user(usr) do
    it { should exist }
    it { should belong_to_group 'wheel' }
  end
end

# Directory
describe file('/home/src') do
  it { should be_directory }
  it { should be_owned_by('root') }
  it { should be_grouped_into('root') }
  it { should be_mode('777') }
end


# Products
%w{ httpd nginx }.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

# sudo
describe file('/etc/sudoers') do
  it { should be_immutable }
end

# Resolver
%w{ devsvr01 devsvr02 devsvr03 devsvr04 devsvr05 devsvr06}.each do |hst|
  describe host(hst) do
    it { should be_resolvable }
  end
end

# Services
describe service("{{common_enable_services}}") do
  it { should be_enabled }
  it { should be_running }
end

describe service("{{common_disable_services}}") do
  it { should be_disabled }
  it { should be_running }
end

describe file('/etc/httpd/conf/httpd.conf') do
  it { should contain 'ServerName www.example.jp'}
end

# SELinux
describe selinux do
  it { should be_disabled }
end
