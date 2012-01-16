require 'credit_card_validator'

if defined?(Rails) && Rails.env == 'development'
  ::CreditCardValidator::Validator.options[:test_numbers_are_valid] = true
end

module ActiveModel
  module Validations
    class CreditCardValidator < EachValidator
      def self.valid_credit_card?(number, type)
        ::CreditCardValidator::Validator.options[:allowed_card_types] = [(type || '').underscore.to_sym]
        ::CreditCardValidator::Validator.valid?(number)
      end

      def validate_each(record, attribute, value)
        if options[:type]
          warn "The :type option has been deprecated, please use :type_attribute instead."
          options[:type_attribute] ||= options[:type]
        end
        unless self.class.valid_credit_card? value, record.send(options[:type_attribute])
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
