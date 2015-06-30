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

    it 'should return an array of role item objects with singular symbol as type' do
      array_of_roles = @client.get :role
      expect(array_of_roles).to all(be_a(Glassfrog::Role))
    end
    it 'should return an array of role item objects with plural symbol as type' do
      array_of_roles = @client.get :roles
      expect(array_of_roles).to all(be_a(Glassfrog::Role))
    end
    it 'should return an array of role item objects with singular string as type' do
      array_of_roles = @client.get 'role'
      expect(array_of_roles).to all(be_a(Glassfrog::Role))
    end
    it 'should return an array of role item objects with plural string as type' do
      array_of_roles = @client.get 'roles'
      expect(array_of_roles).to all(be_a(Glassfrog::Role))
    end

    it 'should return an array of role item objects with string as options' do
      array_of_roles = @client.get :role, "#{@role.id}"
      expect(array_of_roles).to all(be_a(Glassfrog::Role))
    end
    it 'should return an array of role item objects with integer as options' do
      array_of_roles = @client.get :role, @role.id
      expect(array_of_roles).to all(be_a(Glassfrog::Role))
    end

    it 'should return an array of role item objects with id in hash as options' do
      array_of_roles = @client.get :role, { id: @role.id }
      expect(array_of_roles).to all(be_a(Glassfrog::Role))
    end
    it 'should return an array of role item objects with role item object as options' do
      array_of_roles = @client.get :role, @role
      expect(array_of_roles).to all(be_a(Glassfrog::Role))
    end

    it 'should return an array of role item objects with circle object as options' do
      array_of_roles = @client.get :role, @circle
      expect(array_of_roles).to all(be_a(Glassfrog::Role))
    end
    it 'should return an array of role item objects with circle_id in hash as options' do
      array_of_roles = @client.get :role, { circle_id: @circle.id }
      expect(array_of_roles).to all(be_a(Glassfrog::Role))
    end

    it 'should return an array of role item objects with person object as options' do
      array_of_roles = @client.get :role, @person
      expect(array_of_roles).to all(be_a(Glassfrog::Role))
    end
    it 'should return an array of role item objects with person_id in hash as options' do
      array_of_roles = @client.get :role, { person_id: @person.id }
      expect(array_of_roles).to all(be_a(Glassfrog::Role))
    end

    it 'should return an array of all action objects with no options' do
      array_of_roles = @client.get :role
      expect(array_of_roles).to all(be_a(Glassfrog::Role))
    end

    it 'should raise an error with unassociated object as options' do
      expect { @client.get :role, Glassfrog::Trigger.new }.to raise_error(ArgumentError)
    end
    it 'should raise an error with invalid type as options' do
      expect { @client.get :role, true }.to raise_error(ArgumentError)
    end
  end

  describe '#patch' do
    before :context do
      @role = @client.get(:roles).select { |role| role.name == "Sandperson" }.sample
      @person = @client.post(:person, Glassfrog::Person.new({
          name: 'Test Person',
          email: 'test.person.' + rand(100000).to_s + '@testemail.com'
        })).first
    end

    it 'should add a role to a person on GlassFrog with a role object as options without identifier' do
      @role.links[:people].push(@person.id)
      options = @client.patch(:role, @role)
      expect(options).not_to be(false)
      expect(@client.get(:roles, options).first.links[:people].sort).to eq(@role.links[:people].sort)
    end
    it 'should remove a role from a person on GlassFrog with a role object as options without identifier' do
      @role.links[:people].delete(@person.id)
      options = @client.patch(:role, @role)
      expect(options).not_to be(false)
      expect(@client.get(:roles, options).first.links[:people]).to eq(@role.links[:people])
    end

    it 'should raise error with invalid object as options' do
      expect { @client.patch :role, Glassfrog::Metric.new }.to raise_error(ArgumentError)
    end
    it 'should raise error with invalid type as options' do
      expect { @client.patch :role, true }.to raise_error(ArgumentError)
    end
  end
end
