module Glassfrog
  # 
  # Utilites for handling requests.
  # 
  module Utils
    # 
    # Turns a string into a lowercase, underscored symbol for use as a parameter.
    # @param value [String] The string.
    # 
    # @return [Symbol] The symbol.
    def parameterize(value)
      value.to_s.downcase.tr(" ", "_").to_sym
    end

    # 
    # Turns all the values into symbols in an array or all the keys in a hash.
    # @param object [Hash, Array, Object] Object to be symbolized.
    # 
    # @return [Hash, Array, Object] Symbolized object.
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

    # 
    # Grabs ID out of an object.
    # @param object [Integer, String, URI, Glassfrog::Base] The object to fetch ID from.
    # @param klass [Class] The expected class.
    # 
    # @return [Integer, nil] ID or nil.
    def extract_id(object, klass)
      case object
      when ::Integer
        object
      when ::String
        object.split('/').last.to_i
      when ::Hash
        object[:id] || object[:ID]
      when URI, Addressable::URI
        object.path.split('/').last.to_i
      when klass
        object.id
      else
        nil
      end
    end
  end
end