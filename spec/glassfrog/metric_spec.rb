require 'spec_helper'

describe Glassfrog::Metric do
  before :context do
    @client = Glassfrog::Client.new(TestCredentials::API_KEY)
  end

  describe '#get' do
    before :context do
      @metric = @client.get(:metrics).sample
      @role = @client.get(:role).sample
      @circle = @client.get(:circles).sample
    end

    it 'returns array of metric item objects with singular symbol as type' do
      array_of_metrics = @client.get :metric
      expect(array_of_metrics).to all(be_a(Glassfrog::Metric))
    end
    it 'returns array of metric item objects with plural symbol as type' do
      array_of_metrics = @client.get :metrics
      expect(array_of_metrics).to all(be_a(Glassfrog::Metric))
    end
    it 'returns array of metric item objects with singular string as type' do
      array_of_metrics = @client.get 'metric'
      expect(array_of_metrics).to all(be_a(Glassfrog::Metric))
    end
    it 'returns array of metric item objects with plural string as type' do
      array_of_metrics = @client.get 'metrics'
      expect(array_of_metrics).to all(be_a(Glassfrog::Metric))
    end

    it 'returns array of metric item objects with string as options' do
      array_of_metrics = @client.get :metric, "#{@metric.id}"
      expect(array_of_metrics).to all(be_a(Glassfrog::Metric))
    end
    it 'returns array of metric item objects with integer as options' do
      array_of_metrics = @client.get :metric, @metric.id
      expect(array_of_metrics).to all(be_a(Glassfrog::Metric))
    end

    it 'returns array of metric item objects with id in hash as options' do
      array_of_metrics = @client.get :metric, { id: @metric.id }
      expect(array_of_metrics).to all(be_a(Glassfrog::Metric))
    end
    it 'returns array of metric item objects with metric item object as options' do
      array_of_metrics = @client.get :metric, @metric
      expect(array_of_metrics).to all(be_a(Glassfrog::Metric))
    end

    it 'returns array of metric item objects with circle object as options' do
      array_of_metrics = @client.get :metric, @circle
      expect(array_of_metrics).to all(be_a(Glassfrog::Metric))
    end
    it 'returns array of metric item objects with circle_id in hash as options' do
      array_of_metrics = @client.get :metric, { circle_id: @circle.id }
      expect(array_of_metrics).to all(be_a(Glassfrog::Metric))
    end

    it 'returns array of metric item objects with role object as options' do
      array_of_metrics = @client.get :metric, @role
      expect(array_of_metrics).to all(be_a(Glassfrog::Metric))
    end
    it 'returns array of metric item objects with role_id in hash as options' do
      array_of_metrics = @client.get :metric, { role_id: @role.id }
      expect(array_of_metrics).to all(be_a(Glassfrog::Metric))
    end

    it 'returns array of all action objects with no options' do
      array_of_metrics = @client.get :metric
      expect(array_of_metrics).to all(be_a(Glassfrog::Metric))
    end

    it 'raises error with unassociated object as options' do
      expect { @client.get :metric, Glassfrog::Trigger.new }.to raise_error(ArgumentError)
    end
    it 'raises error with invalid type as options' do
      expect { @client.get :metric, true }.to raise_error(ArgumentError)
    end
  end

  describe '#post' do
    before :context do
      @new_metric_hash = {
        id: rand(10000),
        description: 'Test Metric',
        frequency: 'Weekly',
        global: false,
        link: 'http://undercurrent.com',
        role_name: nil,
        links: {
          circle: 4772, 
          role: 73198
        }
      }
      @new_metric_object = Glassfrog::Metric.new(@new_metric_hash)
    end
    it 'creates a new metric object on GlassFrog with hash as options and returns this new object' do
      array_of_metrics = @client.post :metric, @new_metric_hash
      expect(array_of_metrics).to all(be_a(Glassfrog::Metric))
    end
    it 'creates a new metric object on GlassFrog with a metric object as options and returns this new object' do
      array_of_metrics = @client.post :metric, @new_metric_object
      expect(array_of_metrics).to all(be_a(Glassfrog::Metric))
    end

    it 'raises error with invalid object as options' do
      expect { @client.post :metric, Glassfrog::Trigger.new }.to raise_error(ArgumentError)
    end
    it 'raises error with invalid type as options' do
      expect { @client.post :metric, true }.to raise_error(ArgumentError)
    end
  end

  describe '#patch' do
    before :context do
      @new_metric_hash = {
        id: rand(10000),
        description: 'Test Metric',
        frequency: 'Weekly',
        global: false,
        link: 'http://undercurrent.com',
        role_name: nil,
        links: {
          circle: 4772, 
          role: 73198
        }
      }
      @new_metric_object = Glassfrog::Metric.new(@new_metric_hash)
      @metric = @client.post(:metric, @new_metric_object).first
      @metric_hash = @metric.hashify
      @metric.description = 'This is an update with object'
      @metric_hash[:description] = 'This is an update with hash'
    end

    it 'updates a metric object on GlassFrog with a metric object as options without identifier' do
      options = @client.patch :metric, @metric
      expect(options).not_to be(false)
      expect(@client.get(:metric, options).first.description).to eq(@metric.description)
    end
    it 'updates a metric object on GlassFrog with a hash as options without identifier' do
      options = @client.patch :metric, @metric_hash
      expect(options).not_to be(false)
      expect(@client.get(:metric, options).first.description).to eq(@metric_hash[:description])
    end
    it 'updates a metric object on GlassFrog with a metric object as options with identifier' do
      id = @metric.id
      options = @client.patch :metric, id, @metric
      expect(options).not_to be(false)
      expect(@client.get(:metric, options).first.description).to eq(@metric.description)
    end
    it 'updates a metric object on GlassFrog with a hash as options with identifier' do
      id = @metric_hash[:id]
      options = @client.patch :metric, id, @metric_hash
      expect(options).not_to be(false)
      expect(@client.get(:metric, options).first.description).to eq(@metric_hash[:description])
    end

    it 'raises error with invalid object as options' do
      expect { @client.patch :metric, Glassfrog::Person.new }.to raise_error(ArgumentError)
    end
    it 'raises error with invalid type as options' do
      expect { @client.patch :metric, true }.to raise_error(ArgumentError)
    end
    it 'raises error with valid object without id' do
      expect { @client.patch :metric, Glassfrog::Metric.new({description: 'Test metric without id'}) }.to raise_error(ArgumentError)
    end
  end

  describe '#delete' do
    before :context do
      @new_metric_hash = {
        description: 'Test Metric',
        frequency: 'Weekly',
        global: false,
        link: 'http://undercurrent.com',
        role_name: nil,
        links: {
          circle: 4772, 
          role: 73198
        }
      }
    end

    it 'deletes a metric on GlassFrog with a metric as options' do
      @metric = @client.post(:metric, @new_metric_hash).first
      expect(@client.delete :metric, @metric).to be(true)
    end

    it 'deletes a metric on GlassFrog with a hash as options' do
      @metric = @client.post(:metric, @new_metric_hash).first
      expect(@client.delete :metric, @metric.hashify).to be(true)
    end

    it 'raises error with invalid object as options' do
      expect { @client.delete :metric, Glassfrog::ChecklistItem.new }.to raise_error(ArgumentError)
    end
  end
end
