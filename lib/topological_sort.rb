require_relative 'graph'
require 'byebug'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  sorted = []
  visited = []
  queue = Queue.new

  vertices.each do |vertex|
    queue.push(vertex) if vertex.in_edges.empty?
  end
  
  until queue.empty?
    currentNode = queue.pop
    sorted << currentNode
    visited << currentNode
    currentNode.out_edges.each do |out_edge|
      if (out_edge.to_vertex.in_edges - [out_edge]).empty?
        queue.push(out_edge.to_vertex)
      end
      out_edge.destroy!
    end
    vertices -= [currentNode]
  end
  return sorted if vertices.empty?
  return []
end
