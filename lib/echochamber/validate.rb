module Echochamber

  class InvalidCredentialError < StandardError; end

  module Validate

    def self.user(params)
      @params = params
      @required_fields = [:firstName, :lastName, :email, :password]
      self.validate
      params
    end



    private 

    def self.validate
      @required_fields.each do |field|
        self.validate_field(field) 
      end
    end

    def self.validate_field(field)
      begin
        @params.fetch(field)
      rescue KeyError
        raise InvalidCredentialError, "Could not retrieve required field #{field.to_s}"
      end
    end

  end

end
