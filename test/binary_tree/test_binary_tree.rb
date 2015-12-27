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

    def test_delete_node_at_root
        insert_fixtures

        #    |50|
        #   30 78
        #  12    90
        # 5 16
        #  14 22

        @tree.delete_node(50)

        #    78
        #   30 90
        #  12 
        # 5 16
        #  14 22

        node = @tree.find(78)
        assert_equal(78, @tree.root.key)
        assert_equal(30, node.left_child.key)        
        assert_equal(90, node.right_child.key)        
    end    

    def test_delete_node_with_no_right_children
        insert_fixtures

        #     50
        #   |30| 78
        #  12      90
        # 5 16
        #  14 22

        @tree.delete_node(30)

        #    50
        #  12  78
        # 5 16   90
        #  14 22

        node = @tree.find(12)
        assert_equal(12, @tree.root.left_child.key)   
        assert_equal(16, node.right_child.key)        
    end    

    def test_delete_node_with_no_left_children
        insert_fixtures

        #     50
        #    30 |78|
        #  12     90
        # 5 16
        #  14 22

        @tree.delete_node(78)

        #     50
        #    30 90
        #  12     
        # 5 16
        #  14 22

        node = @tree.find(90)
        assert_equal(90, @tree.root.right_child.key)   
    end

    def test_delete_a_node_which_moves_min_value_in_place_
        insert_fixtures

        #    50
        #   30 78
        # |12|  90
        # 5 16
        #  14 22

        @tree.delete_node(12)

        #    50
        #   30 78
        #  14   90
        # 5 16
        #    22

        node = @tree.find(14)
        assert_equal(5, node.left_child.key)
        assert_equal(16, node.right_child.key)

        node = @tree.find(30)
        assert_equal(14, node.left_child.key)

        node = @tree.find(16)
        assert_nil(node.left_child)
    end
end