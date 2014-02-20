module Services
  # service container
  class Service
    attr_reader :name
    attr_reader :members
    attr_reader :endpoint

    def initialize(name)
      @name = name
      @members = []
      @endpoint = Services::Endpoint.new name

      create_if_missing
      load_members
      load_endpoint
    end

    private

    def create_if_missing
      Services.get "#{KEY}/#{name}"
    rescue Net::HTTPServerException => e
      if e.message.match 'Not Found'
        Services.set "#{KEY}/#{name}/_created", Time.now
      end
    end

    def load_endpoint
      endpoint.load
      endpoint
    end

    def load_members
      etcd_members = load_etcd_members
      unless etcd_members.nil? || etcd_members.empty?
        etcd_members.each do |m|
          m_name = File.basename m.key
          m1 = Services::Member.new(m_name, service: name)
          m1.load
          members.push m1
        end
      end
    end

    private

    def load_etcd_members
      Services.get "#{KEY}/#{name}/members"
    rescue
      nil
    end
  end
end
