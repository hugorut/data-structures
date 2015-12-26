require "minitest/autorun"
require "yaml"
require "./lib/binary_tree/binary_tree.rb"

class TestBinaryTree < Minitest::Test
    def setup
        @tree = BinaryTree::Tree.new
        @fixtures = YAML.load_file(File.dirname(__FILE__)+"/tree_items.yaml")
    end
    
    def teardown
        @tree = nil
        @fixtures = nil
    end    

    def get_fixture(index = nil)
        fixture = (index) ? @fixtures[index] : @fixtures.sample
        @fixtures.delete(fixture)

        return fixture
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

    def test_node_is_added_to_tree
        fixture = get_fixture

        @tree.add_node(fixture['key'], fixture['value'])
        assert_equal(fixture['key'], @tree.root.key)
        
        second_fixture = get_fixture
        @tree.add_node(second_fixture['key'], second_fixture['value'])

        if second_fixture['key'] > fixture['key']
            assert_equal(second_fixture['key'], @tree.root.right_child.key)
        else
            assert_equal(second_fixture['key'], @tree.root.left_child.key)
        end
    end
end