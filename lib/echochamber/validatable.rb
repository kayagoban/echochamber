module Echochamber

  class RequiredParameterError < StandardError; end
  class ParameterError < StandardError; end

  module Validatable

    def require_keys(required_fields, params)
      required_fields.each do |field|
        validate_field(field, params) 
      end
    end

    def require_exactly_one(field_group, params)
      set_fields = 0
      field_group.each do |field|
        begin
          validate_field(field, params) 
        rescue RequiredParameterError
          next
        else
          set_fields += 1
        end
      end
      raise ParameterError, "Exactly one of #{field_group.to_s} should be present" if set_fields != 1
    end

    # TODO (kayagoban) A validator accepting a block for conditional execution
    # might be useful.  
    # Maybe require_keys should accept a block.  Figure out later.

    def validate_field(field, params)
      begin
        value = params.fetch(field)
        required_error(field) if value.nil? || value.empty?
      rescue KeyError
        required_error(field)
      end
    end

    private

    def required_error(field)
      raise RequiredParameterError, "Nil, empty or missing required parameter: #{field.to_s}"
    end

  end

end
