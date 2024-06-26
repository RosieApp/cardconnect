require 'test_helper'

describe CardConnect::Service::ProfileDeleteRequest do
  before do
    @request = CardConnect::Service::ProfileDeleteRequest.new(valid_profile_request)
  end

  after do
    @request = nil
  end

  describe 'FIELDS' do
    it 'should have merchant id' do
      expect(@request.merchid).must_equal '000000927996'
    end

    it 'should have profile id' do
      expect(@request.profileid).must_equal '12345678901234567890'
    end

    it 'should have account id' do
      expect(@request.acctid).must_equal '1'
    end
  end

  describe '#valid?' do
    it 'should not be valid if no attributes are passed in' do
      expect(CardConnect::Service::ProfileDeleteRequest.new.valid?).must_equal false
    end

    it 'should be valid if valid attributes are passed in' do
      expect(CardConnect::Service::ProfileDeleteRequest.new(valid_profile_request).valid?).must_equal true
    end
  end

  describe '#errors' do
    CardConnect::Service::ProfileDeleteRequest::REQUIRED_FIELDS.each do |field|
      field_name = field.to_s.capitalize
      it "should have an error message if #{field_name} is missing" do
        expect(CardConnect::Service::ProfileDeleteRequest.new.errors).must_include "#{field_name} is missing"
      end
    end
  end

  describe '#payload' do
    it 'should generate hash with all the right values' do
      expect(@request.payload).must_equal "/12345678901234567890/1/000000927996"
    end
  end
end
