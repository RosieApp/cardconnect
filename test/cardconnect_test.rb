require 'test_helper'

describe CardConnect do
  it 'must respond to configure' do
    expect(CardConnect).must_respond_to :configure
  end

  describe 'configuration' do
    it 'must return instance of Configuration' do
      expect(CardConnect.configuration).must_be_kind_of CardConnect::Configuration
    end
  end
end
