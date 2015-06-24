require 'spec_helper'

describe Glassfrog::ChecklistItem do
  before :context do
    @client = Glassfrog::Client.new(TestCredentials::API_KEY)
    @checklist_item = @client.get(:checklist_items).sample
    @circle = @client.get(:circles).sample
  end

  describe '#get' do
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
end
