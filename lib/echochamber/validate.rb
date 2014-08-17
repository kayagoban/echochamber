module Echochamber

  class RequiredParameterError < StandardError; end
  class ParameterError < StandardError; end

  module Validator

   def self.require(required_fields, params)
      @params = params
      required_fields.each do |field|
        validate_field(field) 
      end
   end

   def self.require_exactly_one(field_group, params)
     @params = params
     set_fields = 0
     field_group.each do |field|
       begin
         validate_field(field) 
       rescue RequiredParameterError
         next
       else
         set_fields += 1
       end
     end
     raise ParameterError, "Exactly one of #{field_group.to_s} should be present" if set_fields != 1
   end

   # lambda / yield over here
   # def self.require_conditionally(field, params)
   # end

   private 

   def self.validate_field(field)
     begin
       value = @params.fetch(field)
       required_error(field) if value.nil? || value.empty?
     rescue KeyError
       required_error(field)
     end
   end

   def self.required_error(field)
     raise RequiredParameterError, "Nil, empty or missing required parameter: #{field.to_s}"
   end

  end

end
