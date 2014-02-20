require_relative 'entity'

module Services
  class Member < Services::Entity
    attr_accessor :ip, :port, :proto, :service, :weight
    def initialize(name, args = {})
      @ip = args[:ip] || ''
      @proto = args[:proto] || 'http'
      @port  = args[:port]  || 80
      @weight = args[:weight] || 20
      @service = args[:service]
      @path = "#{service}/members/#{name}"
      super
    end

    private

    def validate
      unless @service
        fail ArgumentError,
             "#{self.class} requires service: argument"
      end

      unless name
        fail ARgumentError,
             "#{self.class} requires name argument"
      end
    end
  end
end
