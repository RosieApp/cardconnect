require 'test_helper'

describe CardConnect::Service::SettlementStatus do
  before do
    @connection = CardConnect::Connection.new
    @connection.connection do |stubs|
      stubs.get(@service.path) { [200, {}, valid_settlestat_response] }
    end
    @service = CardConnect::Service::SettlementStatus.new(@connection)
  end

  after do
    @service = nil
  end

  it 'must have the right path' do
    expect(@service.path).must_equal '/cardconnect/rest/settlestat'
  end

  describe '#build_request' do
    before do
      @valid_params = valid_settlestat_request_date
    end

    after do
      @valid_params = nil
    end

    it 'creates a Capture request object with the passed in params' do
      @service.build_request(@valid_params)

      expect(@service.request).must_be_kind_of CardConnect::Service::SettlementStatusRequest
      expect(@service.request.merchid).must_equal '000000927996'
      expect(@service.request.date).must_equal '0110'
    end

    it 'uses default merchant ID if merchid is not passed in' do
      @service.build_request(@valid_params.reject! { |k, _| k == 'merchid' })
      expect(@service.request).must_be_kind_of CardConnect::Service::SettlementStatusRequest
      expect(@service.request.merchid).must_equal 'merchant123'
    end
  end

  describe '#submit' do
    it 'raises an error when there is no request' do
      expect(@service.request.nil?).must_equal true
      expect(proc { @service.submit }).must_raise CardConnect::Error
    end

    it 'creates a response when a valid request is processed' do
      @service.build_request(valid_settlestat_request_date)
      @service.submit
      expect(@service.response).must_be_kind_of CardConnect::Service::SettlementStatusResponse
    end
  end
end
