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
                    # if the current key is less than the current key we need to select the 
                    # left hand track to traverse down
                    if current.key > node.key
                        property = 'left_child'
                    else
                        # we travese down the right hand side
                        property = 'right_child'
                    end

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