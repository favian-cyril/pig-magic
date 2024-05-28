class_name SpellTree

var _root: SpellTreeNode
var _currentNode: SpellTreeNode
var _traverseIndex: Array[int] = []

func _init(rootNode: SpellTreeNode):
	_root = rootNode
	_currentNode = rootNode
	
func traverse(index: int) -> SpellTreeNode:
	if (_currentNode.is_child_empty()):
		return null
	_traverseIndex.append(index)
	_currentNode = _currentNode.get_children()[index]
	return _currentNode
	
func reverse() -> SpellTreeNode:
	_traverseIndex.pop_back()
	if (_traverseIndex.size() == 0):
		return null
	var lastNode
	for index in _traverseIndex:
		lastNode = traverse(index)
	return lastNode
	
func get_indexes() -> Array[int]:
	return _traverseIndex
	
func get_current_node() -> SpellTreeNode:
	return _currentNode
	
func get_root() -> SpellTreeNode:
	return _root
