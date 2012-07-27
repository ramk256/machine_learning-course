
module CodingExercises
  def CodingExercises.mergesort(array)
    if array.length == 0 || array.length == 1
      return array
    end
    
    #otherwise split the array in 1/2 and merge it together
    halfway = array.length / 2 - 1
    left = array[0..halfway]
    right = array[halfway + 1..array.length - 1]
    
    left = mergesort(left)
    right = mergesort(right)
    
    return merge(left, right)
  end
    
  def CodingExercises.merge(array1, array2)
    array3 = []
    size = array1.length + array2.length
    firstIndex = 0
    secondIndex = 0
    
    for counter in 0..size - 1
      if (array2[secondIndex].nil? || (!array1[firstIndex].nil? && array1[firstIndex] < array2[secondIndex]))
        array3 << array1[firstIndex]
        firstIndex += 1
      else
        array3 << array2[secondIndex]
        secondIndex += 1
      end
    end
    
    return array3
  end
end

class Tree
  # @root is of type 'TreeNode'
  @root 
  
  def initialize(value)
    @root = TreeNode.new(value)
  end
  
  class TreeNode
    #this represents the value of the node
    attr_accessor :value, :right, :left
    
    def initialize(value)
      @value = value
      @right = nil
      @left = nil
    end
  end
  
  def insert(value)
    insertHelper(value, @root)
  end
  
  def insertHelper(value, curNode)
    if (curNode.value < value)
      if (curNode.right.nil?)
        curNode.right = TreeNode.new(value)
      else
        insertHelper(value, curNode.right)
      end
    else
      if (curNode.left.nil?)
        curNode.left = TreeNode.new(value)
      else
        insertHelper(value, curNode.left)
      end
    end
  end
  
  def printInOrder
     printInOrderHelper(@root)
  end
  
  
  def printInOrderHelper(curNode)
    if (!curNode.nil?)
      printInOrderHelper(curNode.left)
      puts curNode.value
      printInOrderHelper(curNode.right)
    end
  end
  
end

class LinkedList
  
  @head
  #let's have a subclass called Node represent the nodes of a linked list
  
  class Node
    attr_accessor :value, :next
    
    def initialize(value)
      @value = value
      @next = nil
    end
  end
  
  def initialize(value)
    @head = Node.new(value)
  end
  
  def append(value)
    newNode = Node.new(value)
    curNode = @head
    if curNode.nil?
      @head = newNode  
    end
    
    while (!curNode.next.nil?)
      curNode = curNode.next
    end
    
    curNode.next = newNode
  end
  
  def printList
    curNode = @head
    while (!curNode.nil?)
      puts curNode.value
      curNode = curNode.next
    end
  end
  
end

#output = CodingExercises.mergesort([5, 6, 1, 123, 49, 3, 84, 28])

#output.each do |x|
#  puts x
#end

#sample_tree = Tree.new(5)

#sample_tree.insert(6)
#sample_tree.insert(7)
#sample_tree.insert(123)
#sample_tree.insert(34)
#sample_tree.insert(44)
#sample_tree.insert(143)
#sample_tree.insert(98)
#sample_tree.printInOrder

new_list = LinkedList.new(3)

new_list.append(4)

new_list.append(5)

new_list.printList




