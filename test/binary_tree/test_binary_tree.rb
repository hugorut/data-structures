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

    def get_fixture(index = nil, delete = true)
        fixture = (index) ? @fixtures[index] : @fixtures.sample
        @fixtures.delete(fixture) if delete

        return fixture
    end

    def insert_fixtures
        for key in 0..@fixtures.length() -1
            fixture = get_fixture(key, false)
            @tree.add_node(fixture['key'], fixture['value'])
        end
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

    def test_find_a_node_placed_in_the_tree
        insert_fixtures

        fixture = get_fixture
        found_fixture = @tree.find(fixture['key'])

        assert_equal(fixture['value'], found_fixture.value)
    end

    def test_node_traversed_in_order
        insert_fixtures
            
        current = 0
        
        @tree.travese_in_order do |node|
            assert(node.key > current)
            current = node
        end
    end
end