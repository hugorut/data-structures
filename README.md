#Data Structures in Ruby
A collection of data structures built in ruby

##Linked List
Linked list is a data structure which is represented by a list of nodes, each of which are linked to the next and/or previous node. Unlike Vectors or ArrayLists, accessing elements in a linked list relies on traversing the list until the desired node is found. The large benefit that linked lists have over their vector counterparts is the ease of which insertion and deletion of nodes in the list can be implemented.

In  vector list when items are inserted or deleted the elements after the point of insertion and deletion have to be reindexed. Thus either each proceeding element must be moved ahead by one index if a insertion has occured, or moved backwards one index if a deletion has occured. Because all preceding elements have to be moved this action grows linear in time.

The main disadvantage to linked lists have over arrays are their ability to find elements. Because finding a specific node in a linked list requires you traverse elements until you find the corresponding element finding a node could, at work, take the size of the list to find an node (if the last node in the list). Thus finding elements in the list grows linearly with the growth of the list. In comparison arrays or vectors can find a specific element in constant time because of their indexing. 
###Single Link List
