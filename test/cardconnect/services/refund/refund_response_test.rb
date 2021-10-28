require 'test_helper'

describe CardConnect::Service::RefundResponse do
  before do
    @response = CardConnect::Service::RefundResponse.new(valid_refund_response)
  end

  after do
    @response = nil
  end

  describe 'FIELDS' do
    it 'should have the merchant id' do
      expect(@response.merchid).must_equal '000000927996'
    end

    it 'should have the Amount' do
      expect(@response.amount).must_equal '59.60'
    end

    it 'should have the Retrieval Reference Number' do
      expect(@response.retref).must_equal '288010185242'
    end

    it 'should have the Response Code' do
      expect(@response.respcode).must_equal '00'
    end

    it 'should have the Response Processor' do
      expect(@response.respproc).must_equal 'PPS'
    end

    it 'should have the status' do
      expect(@response.respstat).must_equal 'A'
    end

    it 'should have the Response text' do
      expect(@response.resptext).must_equal 'Approval'
    end

    it 'should have authcode' do
      expect(@response.authcode).must_equal 'REFUND'
    end
  end

  describe '#success?' do
    it 'should be true when there are no errors' do
      expect(@response.success?).must_equal true
    end

    it 'should be false when there are errors' do
      refund_response = valid_refund_response.merge!('respstat' => 'C', 'resptext' => 'this is an error')
      response = CardConnect::Service::RefundResponse.new(refund_response)
      expect(response.success?).must_equal false
    end
  end

  describe '#errors' do
    it 'should be empty when there are no errors' do
      expect(@response.errors).must_be_empty
    end

    it 'should be an array of error messages when there are errors' do
      refund_response = valid_refund_response.merge!('respstat' => 'C', 'resptext' => 'this is an error')
      response = CardConnect::Service::RefundResponse.new(refund_response)
      expect(response.errors).must_equal ['this is an error']
    end
  end

  describe '#body' do
    it 'should generate hash with all the right values' do
      expect(@response.body).must_equal symbolize_keys(valid_refund_response)
    end
  end
end
