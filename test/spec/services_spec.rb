require_relative "spec_helper.rb"

describe "Services" do
  describe "::Connection" do
    it "should setup" do
      Services::Connection.new host: "localhost"
    end

    it "should fail without something to connect too" do
      expect { Services::Connection.new }.to raise_error
    end

    # chef functions in chef-spec specs ?
    #it "should accept a chef run_context" do
    #  Services::Connection.new(
    #    run_context: Chef::RunContext.new(
    #      Chef::Node.new,
    #      Chef::CookbookCollection.new,
    #      Chef::EventDispatch::Dispatcher.new
    #    )
    #  )
    #end
  end

  before(:each) do
    Services::Connection.new host: "localhost"
  end

  it "can set" do
    Services.set "/test/1", 1
  end

  it "can get" do
    Services.get "/_etcd/machines"
  end

  describe "::Entity" do
    before(:each) do
      Services::Connection.new host: "localhost"
    end

    it "should raise when directly instanced" do
      expect { Services::Entity.new("foo")}.to  raise_error(RuntimeError)
    end
  end
end

