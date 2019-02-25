require 'date'

module CardConnect
  module Service
    class SettlementStatusRequest
      include Utils

      REQUIRED_FIELDS = [:merchid].freeze

      FIELDS = REQUIRED_FIELDS + [:date, :batchid]

      attr_accessor(*FIELDS)
      attr_reader :errors

      # Initializes a new Settlement Status Request
      #
      # @param attrs [Hash]
      # @return CardConnect::SettlementStatusRequest
      def initialize(attrs = {})
        @errors = []
        set_attributes(attrs, FIELDS)
        validate_required_fields
      end

      # Indicates that the request is valid once it is built.
      def valid?
        errors.empty?
      end

      # Builds the request payload
      def payload
        payload = '?'
        FIELDS.each do |field|
          if value = send(field)
            payload += "#{field}=#{value}&"
          end
        end
        payload
      end

      private

      def validate_required_fields
        validate_presence_of_required_fields
        validate_date_format unless date.nil? || date.empty?
      end

      def validate_presence_of_required_fields
        REQUIRED_FIELDS.each do |field|
          value = send(field)
          value.nil? || value.empty? ? errors.push("#{field.capitalize} is missing") : next
        end
      end

      def validate_date_format
        raise if date.length != 4
        Date.parse(date, '%m%d')
      rescue
        errors.push('Date format is invalid. Please use MMDD format')
      end
    end
  end
end
