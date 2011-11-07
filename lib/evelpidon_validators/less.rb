module ActiveModel
  module Validations
    class LessValidator < EachValidator
      def self.less?(value, than)
        value.present? and than.present? and value < than
      end

      def validate_each(record, attribute, value)
        unless self.class.less? value, record.send(options[:than]) or (options[:or_equal] && value.eql?(record.send(options[:than])))
          record.errors.add(attribute, :less, options)
        end
      end
    end
  end
end

module ClientSideValidations::Middleware
  class Less < Base
    def response
      self.status = ActiveModel::Validations::LessValidator.less?(request.params[:value], request.params[:than]) ? 200 : 404
      super
    end
  end
end if defined?(ClientSideValidations)
