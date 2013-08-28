describe "Services::Endpoint" do
  before(:each) do
    @ep_data ={"name"=>"test", "ip"=>"127.0.0.1", "proto"=>"http", "port"=>"80"}
    Services::Connection.new host: "localhost"
    @ep = Services::Endpoint.new "test", ip: '127.0.0.1', port: 80
  end

  it "should raise without a service name" do
    expect { Services::Endpoint.new }.to raise_error
  end

  describe "#to_hash" do
    it "should return each pair of insance vars" do
      @ep.to_hash.should == @ep_data
    end
  end

  describe "#store" do
    it "should store" do
      puts "storing #{@ep.inspect}"
      @ep.store
    end
  end

  describe "#load" do
    before do
      @ep = Services::Endpoint.new "test"
    end

    it "should handle no endpoint" do
      e = Services::Endpoint.new "test_endpoint_fail"
      e.load
    end

    it "should load" do
      @ep.load
      @ep.to_hash.should == @ep_data
    end

    it "should get ip" do
      @ep.ip.should == ""
      @ep.load
      @ep.ip.should == "127.0.0.1"
    end

  end
end
