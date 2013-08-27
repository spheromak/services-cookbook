describe "Services::Service" do
  before(:each) do
    @s_members = [{"ip"=>"", "proto"=>"http", "port"=>"80", "service"=>"test", "name"=>"test_member"}, {"ip"=>"", "proto"=>"http", "port"=>"80", "service"=>"test", "name"=>"test_member2"}]
    Services::Connection.new host: "localhost"
    @s = Services::Service.new "test"
  end

  it "should load the test service" do
    @s.members.should == @s_members
  end

  it "should handle non-existant services" do
    a = Services::Service.new "should_not_exist"
  end
end
