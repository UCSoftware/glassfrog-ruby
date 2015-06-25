require 'spec_helper'

describe Glassfrog::Role do
  before :context do
    @client = Glassfrog::Client.new(TestCredentials::API_KEY)
  end

  describe '#get' do
    before :context do
      @role = @client.get(:roles).sample
      @circle = @client.get(:circles).sample
      @person = @client.get(:people).sample
    end

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

  # describe '#patch' do
  #   before :context do
  #     @new_role_hash = {
  #       id: rand(10000),
  #       name: 'Test Person',
  #       email: 'test.person.' + rand(10000).to_s + '@testemail.com'
  #     }
  #     @new_role_object = Glassfrog::Person.new(@new_person_hash)
  #     @person = @client.post(:person, @new_role_object).first
  #     @person_hash = @person.hashify
  #     @person.name = 'Object Person'
  #     @person_hash[:name] = 'Hash Person'
  #   end

  #   it 'updates a checklist item object on GlassFrog with a checklist item object as options without identifier' do
  #     options = @client.patch :person, @person
  #     expect(options).not_to be(false)
  #     expect(@client.get(:person, options).first.name).to eq(@person.name)
  #   end
  #   it 'updates a checklist item object on GlassFrog with a hash as options without identifier' do
  #     options = @client.patch :person, @person_hash
  #     expect(options).not_to be(false)
  #     expect(@client.get(:person, options).first.name).to eq(@person_hash[:name])
  #   end
  #   it 'updates a checklist item object on GlassFrog with a checklist item object as options with identifier' do
  #     id = @person.id
  #     options = @client.patch :person, id, @person
  #     expect(options).not_to be(false)
  #     expect(@client.get(:person, options).first.name).to eq(@person.name)
  #   end
  #   it 'updates a checklist item object on GlassFrog with a hash as options with identifier' do
  #     id = @person_hash[:id]
  #     options = @client.patch :person, id, @person_hash
  #     expect(options).not_to be(false)
  #     expect(@client.get(:person, options).first.name).to eq(@person_hash[:name])
  #   end

  #   it 'raises error with invalid object as options' do
  #     expect { @client.patch :person, Glassfrog::Metric.new }.to raise_error(ArgumentError)
  #   end
  #   it 'raises error with invalid type as options' do
  #     expect { @client.patch :person, true }.to raise_error(ArgumentError)
  #   end
  #   it 'raises error with valid object without id' do
  #     expect { @client.patch :person, Glassfrog::Person.new({name: 'Test Checklist Item without id'}) }.to raise_error(ArgumentError)
  #   end
  # end
end
