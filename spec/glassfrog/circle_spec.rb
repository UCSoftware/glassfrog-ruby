require 'spec_helper'

describe Glassfrog::Circle do
  before :context do
    @client = Glassfrog::Client.new(TestCredentials::API_KEY)
  end

  describe '#get' do
    before :context do
      @circle = @client.get(:circles).sample
    end

    it 'returns array of circle objects with singular symbol as type' do
      array_of_circles = @client.get :circle
      expect(array_of_circles).to all(be_a(Glassfrog::Circle))
    end
    it 'returns array of circle objects with plural symbol as type' do
      array_of_circles = @client.get :circles
      expect(array_of_circles).to all(be_a(Glassfrog::Circle))
    end
    it 'returns array of circle objects with singular string as type' do
      array_of_circles = @client.get 'circle'
      expect(array_of_circles).to all(be_a(Glassfrog::Circle))
    end
    it 'returns array of circle objects with plural string as type' do
      array_of_circles = @client.get 'circles'
      expect(array_of_circles).to all(be_a(Glassfrog::Circle))
    end

    it 'returns array of circle objects with string as options' do
      array_of_circles = @client.get :circle, "#{@circle.id}"
      expect(array_of_circles).to all(be_a(Glassfrog::Circle))
    end
    it 'returns array of circle objects with integer as options' do
      array_of_circles = @client.get :circle, @circle.id
      expect(array_of_circles).to all(be_a(Glassfrog::Circle))
    end

    it 'returns array of circle objects with id in hash as options' do
      array_of_circles = @client.get :circle, { id: @circle.id }
      expect(array_of_circles).to all(be_a(Glassfrog::Circle))
    end
    it 'returns array of circle objects with circle object as options' do
      array_of_circles = @client.get :circle, @circle
      expect(array_of_circles).to all(be_a(Glassfrog::Circle))
    end

    it 'returns array of all circle objects with no options' do
      array_of_circles = @client.get :circle
      expect(array_of_circles).to all(be_a(Glassfrog::Circle))
    end

    it 'raises error with unassociated object as options' do
      expect { @client.get :circle, Glassfrog::Metric.new }.to raise_error(ArgumentError)
    end
    it 'raises error with invalid type as options' do
      expect { @client.get :circle, true }.to raise_error(ArgumentError)
    end
  end
end
