module Echochamber

  class User

    def initialize(params)
      @params = params
      to_hash
    end

    def to_hash
      required_fields.merge(optional_fields)
    end

    private 

    def params
      @params
    end

    def required_fields
      {
        firstName: fetch_required_field(:first_name),
        lastName:  fetch_required_field(:last_name),
        email:     fetch_required_field(:email), 
        password:  fetch_required_field(:password)
      }
    end

    def optional_fields
      {
        phone: fetch_optional_field(:phone),
        title: fetch_optional_field(:title)
      }
    end

    def fetch_required_field(field)
      begin
        params.fetch(field)
      rescue KeyError
        raise EchoChamber::InvalidCredentialError
      end
    end

    def fetch_optional_field(field)
      params.fetch(field.to_sym, nil)
    end

  end

end
