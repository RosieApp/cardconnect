require 'test_helper'

describe CardConnect::Service::ProfileDeleteResponse do
  before do
    @response = CardConnect::Service::ProfileDeleteResponse.new(valid_profile_delete_response)
  end

  after do
    @response = nil
  end

  describe 'FIELDS' do
    it 'should have response text' do
      expect(@response.resptext).must_equal 'Profile Deleted'
    end

    it 'should have the response code' do
      expect(@response.respcode).must_equal '08'
    end

    it 'should have the respproc' do
      expect(@response.respproc).must_equal 'PPS'
    end

    it 'should have response status' do
      expect(@response.respstat).must_equal 'A'
    end

    it 'should have profileid' do
      expect(@response.profileid).must_equal '12345678901234567890'
    end

    it 'should have acctid' do
      expect(@response.acctid).must_equal '1'
    end
  end

  describe '#success?' do
    it 'should be true when there are no errors' do
      expect(@response.success?).must_equal true
    end

    it 'should be false when there are errors' do
      prof_response = valid_profile_delete_response.merge!('respstat' => 'C', 'resptext' => 'this is an error')
      response = CardConnect::Service::ProfileDeleteResponse.new(prof_response)
      expect(response.success?).must_equal false
    end
  end

  describe '#errors' do
    it 'should be empty when there are no errors' do
      expect(@response.errors).must_be_empty
    end

    it 'should be an array of error messages when there are errors' do
      prof_response = valid_profile_delete_response.merge!('respstat' => 'C', 'resptext' => 'this is an error')
      response = CardConnect::Service::ProfileDeleteResponse.new(prof_response)
      expect(response.errors).must_equal ['this is an error']
    end
  end

  describe '#body' do
    it 'should generate hash with all the right values' do
      expect(@response.body).must_equal symbolize_keys(valid_profile_delete_response)
    end
  end
end
