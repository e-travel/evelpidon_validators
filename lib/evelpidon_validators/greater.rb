module ActiveModel
  module Validations
    class GreaterValidator < EachValidator
      def self.greater?(value, than)
        value.present? and than.present? and value > than
      end

      def validate_each(record, attribute, value)
        unless self.class.greater? value, record.send(options[:than])
          record.errors.add(attribute, :greater, options)
        end
      end
    end
  end
end

module ClientSideValidations::Middleware
  class Greater < Base
    def response
      self.status = ActiveModel::Validations::GreaterValidator.greater?(request.params[:value], request.params[:than]) ? 200 : 404
      super
    end
  end
end if defined?(ClientSideValidations)
