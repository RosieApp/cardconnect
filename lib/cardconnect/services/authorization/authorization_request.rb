# frozen_string_literal: true

module CardConnect
  module Service
    class AuthorizationRequest
      include Utils

      REQUIRED_FIELDS = %i[merchid account expiry amount currency].freeze

      OPTIONAL_FIELDS = %i[
        accttype name address city region country phone postal email
        cof cofscheduled ecomind cvv2 orderid track bankaba
        tokenize termid capture ssnl4 license profile userfields
        ponumber authcode invoiceid taxamnt
      ].freeze

      FIELDS = REQUIRED_FIELDS + OPTIONAL_FIELDS

      # cof: transaction initiated by the customer (C) or merchant (M)
      # cofscheduled: is the payment scheduled?
      # ecomind: telephone, recurring, or ecommerce
      OPTIONAL_FIELD_VALUES = {
        cof: %w[C M],
        cofscheduled: %w[Y N],
        ecomind: %w[T R E]
      }.freeze

      attr_accessor(*FIELDS)
      attr_reader :errors

      # Initializes a new Authorization Request
      #
      # @param attrs [Hash]
      # @return CardConnect::AuthorizationRequest
      def initialize(attrs = {})
        @errors = []
        set_attributes(attrs, FIELDS)
        validate_required_fields
        validate_optional_fields
      end

      # Indicates that the request is valid once it is built.
      def valid?
        errors.empty?
      end

      # Builds the request payload
      def payload
        payload = {}
        FIELDS.each do |field|
          payload.merge!(field => send(field))
        end
        payload
      end

      private

      def validate_required_fields
        REQUIRED_FIELDS.each do |field|
          value = send(field)
          value.nil? || value.empty? ? errors.push("#{field.capitalize} is missing") : next
        end
      end

      def validate_optional_fields
        OPTIONAL_FIELD_VALUES.each_pair do |field, values|
          value = send(field)
          next if value.nil? || value.empty?

          unless values.include?(value)
            errors.push("Invalid value for #{field}: must be one of #{values.join(', ')}")
          end
        end
      end
    end
  end
end
