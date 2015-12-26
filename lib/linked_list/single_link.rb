module LinkedList
    class List
        attr_reader :first_node

        # initialize the list with an empty first node
        def initialize
            @first_node = nil
        end

        # insert a node into the list if an indentifier param is given then 
        # we attempt to find the node with the identifier and insert the
        # new node after it otherwise we insert the node at the begining
        def insert(node, identifier = nil)
            if identifier
                insert_after(node, identifier)
            else 
                node.next = @first_node
                @first_node = node
            end
        end

        # insert a node after a specific identifier of a node in the list
        def insert_after(node, identifier)
            after_node = find(identifier)

            if after_node
                current_after = after_node.next
                after_node.next = node
                node.next = current_after
                return true
            else
                # we return nil as we could not find the node to insert after
                return false
            end
        end

        # remove a node from the list
        def remove(identifier)
            # we want to set the previous next as the current next so that the
            # current is forgotten from the list
            find(identifier) do |previous, current|
                if current == @first_node
                    @first_node = current.next
                end

                previous.next = current.next
            end
        end

        # if the first link is equal to nil then we have nothing in the 
        # data structure and should return false
        def list_empty?
            return (@first_node == nil) ? true : false
        end

        # find a node by iterating over the list by advancing one node at a time 
        # until the nodes identifier is equal to the one we are searching for
        def find(identifier)
            # start at the begining of the list
            current = @first_node
            previous = @first_node
            
            if not list_empty?
                while current.identifier != identifier 
                    # advance the node one along
                    previous = current
                    current = current.next    

                    # we need to exit the while loop if the next node is nil
                    # as the list has reached the end of the line
                    return nil if (current == nil)    
                end

                # we want to yield the previous and current pointer if a block is
                # given so that we cna toy around with indexing and identifiers
                yield(previous, current) if block_given?
                
                # return the current node as we have a hit
                return current
            end
        end

        # print out the list
        def view
            node = @first_node
            puts '---------------------------'
            while node != nil
                puts node.identifier
                node = node.next
            end
            puts '---------------------------'
        end

    end

    class Node
        attr_accessor :next
        attr_reader :identifier, :data

        def initialize(identifier, data = {}, next_node = nil)
            @identifier = identifier
            @data = data
            @next = next_node
        end
    end
end