# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

require_relative 'topological_sort'
require_relative 'graph'
require 'byebug'

def install_order(arr)
  vertices = []
  values = []
  edges = []
  arr.each do |tuple|
    unless values.include?(tuple[0])
      depVertex = Vertex.new(tuple[0])
      values.push(depVertex.value)
      vertices.push(depVertex)
    end
    unless values.include?(tuple[1])
      indepVertex = Vertex.new(tuple[1])
      values.push(indepVertex.value)
      vertices.push(indepVertex)
    end
    dep = vertices.find { |vertex| vertex.value == tuple[0] }
    indep = vertices.find { |vertex| vertex.value == tuple[1] }
    edge = Edge.new(indep, dep)
    edges.push(edge)
  end
  res = topological_sort(vertices).map { |vertex| vertex.value }
  (1..values.max).each do |value|
    unless values.include?(value)
      res.unshift(value)
    end
  end    
  res

end