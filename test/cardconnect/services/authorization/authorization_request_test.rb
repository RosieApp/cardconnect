require 'test_helper'

describe CardConnect::Service::AuthorizationRequest do
  before do
    @request = CardConnect::Service::AuthorizationRequest.new(valid_auth_request)
  end

  after do
    @request = nil
  end

  describe 'FIELDS' do
    it 'should have merchant id' do
      expect(@request.merchid).must_equal '000000927996'
    end

    it 'should have account' do
      expect(@request.account).must_equal '4111111111111111'
    end

    it 'should have expiry' do
      expect(@request.expiry).must_equal '1212'
    end

    it 'should have amount' do
      expect(@request.amount).must_equal '0'
    end

    it 'should have currency' do
      expect(@request.currency).must_equal 'USD'
    end

    it 'should have account type' do
      expect(@request.accttype).must_equal 'VISA'
    end

    it 'should have name' do
      expect(@request.name).must_equal 'TOM JONES'
    end

    it 'should have address' do
      expect(@request.address).must_equal '123 MAIN STREET'
    end

    it 'should have city' do
      expect(@request.city).must_equal 'anytown'
    end

    it 'should have country' do
      expect(@request.country).must_equal 'US'
    end

    it 'should have phone' do
      expect(@request.phone).must_equal '3334445555'
    end

    it 'should have postal' do
      expect(@request.postal).must_equal '55555'
    end

    it 'should have email' do
      expect(@request.email).must_equal 'tom@jones.com'
    end

    it 'should have ecomind' do
      expect(@request.ecomind).must_equal 'E'
    end

    it 'should have cvv2' do
      expect(@request.cvv2).must_equal '123'
    end

    it 'should have order id' do
      expect(@request.orderid).must_equal 'AB-11-9876'
    end

    it 'should have track' do
      expect(@request.track).must_equal 'Y'
    end

    it 'should have bankaba' do
      expect(@request.bankaba).must_equal '1010101'
    end

    it 'should have tokenize' do
      expect(@request.tokenize).must_equal 'Y'
    end

    it 'should have termid' do
      expect(@request.termid).must_equal '12345'
    end

    it 'should have capture' do
      expect(@request.capture).must_equal 'Y'
    end

    it 'should have ssnl4 field' do
      expect(@request.ssnl4).must_equal '1234'
    end

    it 'should have license field' do
      expect(@request.license).must_equal 'CO:1231231234'
    end

    it 'should have profile field' do
      expect(@request.profile).must_equal 'Y'
    end

    it 'should have ponumber field' do
      expect(@request.ponumber).must_equal '1234'
    end

    it 'should have authcode field' do
      expect(@request.authcode).must_equal '123456'
    end

    it 'should have invoiceid field' do
      expect(@request.invoiceid).must_equal '000000000001'
    end

    it 'should have taxamnt field' do
      expect(@request.taxamnt).must_equal '0'
    end

    describe 'userfields' do
      it 'should be an array of name-value pairs' do
        expect(@request.userfields).must_be_kind_of Array
        expect(@request.userfields.first).must_be_kind_of Hash
        expect(@request.userfields.first['name0']).must_equal 'value0'
      end
    end
  end

  describe '#valid?' do
    it 'should not be valid if no attributes are passed in' do
      refute CardConnect::Service::AuthorizationRequest.new.valid?
    end

    it 'should be valid if valid attributes are passed in' do
      assert CardConnect::Service::AuthorizationRequest.new(valid_auth_request).valid?
    end

    it 'should not be valid if a field has an invalid value' do
      data = valid_auth_request.dup.merge(cof: 'bad')
      request = CardConnect::Service::AuthorizationRequest.new(data)
      expect(request.valid?).must_equal false
      expect(request.errors).must_include('Invalid value for cof: must be one of C, M')
    end
  end

  describe '#errors' do
    CardConnect::Service::AuthorizationRequest::REQUIRED_FIELDS.each do |field|
      field_name = field.to_s.capitalize
      it "should have an error message if #{field_name} is missing" do
        expect(CardConnect::Service::AuthorizationRequest.new.errors).must_include "#{field_name} is missing"
      end
    end
  end

  describe '#payload' do
    it 'should generate hash with all the right values' do
      expect(@request.payload).must_equal symbolize_keys(valid_auth_request)
    end
  end
end
