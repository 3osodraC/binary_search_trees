# Node of a BST (Binary Search Tree). Each node stores its @data,
# its @left child, and its @right child.
class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def <=>(other)
    @data <=> other.data
  end
end

# The balanced BST itself.
class Tree
  def initialize(arr)
    @root = build_tree(arr)
  end

  # - Find middle element & make it the root of the tree.
  # - Perform the same operation with the left sub arr and make it the root's left child.
  # - Again, now with right sub arr, make it the right child.
  def build_tree(arr)
    return nil if arr.size <= 1

    arr = arr.sort.uniq
    half = (arr.size / 2).ceil

    root = Node.new(arr[half])
    arr_l = arr.slice(0, half)
    arr_r = arr.slice(half, arr.length - half)

    l_child = build_tree(arr_l)
    root.left = l_child

    r_child = build_tree(arr_r)
    root.right = r_child

    root
  end

  def delete(val)
    # delete
  end

  def find(val)
    # find
  end

  def insert(root = @root, val)
    return nil if root.nil? # Or maybe return the value itself?

    if root.data == val
      return Node.new(val)
    elsif root.data < val
      # If this doesn't work make a dummy value if it isn't too detrimental
      # to memory since this is recursive (Maybe i'm just tripping).
      root.left = insert(root.left, val)
    elsif val > val
      root.right = insert(root.right, val)
    end

    # I probably should add another input, the node...
    # or just put a Node.new(val) below.
    Node.new(val)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

bst = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
# bst.insert(33)
p bst.pretty_print