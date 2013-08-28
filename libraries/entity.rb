module Services
  # entity base class.
  # member,service,endpoint are all "services::entity"
  class Entity
    attr :name, :path
    def initialize(name, args = {})
      @name = name
      validate
    end

    def store
      _store
    end
    alias_method :save, :store

    def load
      _load
    end

    def to_hash
      vars = Hash.new
      instance_variables.each do |name|
        key = name[1..-1].to_s
        # don't store "path"
        next if key == "path"
        vars[key] =  instance_variable_get(name).to_s
      end
      vars
    end

    private

    def validate
      unless path
        raise RuntimeError, "This class should be extended. Not used directly"
      end
    end

    def _store
      to_hash.each do |k, v|
        next if k == "name"
        # etcd doesn't like nil
        v ||= ""
        Services.set "#{KEY}/#{path}/#{k}", v
      end
    end

    def _load
      return unless valid_path
      to_hash.each do |k, v|
        next if k == "name"
        value =  Services.get("#{KEY}/#{path}/#{k}").value || nil
        self.send "#{k}=", value.to_s
      end
    end

    def valid_path
      begin
        Services.get("#{KEY}/#{path}")
      rescue
        return false
      end
      true
    end

  end
end
