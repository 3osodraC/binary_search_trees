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

  # - Find middle element of the input array & make it the root of the tree.
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

  # Deletes a node with the specified value from the BST.
  # Handles cases for deletion when node has 0, 1, or 2 children.
  def delete(val, head = @root)
    return head if head.nil?

    if head.data > val
      head.left = delete(head.left, val)
    elsif head.data < val
      head.right = delete(head.right, val)
    else
      # Node to be deleted found

      # Case 1: Node with one or no child
      if head.left.nil?
        tmp = head.right
        head = nil
        return tmp
      elsif head.right.nil?
        tmp = head.left
        head = nil
        return tmp
      else
        # Case 2: Node with two children
        # Find the in-order successor (minimum value in right subtree)
        nxt = head.right
        while nxt.left
          nxt = nxt.left
        end

        # Copy successor data to the current node
        head.data = nxt.data

        # Recursively delete the in-order successor from the right subtree
        head.right = delete(head.right, nxt.data)
      end
    end

    head
  end

  # Inserts values at the end of the tree by recursively comparing the current head with
  # the current value, then returning the head when the recursion is done.
  def insert(val, head = @root)
    return Node.new(val) if head.nil?

    if head.data == val
      return Node.new(val)
    elsif head.data < val
      head.left = insert(head.left, val)
    elsif head.data > val
      head.right = insert(head.right, val)
    end

    head
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

# Testing grounds.

# Create BST
bst = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

# Insert value 33 in the BST
bst.insert(33)
p bst.pretty_print

# Delete value 4 from the BST
bst.delete(4)
p bst.pretty_print
