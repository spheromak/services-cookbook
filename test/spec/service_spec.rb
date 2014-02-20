require_relative "spec_helper"
describe "Services::Service" do
  before(:each) do
    @s_members = [
      {"ip"=>"127.0.0.2", "proto"=>"http", "port"=>"80", "weight"=>"20", "service"=>"test", "name"=>"test_member"},
      {"ip"=>"127.0.0.3", "proto"=>"http", "port"=>"80", "weight"=>"20", "service"=>"test", "name"=>"test_member2"}
    ]
    Services::Connection.new host: "localhost"
    @s = Services::Service.new "test"
  end

  it "should load the test service" do
    hashed =  @s.members.map {|m| m.to_hash}
    hashed.should == @s_members
  end

  it "should handle non-existant services" do
    a = Services::Service.new "should_not_exist"
  end
end
