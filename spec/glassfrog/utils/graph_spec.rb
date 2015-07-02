require 'spec_helper'
require 'rspec/expectations'

RSpec::Matchers.define :not_be_a_super_circle_of do |expected|
  match do |actual|
    actual.sub_circles ? !actual.sub_circles.include?(expected) : true
  end
end

RSpec::Matchers.define :be_a_sub_circle_of do |expected, root|
  match do |actual|
    expected.each do |circle| 
      return true if circle.sub_circles && circle.sub_circles.include?(actual)
      return true if circle == root
    end
    return false
  end
end

describe Glassfrog::Graph do
  before :context do
    @client = Glassfrog::Client.new(TestCredentials::API_KEY)
  end

  describe '#root' do
    it 'should return a single circle object which is in no other circle\'s sub_circles array' do
      circles = @client.get :circles
      @client.build_hierarchy(circles)
      root = @client.find_root(circles)
      expect(root).to be_a(Glassfrog::Circle)
      expect(circles).to all(not_be_a_super_circle_of(root))
    end
  end

  describe '#hierarchy' do
    it 'should return a single circle object which is in no other circle\'s sub_circles array (root cicle)' do
      circles = @client.get :circles
      root = @client.build_hierarchy(circles)
      expect(root).to be_a(Glassfrog::Circle)
      expect(circles).to all(not_be_a_super_circle_of(root))
    end
    it 'every circle except root should have a super circle' do
      circles = @client.get :circles
      root = @client.build_hierarchy(circles)
      expect(circles).to all(be_a_sub_circle_of(circles, root))
    end
  end
end