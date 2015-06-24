require 'spec_helper'

describe Glassfrog::Role do
  before :context do
    @client = Glassfrog::Client.new(TestCredentials::API_KEY)
    @role = @client.get(:roles).sample
    @circle = @client.get(:circles).sample
    @person = @client.get(:people).sample
  end

  describe '#get' do
    it 'returns array of role item objects with singular symbol as type' do
      array_of_roles = @client.get :role
      expect(array_of_roles).to all(be_a(Glassfrog::Role))
    end
    it 'returns array of role item objects with plural symbol as type' do
      array_of_roles = @client.get :roles
      expect(array_of_roles).to all(be_a(Glassfrog::Role))
    end
    it 'returns array of role item objects with singular string as type' do
      array_of_roles = @client.get 'role'
      expect(array_of_roles).to all(be_a(Glassfrog::Role))
    end
    it 'returns array of role item objects with plural string as type' do
      array_of_roles = @client.get 'roles'
      expect(array_of_roles).to all(be_a(Glassfrog::Role))
    end

    it 'returns array of role item objects with string as options' do
      array_of_roles = @client.get :role, "#{@role.id}"
      expect(array_of_roles).to all(be_a(Glassfrog::Role))
    end
    it 'returns array of role item objects with integer as options' do
      array_of_roles = @client.get :role, @role.id
      expect(array_of_roles).to all(be_a(Glassfrog::Role))
    end

    it 'returns array of role item objects with id in hash as options' do
      array_of_roles = @client.get :role, { id: @role.id }
      expect(array_of_roles).to all(be_a(Glassfrog::Role))
    end
    it 'returns array of role item objects with role item object as options' do
      array_of_roles = @client.get :role, @role
      expect(array_of_roles).to all(be_a(Glassfrog::Role))
    end

    it 'returns array of role item objects with circle object as options' do
      array_of_roles = @client.get :role, @circle
      expect(array_of_roles).to all(be_a(Glassfrog::Role))
    end
    it 'returns array of role item objects with circle_id in hash as options' do
      array_of_roles = @client.get :role, { circle_id: @circle.id }
      expect(array_of_roles).to all(be_a(Glassfrog::Role))
    end

    it 'returns array of role item objects with person object as options' do
      array_of_roles = @client.get :role, @person
      expect(array_of_roles).to all(be_a(Glassfrog::Role))
    end
    it 'returns array of role item objects with person_id in hash as options' do
      array_of_roles = @client.get :role, { person_id: @person.id }
      expect(array_of_roles).to all(be_a(Glassfrog::Role))
    end

    it 'returns array of all action objects with no options' do
      array_of_roles = @client.get :role
      expect(array_of_roles).to all(be_a(Glassfrog::Role))
    end

    it 'raises error with unassociated object as options' do
      expect { @client.get :role, Glassfrog::Trigger.new }.to raise_error(ArgumentError)
    end
    it 'raises error with invalid type as options' do
      expect { @client.get :role, true }.to raise_error(ArgumentError)
    end
  end
end
