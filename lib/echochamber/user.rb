module Echochamber

  class User

    def initialize(params)
      begin
        @first_name = params.fetch(:first_name)
        @last_name  = params.fetch(:last_name)
        @email      = params.fetch(:email)
        @password   = params.fetch(:password)
        @params     = params
      rescue KeyError
        raise EchoChamber::InvalidCredentialError
      end
    end

    def to_hash
      params
    end


  end

end
