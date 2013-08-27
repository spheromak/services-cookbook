module Services
  # service container
  class Service

    attr :name
    attr :members
    attr :endpoint

    def initialize(name)
      @name = name
      @members = []

      create_if_missing
      load_members
      load_endpoint
    end

    private

    def create_if_missing
      begin
        s = Services.get "#{KEY}/#{name}"
      rescue Net::HTTPServerException => e
        puts "rescued"
        if e.message.match "Not Found"
          puts "rescued; create #{KEY}/#{name}/_created -> #{Time.now}"
          Services.set "#{KEY}/#{name}/_created", Time.now
        end
      end
    end

    def load_endpoint
      endpoint = Services::Endpoint.new name
      endpoint.load
    end

    def load_members
      begin
        m = Services.get "#{KEY}/#{name}/members"
      rescue
        m = nil
      end
      unless m.nil? or m.empty?
        m.each do |m|
          m_name = File.basename m["key"]
          m1 = Services::Member.new(m_name, service: name).load
          members.push m1
        end
      end
    end
  end
end
