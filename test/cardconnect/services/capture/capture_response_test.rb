require 'test_helper'

describe CardConnect::Service::CaptureResponse do
  before do
    @response = CardConnect::Service::CaptureResponse.new(valid_capture_response)
  end

  after do
    @response = nil
  end

  describe 'FIELDS' do
    it 'should have merchant id' do
      expect(@response.merchid).must_equal '000000927996'
    end

    it 'should have account' do
      expect(@response.account).must_equal '41XXXXXXXXXX4113'
    end

    it 'should have amount' do
      expect(@response.amount).must_equal '596.00'
    end

    it 'should have retrieval reference number' do
      expect(@response.retref).must_equal '288002073633'
    end

    it 'should have settlement status' do
      expect(@response.setlstat).must_equal 'Pending'
    end
  end

  describe '#body' do
    it 'should generate hash with all the right values' do
      expect(@response.body).must_equal symbolize_keys(valid_capture_response)
    end
  end
end
