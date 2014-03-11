#  Services Cookbook
#
#  Recipe:: Default
#  Setup the connection with the current run_context
#

chef_gem 'jn_services' do
  version '1.0.7'
  action :install
  options(force: true)
end.run_action :install

require 'services'

Services::Connection.new run_context: run_context
