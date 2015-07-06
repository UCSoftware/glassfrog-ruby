module Glassfrog
  # 
  # Encapsulates utilities for building a circle hierarchy based on supporting roles/supported circles.
  # 
  module Graph
      # 
      # Finds the root of the 'circle tree' by finding the role that does not belong to a circle.
      # @param circles [Array<Glassfrog::Circle>] Array of circle objects (e.g. returned from GET or post-hierarchy build).
      # @param roles [Array<Glassfrog::Role>] Array of role objects (e.g. returned from GET).
      # 
      # @return [Glassfrog::Circle] The root circle.
    def self.root(circles, roles)
      root_role = roles.select { |role| role.links[:circle].nil? }.first
      circles.select { |circle| circle.id == root_role.links[:supporting_circle] }.first
    end

    # 
    # Populates each circle's sub_circles array with its respective sub circles.
    # This done by finding all of the supporting roles and the circle to which they belong.
    # @param client [Glassfrog::Client] Client used to make the get requests (unless circles and roles are provided).
    # @param circles=nil [Array<Glassfrog::Circle>] Array of circle objects (used instead of a get request).
    # @param roles=nil [Array<Glassfrog::Role>] Array of role objects (used instead of a get request).
    # 
    # @return [Glassfrog::Circle] The root circle of the 'circle tree'.
    def self.hierarchy(client, circles=nil, roles=nil)
      circles ||= client.get(:circles)
      roles ||= client.get(:roles)
      circle_hash, role_hash = Hash[circles.map { |circle| [circle.id, circle] }], Hash[client.get(:roles).map { |role| [role.id, role] }]
      sub_circles = circles.select { |circle| circle.links[:supported_role].is_a? Fixnum }
      sub_circles_hash = Hash[sub_circles.map { |circle| [circle, circle_hash[role_hash[circle.links[:supported_role]].links[:circle]]] }]
      sub_circles_hash.each do |sub_circle, parent_circle| 
          (parent_circle.sub_circles ? parent_circle.sub_circles.push(sub_circle) : parent_circle.sub_circles = [sub_circle]) if parent_circle
      end
      root(circles, roles)
    end
  end
end