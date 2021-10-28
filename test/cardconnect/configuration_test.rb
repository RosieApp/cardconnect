require 'test_helper'

describe CardConnect::Configuration do
  before do
    @config = CardConnect::Configuration.new
  end

  after do
    @config = nil
  end

  it 'must respond to merchant id' do
    assert @config.respond_to?(:merchant_id)
  end

  it 'must respond to api username' do
    assert @config.respond_to?(:api_username)
  end

  it 'must respond to api password' do
    assert @config.respond_to?(:api_password)
  end

  it 'must respond to endpoint' do
    assert @config.respond_to?(:endpoint)
  end

  it 'must respond to connection_options' do
    assert @config.respond_to?(:connection_options)
  end
end
