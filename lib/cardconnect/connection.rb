require 'faraday'
require 'faraday_middleware'

module CardConnect
  class Connection

    attr_reader :config

    def initialize(config = CardConnect.configuration)
      @config = config
    end

    def connection
      @connection ||= Faraday.new(faraday_options) do |f|
        f.request :basic_auth, :basic, @config.api_username, @config.api_password
        f.request :json

        f.response :json, content_type: /\bjson$/
        f.response :raise_error

        f.adapter Faraday.default_adapter
      end
    end

    def ping_server
      connection.get('/cardconnect/rest/')
    rescue Faraday::ResourceNotFound => e
      return e
    rescue Faraday::ClientError => e
      return e
    end

    def faraday_options
      {
        url: @config.endpoint,
        headers: {
          user_agent: "CardConnectRubyGem/#{CardConnect::VERSION}"
        },
      }.merge(@config.connection_options)
    end

    def validate_mid
      connection.put('/cardconnect/rest/', { merchid: @config.merchant_id})
      true
    rescue Faraday::ClientError => e
      false
    end
  end
end
