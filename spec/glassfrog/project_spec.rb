require 'spec_helper'

describe Glassfrog::Project do
  before :context do
    @client = Glassfrog::Client.new(TestCredentials::API_KEY)
  end

  describe '#get' do
    before do
      @project = @client.get(:projects).sample
      @circle = @client.get(:circles).sample
      @person = @client.get(:people).sample
    end

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

  describe '#post' do
    before do
      @new_project_hash = {
        description: 'Test Project',
        status: 'Future',
        link: nil,
        value: 5,
        effort: 1,
        roi: 5,
        private_to_circle: false,
        created_at: '2014-04-16T12:33:39Z',
        links: {
          circle: 4772, 
          role: 73198,
          person: 20062
        }
      }
      @new_project_object = Glassfrog::Project.new(@new_project_hash)
    end
    it 'creates a new projcet object on GlassFrog with hash as options and returns this new object' do
      array_of_projects = @client.post :project, @new_project_hash
      expect(array_of_projects).to all(be_a(Glassfrog::Project))
    end
    it 'creates a new project object on GlassFrog with a project object as options and returns this new object' do
      array_of_projects = @client.post :project, @new_project_object
      expect(array_of_projects).to all(be_a(Glassfrog::Project))
    end

    it 'raises error with invalid object as options' do
      expect { @client.post :project, Glassfrog::Metric.new }.to raise_error(ArgumentError)
    end
    it 'raises error with invalid type as options' do
      expect { @client.post :project, true }.to raise_error(ArgumentError)
    end
  end
end
