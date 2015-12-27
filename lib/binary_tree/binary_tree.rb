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
            parent = @root

            while current.key != index
                # store a parent variable in memory so that we can access it for deletion
                parent = current

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
            if block_given?
                yield parent, current, property
            else
                return current    
            end
        end

        # delete a specific node using an index key to locate it
        def delete_node(index)
            # find the index of the node and call the block in order to acess the properties
            # and parent required to keep the code DRY
            find(index) do |parent, to_be_deleted, property|
                if to_be_deleted.left_child.nil? and to_be_deleted.right_child.nil?
                    # if both the nodes left and right child are nil then this means we can
                    # simply remove the node without having to do any extra leg work
                    set_replacement(parent, to_be_deleted, nil, property)
                elsif to_be_deleted.right_child.nil?
                    # if just the right child is nil then all we have to do is move up the left_child                
                    replacement = to_be_deleted.left_child
                    set_replacement(parent, to_be_deleted, replacement, property)      
                elsif to_be_deleted.left_child.nil?
                    # if jus the left child is nil then all we have to do is move up the right_child
                    replacement = to_be_deleted.right_child
                    set_replacement(parent, to_be_deleted, replacement, property) 
                else
                    # otherwise we need to locate the lowest left child of tree, we store it in a pointer 
                    # in memory and then delete it from the tree by calling the method again
                    replacement = min_left_child(to_be_deleted.right_child)
                    delete_node(replacement.key)

                    # then we assing the node to be deleted left and right child values
                    replacement.left_child = to_be_deleted.left_child 
                    replacement.right_child = to_be_deleted.right_child

                    # once the replacement node has the correct values and has been removed from its previous
                    # position we call the set replacement method on the node to be deleted parent in order
                    # to remove it from refrence in the tree
                    set_replacement(parent, to_be_deleted, replacement, property)
                end
            end
        end

        # set a replacement  by either sending a left_child or right_child to call
        # a setter method on the parent node
        def set_replacement(parent, node, replacement, property)
            if node == @root
                @root = replacement
            else
                  parent.send(property+'=',replacement)
            end
        end

        # find the min left value of the left children
        def min_left_child(node)
            if node.left_child.nil?
                return node
            end

            return min_left_child(node.left_child)
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