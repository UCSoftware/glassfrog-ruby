require 'spec_helper'

describe Glassfrog::ChecklistItem do
  before :context do
    @client = Glassfrog::Client.new(TestCredentials::API_KEY)
  end

  describe '#get' do
    before do
      @checklist_item = @client.get(:checklist_items).sample
      @circle = @client.get(:circles).sample
    end

    it 'returns array of checklist item objects with singular symbol as type' do
      array_of_checklist_items = @client.get :checklist_items
      expect(array_of_checklist_items).to all(be_a(Glassfrog::ChecklistItem))
    end
    it 'returns array of checklist item objects with plural symbol as type' do
      array_of_checklist_items = @client.get :checklist_items
      expect(array_of_checklist_items).to all(be_a(Glassfrog::ChecklistItem))
    end
    it 'returns array of checklist item objects with singular string as type' do
      array_of_checklist_items = @client.get 'checklist item'
      expect(array_of_checklist_items).to all(be_a(Glassfrog::ChecklistItem))
    end
    it 'returns array of checklist item objects with plural string as type' do
      array_of_checklist_items = @client.get 'checklist items'
      expect(array_of_checklist_items).to all(be_a(Glassfrog::ChecklistItem))
    end

    it 'returns array of checklist item objects with string as options' do
      array_of_checklist_items = @client.get :checklist_items, "#{@checklist_item.id}"
      expect(array_of_checklist_items).to all(be_a(Glassfrog::ChecklistItem))
    end
    it 'returns array of checklist item objects with integer as options' do
      array_of_checklist_items = @client.get :checklist_items, @checklist_item.id
      expect(array_of_checklist_items).to all(be_a(Glassfrog::ChecklistItem))
    end

    it 'returns array of checklist item objects with id in hash as options' do
      array_of_checklist_items = @client.get :checklist_items, { id: @checklist_item.id }
      expect(array_of_checklist_items).to all(be_a(Glassfrog::ChecklistItem))
    end
    it 'returns array of checklist item objects with checklist item object as options' do
      array_of_checklist_items = @client.get :checklist_items, @checklist_item
      expect(array_of_checklist_items).to all(be_a(Glassfrog::ChecklistItem))
    end

    it 'returns array of checklist item objects with circle object as options' do
      array_of_checklist_items = @client.get :checklist_items, @circle
      expect(array_of_checklist_items).to all(be_a(Glassfrog::ChecklistItem))
    end
    it 'returns array of checklist item objects with circle_id in hash as options' do
      array_of_checklist_items = @client.get :checklist_items, { circle_id: @circle.id }
      expect(array_of_checklist_items).to all(be_a(Glassfrog::ChecklistItem))
    end

    it 'returns array of all circle objects with no options' do
      array_of_checklist_items = @client.get :checklist_items
      expect(array_of_checklist_items).to all(be_a(Glassfrog::ChecklistItem))
    end

    it 'raises error with unassociated object as options' do
      expect { @client.get :checklist_items, Glassfrog::Metric.new }.to raise_error(ArgumentError)
    end
    it 'raises error with invalid type as options' do
      expect { @client.get :checklist_items, true }.to raise_error(ArgumentError)
    end
  end

  describe '#post' do
    before do
      @new_checklist_item_hash = {
        id: rand(10000),
        description: 'Test Checklist Item',
        frequency: 'Weekly',
        global: false,
        links: {
          circle: 4772, 
          role: 73198
        }
      }
      @new_checklist_item_object = Glassfrog::ChecklistItem.new(@new_checklist_item_hash)
    end

    it 'creates a new checklist item object on GlassFrog with hash as options and returns this new object' do
      array_of_checklist_items = @client.post :checklist_items, @new_checklist_item_hash
      expect(array_of_checklist_items).to all(be_a(Glassfrog::ChecklistItem))
    end
    it 'creates a new checklist item object on GlassFrog with a checklist item object as options and returns this new object' do
      array_of_checklist_items = @client.post :checklist_items, @new_checklist_item_object
      expect(array_of_checklist_items).to all(be_a(Glassfrog::ChecklistItem))
    end

    it 'raises error with invalid object as options' do
      expect { @client.post :checklist_item, Glassfrog::Metric.new }.to raise_error(ArgumentError)
    end
    it 'raises error with invalid type as options' do
      expect { @client.post :checklist_item, true }.to raise_error(ArgumentError)
    end
  end

  describe '#patch' do
    before do
      @new_checklist_item_object = Glassfrog::ChecklistItem.new({
        id: rand(10000),
        description: 'Test Checklist Item',
        frequency: 'Weekly',
        global: false,
        links: {
          circle: 4772, 
          role: 73198
        }
      })
      @checklist_item = @client.post(:checklist_item, @new_checklist_item_object).first
      @checklist_item.description = 'This is updated'
    end


  end
end
