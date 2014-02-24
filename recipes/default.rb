#  Services Cookbook
#
#  Recipe:: Default
#  Setup the connection with the current run_context
#

chef_gem 'etcd' do
  action :install
  source gem_file
  options(force: true)
end

chef_gem 'jn_services' do
  version '1.0.5'
  action :install
  options(force: true)
end

require 'services'

Services::Connection.new run_context: run_context
