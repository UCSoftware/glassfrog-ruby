require 'spec_helper'

VALID_NAMES = ['Facilitator', 'Secretary', 'Rep Link', 'Lead Link']

describe Glassfrog::Person do
  before :context do
    @client = Glassfrog::Client.new(TestCredentials::API_KEY)
    @person = @client.get(:people).sample
    @circle = @client.get(:circles).sample
    @role = @client.get(:roles).select { |role| VALID_NAMES.include?(role.name) }.sample
  end

  describe '#get' do
    it 'returns array of person item objects with singular symbol as type' do
      array_of_people = @client.get :person
      expect(array_of_people).to all(be_a(Glassfrog::Person))
    end
    it 'returns array of person item objects with plural symbol as type' do
      array_of_people = @client.get :people
      expect(array_of_people).to all(be_a(Glassfrog::Person))
    end
    it 'returns array of person item objects with singular string as type' do
      array_of_people = @client.get 'person'
      expect(array_of_people).to all(be_a(Glassfrog::Person))
    end
    it 'returns array of person item objects with plural string as type' do
      array_of_people = @client.get 'people'
      expect(array_of_people).to all(be_a(Glassfrog::Person))
    end

    it 'returns array of person item objects with string as options' do
      array_of_people = @client.get :person, "#{@person.id}"
      expect(array_of_people).to all(be_a(Glassfrog::Person))
    end
    it 'returns array of person item objects with integer as options' do
      array_of_people = @client.get :person, @person.id
      expect(array_of_people).to all(be_a(Glassfrog::Person))
    end

    it 'returns array of person item objects with id in hash as options' do
      array_of_people = @client.get :person, { id: @person.id }
      expect(array_of_people).to all(be_a(Glassfrog::Person))
    end
    it 'returns array of person item objects with person item object as options' do
      array_of_people = @client.get :person, @person
      expect(array_of_people).to all(be_a(Glassfrog::Person))
    end

    it 'returns array of person item objects with circle object as options' do
      array_of_people = @client.get :person, @circle
      expect(array_of_people).to all(be_a(Glassfrog::Person))
    end
    it 'returns array of person item objects with circle_id in hash as options' do
      array_of_people = @client.get :person, { circle_id: @circle.id }
      expect(array_of_people).to all(be_a(Glassfrog::Person))
    end

    it 'returns array of person item objects with role object as options' do
      array_of_people = @client.get :person, @role
      expect(array_of_people).to all(be_a(Glassfrog::Person))
    end
    it 'returns array of person item objects with role in hash as options' do
      array_of_people = @client.get :person, { role: @role.name.to_s.downcase.tr(" ", "_").to_sym }
      expect(array_of_people).to all(be_a(Glassfrog::Person))
    end

    it 'returns array of all action objects with no options' do
      array_of_people = @client.get :person
      expect(array_of_people).to all(be_a(Glassfrog::Person))
    end

    it 'raises error with unassociated object as options' do
      expect { @client.get :person, Glassfrog::Trigger.new }.to raise_error(ArgumentError)
    end
    it 'raises error with invalid type as options' do
      expect { @client.get :person, true }.to raise_error(ArgumentError)
    end
  end
end