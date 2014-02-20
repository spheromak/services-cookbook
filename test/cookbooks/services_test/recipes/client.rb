include_recipe "etcd"
include_recipe "services"

# delay this here, because this assumes that etcd is up and available.
# in normal infra etcd service should be up and running someplace, and
# the need to delay shouldn't be requred.
ruby_block "delayed service registry" do
  block do
    Services::Connection.new run_context: run_context

    member1 = Services::Member.new "member1",
      service: "testing",
      port: 1024,
      proto: "tcp",
      ip: "127.0.0.2"

    member2 = Services::Member.new "member2",
      service: "testing",
      port: 1024,
      proto: "tcp",
      ip: "127.0.0.3"

    endpoint = Services::Endpoint.new "testing",
      ip: "127.0.0.10",
      port: 80,
      proto: "https"


    service  = Services::Service.new("testing")
    member1.save
    member2.save
    endpoint.save
    Chef::Log.info "SERVICE: #{service.inspect}"

  end
end
