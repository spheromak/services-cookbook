require_relative "entity"
module Services
  class Endpoint < Services::Entity

    attr_accessor :ip, :port, :proto
    def initialize(name, args = {})
      @ip    = args[:ip] || ""
      @proto = args[:proto] || "http"
      @port  = args[:port]  || 80
      @path  = "#{name}/endpoint"
      @options = args[:options]
      super
    end

    private

    def validate
      unless self.name
        raise RuntimeError, "endpont requires a service name"
      end
    end

  end
end
