require 'spec_helper'

describe Glassfrog::Trigger do
  before :context do
    @client = Glassfrog::Client.new(TestCredentials::API_KEY)
  end

  describe '#get' do
    before :context do
      @trigger = @client.get(:triggers).sample
      @circle = @client.get(:circles).sample
      @person = @client.get(:people).sample      
    end

    it 'returns array of trigger item objects with singular symbol as type' do
      array_of_triggers = @client.get :trigger
      expect(array_of_triggers).to all(be_a(Glassfrog::Trigger))
    end
    it 'returns array of trigger item objects with plural symbol as type' do
      array_of_triggers = @client.get :triggers
      expect(array_of_triggers).to all(be_a(Glassfrog::Trigger))
    end
    it 'returns array of trigger item objects with singular string as type' do
      array_of_triggers = @client.get 'trigger'
      expect(array_of_triggers).to all(be_a(Glassfrog::Trigger))
    end
    it 'returns array of trigger item objects with plural string as type' do
      array_of_triggers = @client.get 'triggers'
      expect(array_of_triggers).to all(be_a(Glassfrog::Trigger))
    end

    it 'returns array of trigger item objects with string as options' do
      array_of_triggers = @client.get :trigger, "#{@trigger.id}"
      expect(array_of_triggers).to all(be_a(Glassfrog::Trigger))
    end
    it 'returns array of trigger item objects with integer as options' do
      array_of_triggers = @client.get :trigger, @trigger.id
      expect(array_of_triggers).to all(be_a(Glassfrog::Trigger))
    end

    it 'returns array of trigger item objects with id in hash as options' do
      array_of_triggers = @client.get :trigger, { id: @trigger.id }
      expect(array_of_triggers).to all(be_a(Glassfrog::Trigger))
    end
    it 'returns array of trigger item objects with trigger item object as options' do
      array_of_triggers = @client.get :trigger, @trigger
      expect(array_of_triggers).to all(be_a(Glassfrog::Trigger))
    end

    it 'returns array of trigger item objects with circle object as options' do
      array_of_triggers = @client.get :trigger, @circle
      expect(array_of_triggers).to all(be_a(Glassfrog::Trigger))
    end
    it 'returns array of trigger item objects with circle_id in hash as options' do
      array_of_triggers = @client.get :trigger, { circle_id: @circle.id }
      expect(array_of_triggers).to all(be_a(Glassfrog::Trigger))
    end

    it 'returns array of trigger item objects with person object as options' do
      array_of_triggers = @client.get :trigger, @person
      expect(array_of_triggers).to all(be_a(Glassfrog::Trigger))
    end
    it 'returns array of trigger item objects with person_id in hash as options' do
      array_of_triggers = @client.get :trigger, { person_id: @person.id }
      expect(array_of_triggers).to all(be_a(Glassfrog::Trigger))
    end

    it 'returns array of all action objects with no options' do
      array_of_triggers = @client.get :trigger
      expect(array_of_triggers).to all(be_a(Glassfrog::Trigger))
    end

    it 'raises error with unassociated object as options' do
      expect { @client.get :trigger, Glassfrog::Metric.new }.to raise_error(ArgumentError)
    end
    it 'raises error with invalid type as options' do
      expect { @client.get :trigger, true }.to raise_error(ArgumentError)
    end
  end
end
