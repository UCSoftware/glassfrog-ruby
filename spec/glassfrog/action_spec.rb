require 'spec_helper'

describe Glassfrog::Action do
  before :context do
    @client = Glassfrog::Client.new(TestCredentials::API_KEY)
  end

  describe '#get' do
    before do
      @action = @client.get(:actions).sample
      @person = @client.get(:people).sample
      @circle = @client.get(:circles).sample     
    end

    it 'returns array of action objects with singular symbol as type' do
      array_of_actions = @client.get :action
      expect(array_of_actions).to all(be_a(Glassfrog::Action))
    end
    it 'returns array of action objects with plural symbol as type' do
      array_of_actions = @client.get :actions
      expect(array_of_actions).to all(be_a(Glassfrog::Action))
    end
    it 'returns array of action objects with singular string as type' do
      array_of_actions = @client.get 'action'
      expect(array_of_actions).to all(be_a(Glassfrog::Action))
    end
    it 'returns array of action objects with plural string as type' do
      array_of_actions = @client.get 'actions'
      expect(array_of_actions).to all(be_a(Glassfrog::Action))
    end

    it 'returns array of action objects with string as options' do
      array_of_actions = @client.get :action, "#{@action.id}"
      expect(array_of_actions).to all(be_a(Glassfrog::Action))
    end
    it 'returns array of action objects with integer as options' do
      array_of_actions = @client.get :action, @action.id
      expect(array_of_actions).to all(be_a(Glassfrog::Action))
    end

    it 'returns array of action objects with id in hash as options' do
      array_of_actions = @client.get :action, { id: @action.id }
      expect(array_of_actions).to all(be_a(Glassfrog::Action))
    end
    it 'returns array of action objects with action object as options' do
      array_of_actions = @client.get :action, @action
      expect(array_of_actions).to all(be_a(Glassfrog::Action))
    end

    it 'returns array of action objects with person object as options' do
      array_of_actions = @client.get :action, @person
      expect(array_of_actions).to all(be_a(Glassfrog::Action))
    end
    it 'returns array of action objects with person_id in hash as options' do
      array_of_actions = @client.get :action, { person_id: @person.id }
      expect(array_of_actions).to all(be_a(Glassfrog::Action))
    end
    it 'returns array of action objects with circle object as options' do
      array_of_actions = @client.get :action, @circle
      expect(array_of_actions).to all(be_a(Glassfrog::Action))
    end
    it 'returns array of action objects with circle_id in hash as options' do
      array_of_actions = @client.get :action, { circle_id: @circle.id }
      expect(array_of_actions).to all(be_a(Glassfrog::Action))
    end

    it 'returns array of all action objects with no options' do
      array_of_actions = @client.get :action
      expect(array_of_actions).to all(be_a(Glassfrog::Action))
    end

    it 'raises error with unassociated object as options' do
      expect { @client.get :action, Glassfrog::Metric.new }.to raise_error(ArgumentError)
    end
    it 'raises error with invalid type as options' do
      expect { @client.get :action, true }.to raise_error(ArgumentError)
    end
  end
end
