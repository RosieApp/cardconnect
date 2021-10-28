require 'test_helper'

describe CardConnect::Service::Profile do

  describe 'GET profile' do
    before do
      @connection = CardConnect::Connection.new
      @connection.connection do |stubs|
        path = "#{@service.path}/#{valid_profile_request['profileid']}/#{valid_profile_request['acctid']}/#{valid_profile_request['merchid']}"
        stubs.get(path) { [200, {}, valid_profile_get_response] }
      end
      @service = CardConnect::Service::Profile.new('get', @connection)
    end

    after do
      @service = nil
    end

    it 'must have the right path' do
      expect(@service.path).must_equal '/cardconnect/rest/profile'
    end

    describe '#build_request' do
      before do
        @valid_params = valid_profile_request
      end

      after do
        @valid_params = nil
      end

      it 'creates a profile request object with the passed in params' do
        @service.build_request(@valid_params)

        expect(@service.request).must_be_kind_of CardConnect::Service::ProfileGetRequest
        expect(@service.request.acctid).must_equal '1'
        expect(@service.request.merchid).must_equal '000000927996'
      end

      it 'uses default merchant ID if merchid is not passed in' do
        @service.build_request(@valid_params.reject! { |k, _| k == 'merchid' })
        expect(@service.request).must_be_kind_of CardConnect::Service::ProfileGetRequest
        expect(@service.request.merchid).must_equal 'merchant123'
      end
    end

    describe '#submit' do
      it 'raises an error when there is no request' do
        expect(@service.request.nil?).must_equal true
        expect(proc { @service.submit }).must_raise CardConnect::Error
      end

      it 'creates a response when a valid request is processed' do
        @service.build_request(valid_profile_request)
        @service.submit
        expect(@service.response).must_be_kind_of CardConnect::Service::ProfileGetResponse
      end
    end
  end

  describe 'DELETE profile' do
    before do
      @connection = CardConnect::Connection.new
      @connection.connection do |stubs|
        path = "#{@service.path}/#{valid_profile_request['profileid']}/#{valid_profile_request['acctid']}/#{valid_profile_request['merchid']}"
        stubs.delete(path) { [200, {}, valid_profile_delete_response] }
      end
      @service = CardConnect::Service::Profile.new('delete', @connection)
    end

    after do
      @service = nil
    end

    it 'must have the right path' do
      expect(@service.path).must_equal '/cardconnect/rest/profile'
    end

    describe '#build_request' do
      before do
        @valid_params = valid_profile_request
      end

      after do
        @valid_params = nil
      end

      it 'creates a profile request object with the passed in params' do
        @service.build_request(@valid_params)

        expect(@service.request).must_be_kind_of CardConnect::Service::ProfileDeleteRequest
        expect(@service.request.acctid).must_equal '1'
        expect(@service.request.merchid).must_equal '000000927996'
      end

      it 'uses default merchant ID if merchid is not passed in' do
        @service.build_request(@valid_params.reject! { |k, _| k == 'merchid' })
        expect(@service.request).must_be_kind_of CardConnect::Service::ProfileDeleteRequest
        expect(@service.request.merchid).must_equal 'merchant123'
      end
    end

    describe '#submit' do
      it 'raises an error when there is no request' do
        expect(@service.request.nil?).must_equal true
        expect(proc { @service.submit }).must_raise CardConnect::Error
      end

      it 'creates a response when a valid request is processed' do
        @service.build_request(valid_profile_request)
        @service.submit
        expect(@service.response).must_be_kind_of CardConnect::Service::ProfileDeleteResponse
      end
    end
  end

  describe 'CREATE/UPDATE profile' do
    before do
      @connection = CardConnect::Connection.new
      @connection.connection do |stubs|
        stubs.put(@service.path) { [200, {}, valid_profile_put_response] }
      end
      @service = CardConnect::Service::Profile.new('put', @connection)
    end

    after do
      @service = nil
    end

    it 'must have the right path' do
      expect(@service.path).must_equal '/cardconnect/rest/profile'
    end

    describe '#build_request' do
      before do
        @valid_params = valid_profile_request
      end

      after do
        @valid_params = nil
      end

      it 'creates a profile request object with the passed in params' do
        @service.build_request(@valid_params)

        expect(@service.request).must_be_kind_of CardConnect::Service::ProfilePutRequest
        expect(@service.request.merchid).must_equal '000000927996'
        expect(@service.request.profileid).must_equal '12345678901234567890'
      end

      it 'uses default merchant ID if merchid is not passed in' do
        @service.build_request(@valid_params.reject! { |k, _| k == 'merchid' })
        expect(@service.request).must_be_kind_of CardConnect::Service::ProfilePutRequest
        expect(@service.request.merchid).must_equal 'merchant123'
      end
    end

    describe '#submit' do
      it 'raises an error when there is no request' do
        expect(@service.request.nil?).must_equal true
        expect(proc { @service.submit }).must_raise CardConnect::Error
      end

      it 'creates a response when a valid request is processed' do
        @service.build_request(valid_profile_request)
        @service.submit
        expect(@service.response).must_be_kind_of CardConnect::Service::ProfilePutResponse
      end
    end
  end
end
