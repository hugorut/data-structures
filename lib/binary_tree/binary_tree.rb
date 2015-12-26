module BinaryTree
    class Tree
        
        
    end

    class Node
        attr_accessor :left_child, :right_child
        attr_reader :index, :value

        def initialize(index, value)
            @index = index
            @value = value    
        end
        
    end
end