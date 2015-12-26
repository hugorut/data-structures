require "minitest/autorun"
require "./lib/binary_tree/binary_tree.rb"

class TestBinaryTree < Minitest::Test
    def setup
        @tree = BinaryTree::Tree.new
    end
    
    def teardown
        @tree = nil
    end    

    def test_node_has_appropriate_left_right_properties
        node = BinaryTree::Node.new(50, 'test')
        right = BinaryTree::Node.new(60, 'test')
        left = BinaryTree::Node.new(20, 'test')

        node.left_child = left
        node.right_child = right

        assert_equal(right, node.right_child)
        assert_equal(left, node.left_child)
    end
end