require 'spec_helper'

describe Glassfrog::Base do
  describe '#==' do
    it 'should return false for two different objects with different IDs' do
      a, b = Glassfrog::Metric.new({id: 1}), Glassfrog::Person.new({id: 2})
      expect(a == b).to be false
    end
    it 'should return false for two different objects with the same IDs' do
      a, b = Glassfrog::Metric.new({id: 1}), Glassfrog::Person.new({id: 1})
      expect(a == b).to be false
    end
    it 'should return false for two of the same objects with different IDs' do
      a, b = Glassfrog::Metric.new({id: 1}), Glassfrog::Metric.new({id: 2})
      expect(a == b).to be false
    end
    it 'should return true for two of the same objects with the same IDs' do
      a, b = Glassfrog::Metric.new({id: 1}), Glassfrog::Metric.new({id: 1})
      expect(a == b).to be true
    end
  end

  describe '#hashify' do
    it 'should return an hash from an object' do
      a = Glassfrog::Metric.new({id: 1})
      expect(a.hashify).to be_a(Hash)
    end
  end
end
