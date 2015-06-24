require 'spec_helper'

describe Glassfrog::Project do
  before :context do
    @client = Glassfrog::Client.new(TestCredentials::API_KEY)
    @project = @client.get(:projects).sample
    @circle = @client.get(:circles).sample
    @person = @client.get(:people).sample
  end

  describe '#get' do
    it 'returns array of project item objects with singular symbol as type' do
      array_of_projects = @client.get :project
      expect(array_of_projects).to all(be_a(Glassfrog::Project))
    end
    it 'returns array of project item objects with plural symbol as type' do
      array_of_projects = @client.get :projects
      expect(array_of_projects).to all(be_a(Glassfrog::Project))
    end
    it 'returns array of project item objects with singular string as type' do
      array_of_projects = @client.get 'project'
      expect(array_of_projects).to all(be_a(Glassfrog::Project))
    end
    it 'returns array of project item objects with plural string as type' do
      array_of_projects = @client.get 'projects'
      expect(array_of_projects).to all(be_a(Glassfrog::Project))
    end

    it 'returns array of project item objects with string as options' do
      array_of_projects = @client.get :project, "#{@project.id}"
      expect(array_of_projects).to all(be_a(Glassfrog::Project))
    end
    it 'returns array of project item objects with integer as options' do
      array_of_projects = @client.get :project, @project.id
      expect(array_of_projects).to all(be_a(Glassfrog::Project))
    end

    it 'returns array of project item objects with id in hash as options' do
      array_of_projects = @client.get :project, { id: @project.id }
      expect(array_of_projects).to all(be_a(Glassfrog::Project))
    end
    it 'returns array of project item objects with project item object as options' do
      array_of_projects = @client.get :project, @project
      expect(array_of_projects).to all(be_a(Glassfrog::Project))
    end

    it 'returns array of project item objects with circle object as options' do
      array_of_projects = @client.get :project, @circle
      expect(array_of_projects).to all(be_a(Glassfrog::Project))
    end
    it 'returns array of project item objects with circle_id in hash as options' do
      array_of_projects = @client.get :project, { circle_id: @circle.id }
      expect(array_of_projects).to all(be_a(Glassfrog::Project))
    end

    it 'returns array of project item objects with person object as options' do
      array_of_projects = @client.get :project, @person
      expect(array_of_projects).to all(be_a(Glassfrog::Project))
    end
    it 'returns array of project item objects with person_id in hash as options' do
      array_of_projects = @client.get :project, { person_id: @person.name }
      expect(array_of_projects).to all(be_a(Glassfrog::Project))
    end

    it 'returns array of all action objects with no options' do
      array_of_projects = @client.get :project
      expect(array_of_projects).to all(be_a(Glassfrog::Project))
    end

    it 'raises error with unassociated object as options' do
      expect { @client.get :project, Glassfrog::Trigger.new }.to raise_error(ArgumentError)
    end
    it 'raises error with invalid type as options' do
      expect { @client.get :project, true }.to raise_error(ArgumentError)
    end
  end
end
