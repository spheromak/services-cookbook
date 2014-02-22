#  Services Cookbook
#
#  Recipe:: Default
#  Setup the connection with the current run_context
#
# QQ this is what i gotta do for etcd for now
gem_file = "#{Chef::Config[:cache_path]}/etcd-0.2.0.alpha.gem"

if node[:ha_disabled]
  directory Chef::Config[:cache_path] do
    recursive true
    action :nothing
  end.run_action :create
end

remote_file gem_file do
  action :nothing
  source 'https://dl.dropboxusercontent.com/u/848501/etcd-0.2.0.alpha.gem'
end.run_action :create

chef_gem 'etcd' do
  action :install
  source gem_file
  options(force: true)
end

# cookbok has been moved to a gem install it @ runtime
chef_gem 'jn_services' do
  version '1.0.5'
  action :install
  options(force: true)
end

require 'services'

Services::Connection.new run_context: run_context
