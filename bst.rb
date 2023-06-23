# Node of a BST (Binary Search Tree). Each node stores its @data,
# its @left child, and its @right child.
class Node
  include Comparable

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def <=>(other)
    @data <=> other.data
  end
end

class Tree
  @@root = nil

  def initialize(arr)
    # initialize
  end

  def build_tree
    # build_tree
  end
end
