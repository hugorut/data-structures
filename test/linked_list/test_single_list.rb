require "minitest/autorun"
require "yaml"
require "./linked_list/single_link"

class TestSingleList < MiniTest::Test
    def setup
        @list = LinkedList::List.new
        @fixtures = YAML.load_file(File.dirname(__FILE__)+"/list_items.yaml")
    end
    
    def teardown
        @list = nil
        @fixture = nil
    end

    def make_dummy_node(fixture)
        identifier = fixture.keys[0]
        LinkedList::Node.new(identifier, fixture[identifier]['data'])
    end

    def insert_nodes
        @fixtures.each_with_index do |node_val, index|
            node = make_dummy_node(@fixtures[index])
            @list.insert(node)
        end
    end
    
    def test_create_a_node_with_attributes
        dummy = @fixtures.sample
        identifier = dummy.keys[0]
        node = make_dummy_node(dummy)

        assert_equal(identifier, node.identifier)
        assert_equal(dummy[identifier]['data'], node.data)

        node.next = node
        assert_equal(node, node.next)
    end

    def test_insert_node_at_begining_of_list
        dummy = @fixtures.sample
        node = make_dummy_node(dummy)
        @list.insert(node)

        assert_equal(@list.first_node, node)
        assert_equal(@list.first_node.next, nil)
    end

    def test_insert_node_at_begining_with_filled_list
        dummy = @fixtures.sample
        node = make_dummy_node(dummy)
        @list.insert(node)

        dummy = @fixtures.sample
        next_node = make_dummy_node(dummy)
        @list.insert(next_node)

        assert_equal(@list.first_node, next_node)
        assert_equal(@list.first_node.next, node)
    end

    def test_find_a_node_returns_present_node
        insert_nodes

        expected_node = @fixtures.sample
        found_node = @list.find(expected_node.keys[0])

        assert_equal(expected_node[expected_node.keys[0]]['data'], found_node.data)
    end

    def test_find_a_node_returns_nil_for_not_present
        insert_nodes

        found_node = @list.find('no-found')

        assert_nil(found_node)
    end

    def test_insert_a_node_after_a_identified_node
        insert_nodes
        expected_node = @fixtures.sample
        identifier = expected_node.keys[0]
        
        found_node = @list.find(identifier)
        expected_next = found_node.next
        
        node = make_dummy_node({'scarecrow' => {'data' => 'none'}})
        @list.insert(node, identifier)

        found_node = @list.find(identifier)
        assert_equal(node, found_node.next)

        found_node = @list.find('scarecrow')
        assert_equal(expected_next, found_node.next)
    end

    def test_remove_a_node_from_the_list
        insert_nodes
        expected_node = @fixtures.sample
        identifier = expected_node.keys[0]

        @list.remove(identifier)

        assert_nil(@list.find(identifier))
    end       

    def test_remove_first_node_from_the_list
        insert_nodes
        expected_node = @fixtures[3]
        identifier = expected_node.keys[0]

        @list.remove(identifier)

        assert_nil(@list.find(identifier))
        assert_equal(@fixtures[2].keys[0], @list.first_node.identifier)
    end         

    def test_remove_a_non_valid_node_from_the_list
        insert_nodes
        expected_node = @fixtures.sample
        identifier = expected_node.keys[0]

        @list.remove('test')
    end
end