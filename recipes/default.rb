#  Services Cookbook
#
#  Recipe:: Default
#  Setup the connection with the current run_context
#

# cookbok has been moved to a gem install it @ runtime
chef_gem 'jn_services' do
  action :nothing
end.run_action(:install)

Services::Connection.new run_context: run_context
