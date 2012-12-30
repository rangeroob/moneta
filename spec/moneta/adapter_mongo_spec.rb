# Generated by generate.rb
require 'helper'

describe_moneta "adapter_mongo" do
  def new_store
    Moneta::Adapters::Mongo.new(:db => "adapter_mongo")
  end

  def load_value(value)
    Marshal.load(value)
  end

  include_context 'setup_store'
  it_should_behave_like 'expires'
  it_should_behave_like 'increment'
  it_should_behave_like 'null_stringkey_stringvalue'
  it_should_behave_like 'persist_stringkey_stringvalue'
  it_should_behave_like 'returndifferent_stringkey_stringvalue'
  it_should_behave_like 'store_stringkey_stringvalue'
  it 'automatically deletes expired document' do
    store.store('key', 'val', :expires => 30)
    store.instance_variable_get(:@collection).find_one('_id' => ::BSON::Binary.new('key')).should_not be_nil
    sleep 70 # Mongo needs up to 60 seconds
    store.instance_variable_get(:@collection).find_one('_id' => ::BSON::Binary.new('key')).should be_nil
  end
end
