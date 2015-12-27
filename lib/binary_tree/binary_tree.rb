module BinaryTree
    class Tree
        attr_reader :root

        def initialize
            @root = nil    
        end

        # add a node to the tree by travesing down either left or right side
        # until the appropriate value is found
        def add_node(key, value)
            node = Node.new(key, value)

            # if there is current no root node set for the tree we need to set it
            if root.nil?
                @root = node
            else
                # lets find where we need to place the node 
                current = @root
                placed = false

                while not placed
                    # get the property to travese, either left_child or right_child
                    property = direction(node.key, current.key)

                    # set a pointer to remember the previous loops node value and
                    # change the current value current based on the property flag 
                    parent = current
                    current = current.send(property)

                    # if the node under examination is nil then this means we have found
                    # a spot to place the current node and we set the placed flag to 
                    # true in order to exit out of the loop
                    if current.nil?
                        parent.send(property+'=', node)
                        placed = true
                    end
                end

            end
        end

        # find the direction to placed the node using a comparison against the node to be placed
        # and the current node under inspection
        def direction(find_index, current_index)
            # if the current key is less than the current key we need to select the 
            # left hand track to traverse down
            if current_index > find_index
                return 'left_child'
            else
                # we travese down the right hand side
                return 'right_child'
            end
        end

        # find a node in the tree using a index key
        def find(index)
            current = @root

            while current.key != index
                # get the property to travese, either left_child or right_child
                # then set current to equal that traversal
                property = direction(index, current.key)
                current = current.send(property)

                # if the next node is nil then we need to exit out the loop as the index
                # does not exist in the tree
                if current.nil?
                    return false
                end
            end

            # we've found the node! return it
            return current
        end

        # traverse the tree in order of accending value and yield
        # a block with the node as a parameter if given
        def travese_in_order(node = @root)
            return if node == nil
            
            travese_in_order(node.left_child)
            yield node if block_given?
            travese_in_order(node.right_child)
        end
    end

    class Node
        attr_accessor :left_child, :right_child
        attr_reader :key, :value

        def initialize(key, value)
            @key = key
            @value = value    
        end
    end
end