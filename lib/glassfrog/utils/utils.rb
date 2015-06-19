require 'glassfrog/base'

module Glassfrog
  module Utils
    def symbolize_keys(object)
      if object.is_a?(Array)
        object.each_with_index do |val, index|
          object[index] = symbolize_keys(val)
        end
      elsif object.is_a?(Hash)
        object.keys.each do |key|
          object[key.to_sym] = symbolize_keys(object.delete(key))
        end
      end
      object
    end

    def extract_id(object, klass=nil)
      type = klass || Glassfrog::Base
      case object
      when ::Integer
        object
      when ::String
        object.split('/').last.to_i
      when ::Hash
        object[:id] || object[:ID]
      when URI, Addressable::URI
        object.path.split('/').last.to_i
      when type
        object.id
      else
        nil
      end
    end
  end
end