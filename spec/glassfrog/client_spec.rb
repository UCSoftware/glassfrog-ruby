require 'spec_helper'

TEST_CACHE = "./tmp/test"

describe Glassfrog::Client do
  describe '#initialize' do
    after do
      FileUtils.rm_rf(TEST_CACHE) if File.exist?(TEST_CACHE)
    end

    it 'should instantiate with a string (API Key) as attrs' do
      client = Glassfrog::Client.new(TestCredentials::API_KEY)
      array_of_circles = client.get :circle
      expect(array_of_circles).to all(be_a(Glassfrog::Circle))
    end
    it 'should instantiate with a hash (including API Key) as attrs' do
      client = Glassfrog::Client.new({ api_key: TestCredentials::API_KEY })
      array_of_circles = client.get :circles
      expect(array_of_circles).to all(be_a(Glassfrog::Circle))
    end
    it 'should instantiate with a block (including API Key)' do
      client = Glassfrog::Client.new do |client|
        client.api_key = TestCredentials::API_KEY
      end
      array_of_circles = client.get 'circle'
      expect(array_of_circles).to all(be_a(Glassfrog::Circle))
    end
    it 'should raise an ArgumentError with invalid value as attrs' do
      expect { Glassfrog::Client.new(1) }.to raise_error(ArgumentError)
    end

    it 'should instantiate with caching when caching is set to true' do
      client = Glassfrog::Client.new do |client|
        client.caching = true
        client.api_key = TestCredentials::API_KEY
      end
      array_of_circles = client.get 'circle'
      expect(array_of_circles).to all(be_a(Glassfrog::Circle))
      expect(File.directory?("./var/cache")).to be true
    end

    it 'should not instantiate when caching flag is false, but caching_settings are set' do
      client = Glassfrog::Client.new do |client|
        client.caching = false
        client.caching_settings = {
            metastore: "file:" + TEST_CACHE + "/cache/meta",
          entitystore: "file:" + TEST_CACHE + "/cache/entity"
        }
        client.api_key = TestCredentials::API_KEY
      end
      array_of_circles = client.get 'circle'
      expect(array_of_circles).to all(be_a(Glassfrog::Circle))
      expect(File.directory?(TEST_CACHE + "/cache")).to be false
    end

    it 'should instantiate when caching_settings are set' do
      client = Glassfrog::Client.new do |client|
        client.caching_settings = {
            metastore: "file:" + TEST_CACHE + "/cache/meta",
          entitystore: "file:" + TEST_CACHE + "/cache/entity"
        }
        client.api_key = TestCredentials::API_KEY
      end
      array_of_circles = client.get 'circle'
      expect(array_of_circles).to all(be_a(Glassfrog::Circle))
      expect(File.directory?(TEST_CACHE + "/cache")).to be true
    end
  end

  describe '#caching=' do
    it 'should raise an error if @caching is already set' do
      client = Glassfrog::Client.new do |client|
        client.caching = false
        client.api_key = TestCredentials::API_KEY
      end
      expect { client.caching = true }.to raise_error(ArgumentError)
    end
  end

  describe '#caching_settings=' do
    it 'should raise an error if @caching is already set' do
      client = Glassfrog::Client.new do |client|
        client.caching_settings = {
              metastore: "file:" + TEST_CACHE + "/cache/meta",
            entitystore: "file:" + TEST_CACHE + "/cache/entity"
        }
        client.api_key = TestCredentials::API_KEY
      end
      expect { client.caching_settings = {
              metastore: "file:" + TEST_CACHE + "/cache/meta",
            entitystore: "file:" + TEST_CACHE + "/cache/entity"
        } }.to raise_error(ArgumentError)
    end
  end
end
