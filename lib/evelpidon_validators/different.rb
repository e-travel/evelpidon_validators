module ActiveModel
  module Validations
    class DifferentValidator < EachValidator
      def self.different?(value, than)
        not value.eql? than
      end

      def validate_each(record, attribute, value)
        unless self.class.different? value, record.send(options[:than])
          record.errors.add(attribute, :different, options)
        end
      end
    end
  end
end

module ClientSideValidations::Middleware
  class Different < Base
    def response
      self.status = ActiveModel::Validations::DifferentValidator.different?(request.params[:value], request.params[:than]) ? 200 : 404
      super
    end
  end
end if defined?(ClientSideValidations)
