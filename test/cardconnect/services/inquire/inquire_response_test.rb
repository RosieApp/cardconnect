require 'test_helper'

describe CardConnect::Service::InquireResponse do
  before do
    @response = CardConnect::Service::InquireResponse.new(valid_inquire_response)
  end

  after do
    @response = nil
  end

  describe 'FIELDS' do
    it 'should have merchant id' do
      expect(@response.merchid).must_equal '000000927996'
    end

    it 'should have name' do
      expect(@response.name).must_equal 'TOM JONES'
    end

    it 'should have account' do
      expect(@response.account).must_equal '9418594164541111'
    end

    it 'should have amount' do
      expect(@response.amount).must_equal '596.00'
    end

    it 'should have currency' do
      expect(@response.currency).must_equal 'USD'
    end

    it 'should have retrieval reference number' do
      expect(@response.retref).must_equal '288015190411'
    end

    it 'should have response code' do
      expect(@response.respcode).must_equal '00'
    end

    it 'should have response processor' do
      expect(@response.respproc).must_equal 'FNOR'
    end

    it 'should have response status' do
      expect(@response.respstat).must_equal 'A'
    end

    it 'should have capture status' do
      expect(@response.resptext).must_equal 'Approval'
    end

    it 'should have settlement status' do
      expect(@response.setlstat).must_equal 'Accepted'
    end

    it 'should have token' do
      expect(@response.token).must_equal '9418594164541111'
    end

    it 'should have authdate' do
      expect(@response.authdate).must_equal '20180410'
    end

    it 'should have captureddate' do
      expect(@response.capturedate).must_equal '20180326065748'
    end

    it 'should have lastfour value' do
      expect(@response.lastfour).must_equal '1111'
    end

    it 'should have settledate' do
      expect(@response.settledate).must_equal '20180327143721'
    end
  end

  describe '#body' do
    it 'should generate hash with all the right values' do
      expect(@response.body).must_equal symbolize_keys(valid_inquire_response)
    end
  end
end
