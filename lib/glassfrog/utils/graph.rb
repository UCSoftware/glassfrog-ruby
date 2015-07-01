module Glassfrog
  # 
  # [module description]
  # 
  module Graph
      # 
      # [self description]
      # 
      # @return [type] [description]
    def self.root(circles, roles)
      root_role = roles.select { |role| role.links[:circle].nil? }.first
      circles.select { |circle| circle.id == root_role.links[:supporting_circle] }.first
    end

    # 
    # [self description]
    # s
    # @return [type] [description]
    def self.hierarchy(client)
      circles, roles = client.get(:circles), client.get(:roles)
      circle_hash, role_hash = Hash[circles.map { |circle| [circle.id, circle] }], Hash[client.get(:roles).map { |role| [role.id, role] }]
      sub_circles = circles.select { |circle| circle.links[:supported_role].is_a? Fixnum }
      sub_circles_hash = Hash[sub_circles.map { |circle| [circle, circle_hash[role_hash[circle.links[:supported_role]].links[:circle]]] }]
      sub_circles_hash.each { |sub_circle, parent_circle| if parent_circle then parent_circle.sub_circles ? parent_circle.sub_circles.push(sub_circle) : parent_circle.sub_circles = [sub_circle] else puts parent_circle end }
      root(circles, roles)
    end
  end
end