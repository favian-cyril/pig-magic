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

func reverse() -> int:
	if (_traverseIndex.size() == 0):
		return 0
	var lastIndex = _traverseIndex.pop_back()
	_currentNode = _root
	for i in _traverseIndex:
		if (!_currentNode.is_child_empty()):
			_currentNode = _currentNode.get_children()[i]
	return lastIndex
	
func get_indexes() -> Array[int]:
	return _traverseIndex
	
func get_current_node() -> SpellTreeNode:
	return _currentNode
	
func get_root() -> SpellTreeNode:
	return _root
