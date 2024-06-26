require 'test_helper'

describe CardConnect::Connection do
  before do
    @connection = CardConnect::Connection.new.connection
  end

  after do
    @connection = nil
  end

  describe '#connection' do
    it 'must have user agent in the headers' do
      expect(@connection.headers['User-Agent']).must_equal "CardConnectRubyGem/#{CardConnect::VERSION}"
    end

    it 'must have a URL that matches the configured endpoint' do
      expect(@connection.url_prefix.host).must_equal URI.parse(CardConnect.configuration.endpoint).host
      expect(@connection.url_prefix.scheme).must_equal 'https'
    end

    describe 'Faraday handlers' do
      it 'must have a handler for basic authentication first' do
        expect(@connection.builder.handlers.first).must_be :===, Faraday::Request::Authorization
      end

      it 'must have a handler for encoding the request as json second' do
        expect(@connection.builder.handlers[1]).must_be :===, Faraday::Request::Json
      end

      it 'must have a handler for parsing the json response third' do
        expect(@connection.builder.handlers[2]).must_be :===, Faraday::Response::Json
      end

      it 'has ssl verification on by default' do
        assert(@connection.ssl.verify?)
      end

      it 'has the ability to accept ssl options' do
        config = CardConnect.configuration.dup
        config.connection_options = { ssl: { verify: false } }
        connection = CardConnect::Connection.new(config).connection
        refute(connection.ssl.verify)
      end
    end
  end
end
