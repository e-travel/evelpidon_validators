require 'credit_card_validator'

if defined?(Rails) && !Rails.env.production?
  ::CreditCardValidator::Validator.options[:test_numbers_are_valid] = true
end

module ActiveModel
  module Validations
    class CreditCardValidator < EachValidator
      def initialize(options)
        if options[:type]
          warn "The :type option has been deprecated, please use :type_attribute instead."
          options[:type_attribute] ||= options[:type]
        end

        super
      end

      def self.valid_credit_card?(number, type)
        return false if number.nil?

        if type
          ::CreditCardValidator::Validator.options[:allowed_card_types] = [type.underscore.to_sym]
        else
          ::CreditCardValidator::Validator.options[:allowed_card_types] = nil
        end
        ::CreditCardValidator::Validator.valid?(number)
      end

      def validate_each(record, attribute, value)
        type = record.send(options[:type_attribute]) if options[:type_attribute]
        unless self.class.valid_credit_card? value, type
          record.errors.add(attribute, :credit_card, options)
        end
      end
    end
  end
end

module ClientSideValidations::Middleware
  class CreditCard < Base
    def response
      self.status = ActiveModel::Validations::CreditCardValidator.valid_credit_card?(request.params[:value], request.params[:type]) ? 200 : 404
      super
    end
  end
end if defined?(ClientSideValidations)
