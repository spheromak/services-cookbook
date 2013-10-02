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
    attr_accessor :connection

    def get(*args)
      connection.get *args
    end

    def set(*args)
      connection.set *args
    end

    def all
      services = Array.new
      get(KEY).each do |s|
        name = File.basename s.key
        services << Services::Service.new(name)
      end
      services
    end
  end
end
