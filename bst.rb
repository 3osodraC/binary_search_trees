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
  def delete(head = @root, val)
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

  # Recursively finds a value in a binary tree.
  # Returns the node containing the value, or nil if not found.
  def find(val, head = @root)
    return head if head.nil? || head.data == val

    if val < head.data
      return find(val, head.left)
    else
      return find(val, head.right)
    end
  end

  # I need to start from given value, then count the most i can go down from there.
  def height(head = @root)
    return -1 if head.nil?

    height_l = height(head.left)
    height_r = height(head.right)

    if height_l > height_r
      height_l + 1
    else
      height_r + 1
    end
  end

  # Postorder: (left subtree, root, right subtree).
  # Performs postorder traversal starting from the given node (default: @root).
  def inorder(head = @root, result = [])
    return result if head.nil?

    inorder(head.left, result)
    block_given? ? yield(head) : result << head.data
    inorder(head.right, result)
    result
  end

  # Inserts values at the end of the tree by recursively comparing the current head with
  # the current value, then returning the head when the recursion is done.
  def insert(head = @root, val)
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

  # Performs level-order traversal starting from the given node (default: @root).
  # Uses a queue to process nodes level by level.
  def level_order(head = @root)
    return if head.nil?

    q = [head]
    result = []
    until q.empty?
      current = q.shift
      block_given? ? yield(current) : result << current.data

      q.push(current.left) unless current.left.nil?
      q.push(current.right) unless current.right.nil?
    end

    result
  end

  # Postorder: (left subtree, right subtree, root).
  # Performs postorder traversal starting from the given node (default: @root).
  def postorder(head = @root, result = [])
    return result if head.nil?

    postorder(head.left, result)
    postorder(head.right, result)
    block_given? ? yield(head) : result << head.data
    result
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  # Preorder: (root, left subtree, right subtree).
  # Performs preorder traversal starting from the given node (default: @root).
  def preorder(head = @root, result = [])
    return result if head.nil?

    block_given? ? yield(head) : result << head.data
    preorder(head.left, result)
    preorder(head.right, result)
    result
  end
end

# Testing grounds.

# Create BST
bst = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
puts "\nBST created:\n\n"
p bst.pretty_print

# Level order traversal
puts "\nLevel order traversal\n\n"
p bst.level_order

# Preorder traversal
puts "\nPreorder traversal\n\n"
p bst.preorder

# Inorder traversal
puts "\nInorder traversal\n\n"
p bst.inorder

# Postorder traversal
puts "\nPostorder traversal\n\n"
p bst.postorder

# Insert value 33 in the BST
puts "\nInsert 33:\n\n"
bst.insert(33)
p bst.pretty_print

# Find value 33
puts "\nFind 67:\n\n"
p bst.find(67)

# Delete value 4 from the BST
puts "\nDelete 4:\n\n"
bst.delete(4)
p bst.pretty_print

# Height of 5
puts "\nHeight of 67:\n\n"
p bst.height(bst.find(67))
