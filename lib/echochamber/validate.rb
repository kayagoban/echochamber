module Echochamber

  class InvalidParameterError < StandardError; end

  module Validate

    def self.user(params)
      @required_fields = [:firstName, :lastName, :email, :password]
      @params = params
      validate
    end

    def self.validate
      @required_fields.each do |field|
        validate_field(field) 
      end
    end

    private 

    def self.validate_field(field)
      begin
        value = @params.fetch(field)
        raise_error(field) if value.nil? || value.empty?
      rescue KeyError
        raise_error(field)
      end
    end

    def self.raise_error(field)
      raise InvalidParameterError, "Invalid required parameter: #{field.to_s}"
    end

  end

end
