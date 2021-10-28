require 'test_helper'

describe CardConnect::Service::Bin do
  before do
    @connection = CardConnect::Connection.new
    @connection.connection do |stubs|
      path = "#{@service.path}/#{valid_bin_request['merchid']}/#{valid_bin_request['token']}"
      stubs.get(path) { [200, {}, valid_bin_response] }
    end
    @service = CardConnect::Service::Bin.new(@connection)
  end

  after do
    @service = nil
  end

  it 'must have the right path' do
    expect(@service.path).must_equal '/cardconnect/rest/bin'
  end

  describe '#build_request' do
    before do
      @valid_params = valid_bin_request
    end

    after do
      @valid_params = nil
    end

    it 'creates a bin request object with the passed in params' do
      @service.build_request(@valid_params)

      expect(@service.request).must_be_kind_of CardConnect::Service::BinRequest
      expect(@service.request.token).must_equal '9477709629051443'
      expect(@service.request.merchid).must_equal '000000927996'
    end

    it 'uses default merchant ID if merchid is not passed in' do
      @service.build_request(@valid_params.reject! { |k, _| k == 'merchid' })
      expect(@service.request).must_be_kind_of CardConnect::Service::BinRequest
      expect(@service.request.merchid).must_equal 'merchant123'
    end
  end

  describe '#submit' do
    it 'raises an error when there is no request' do
      expect(@service.request.nil?).must_equal true
      expect(proc { @service.submit }).must_raise CardConnect::Error
    end

    it 'creates a response when a valid request is processed' do
      @service.build_request(valid_bin_request)
      @service.submit
      expect(@service.response).must_be_kind_of CardConnect::Service::BinResponse
    end
  end
end
