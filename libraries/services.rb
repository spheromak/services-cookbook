#
# Services Module
#
#  Uses etcd to manage state of Service Endpoint & Members
#
module Services
  require_relative "connection"
  require_relative "entity"
  require_relative "service"
  require_relative "endpoint"
  require_relative "member"

  # this will  change or be slurped up from a config/node attrib
  KEY="/services"
  VERSION="1.0"

  #
  # Share a connection between all classess using this module
  #
  class << self
    attr_accessor :connection, :run_context

    def get(*args)
      Chef::Log.debug "connection.get args #{args}"
      connection.get *args
    end

    def set(*args)
      Chef::Log.debug "connection.set args #{args}"
      connection.set *args
    end

    # return a list of all services
    def all
      services = Array.new
      get(KEY).each do |s|
        name = File.basename s.key
        services << Services::Service.new(name)
      end
      services
    end

    # return all services a node is subscribed to
    def subscribed f=nil
      if f.nil? and run_context.nil?
          raise "param and run_context can not both be nil"
      end

      fqdn = f.nil? ? rteraun_context.node.fqdn : f
      services = all.map { |s| s.members.include?(fqdn) ? s : nil }
      services.compact
    end
  end
end
