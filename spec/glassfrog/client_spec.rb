require 'spec_helper'

TMP_CACHE = Dir.mktmpdir("tmp-glassfrog-cache-")

describe Glassfrog::Client do
  after :context do
    FileUtils.rm_rf(TMP_CACHE) if File.exist?(TMP_CACHE)
  end
  describe '#initialize' do
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

    it 'should not create a cache when caching is not true' do
      client = Glassfrog::Client.new(TestCredentials::API_KEY)
      expect(client.instance_variable_get("@cache_tmpdir")).to be nil
    end
    it 'should instantiate with caching when caching is set to true' do
      client = Glassfrog::Client.new do |client|
        client.caching = true
        client.api_key = TestCredentials::API_KEY
      end
      array_of_circles = client.get 'circle'
      expect(array_of_circles).to all(be_a(Glassfrog::Circle))
      tmpdir = client.instance_variable_get("@cache_tmpdir")
      expect(File.directory?(tmpdir)).to be true
    end
    it 'should delete the default cache when the finalizer is called' do
      client = Glassfrog::Client.new do |client|
        client.caching = true
        client.api_key = TestCredentials::API_KEY
      end
      tmpdir = client.instance_variable_get("@cache_tmpdir").dup
      expect(File.directory?(tmpdir)).to be true
      Glassfrog::Client.finalize(tmpdir).call
      expect(File.directory?(tmpdir)).to be false
    end
    it 'should not instantiate when caching flag is false, but caching_settings are set' do
      client = Glassfrog::Client.new do |client|
        client.caching = false
        client.caching_settings = {
            metastore: "file:" + TMP_CACHE + "/noncache/meta",
          entitystore: "file:" + TMP_CACHE + "/noncache/entity"
        }
        client.api_key = TestCredentials::API_KEY
      end
      array_of_circles = client.get 'circle'
      expect(array_of_circles).to all(be_a(Glassfrog::Circle))
      expect(File.directory?(TMP_CACHE + "/cache")).to be false
    end
    it 'should instantiate when caching_settings are set' do
      client = Glassfrog::Client.new do |client|
        client.caching_settings = {
            metastore: "file:" + TMP_CACHE + "/cache/meta",
          entitystore: "file:" + TMP_CACHE + "/cache/entity"
        }
        client.api_key = TestCredentials::API_KEY
      end
      array_of_circles = client.get 'circle'
      expect(array_of_circles).to all(be_a(Glassfrog::Circle))
      expect(File.directory?(TMP_CACHE + "/cache")).to be true
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
              metastore: "file:" + TMP_CACHE + "/cache/meta",
            entitystore: "file:" + TMP_CACHE + "/cache/entity"
        }
        client.api_key = TestCredentials::API_KEY
      end
      expect { client.caching_settings = {
              metastore: "file:" + TMP_CACHE + "/cache/meta",
            entitystore: "file:" + TMP_CACHE + "/cache/entity"
        } }.to raise_error(ArgumentError)
    end
  end
end
