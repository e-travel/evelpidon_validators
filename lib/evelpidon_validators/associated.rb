module ActiveModel
  module Validations
    # Shamelessly stolen from:
    # https://github.com/rails/rails/blob/v3.1.1/activerecord/lib/active_record/validations/associated.rb
    #
    # Beware! This validator is not triggered in the client side, however if the association is in a form, client side
    # validations will handle that on its own.
    class AssociatedValidator < EachValidator
      def validate_each(record, attribute, value)
        return if (value.is_a?(Array) ? value : [value]).collect{ |r| r.nil? || r.valid? }.all?
        record.errors.add(attribute, :invalid, options.merge(:value => value))
      end
    end
  end
end
