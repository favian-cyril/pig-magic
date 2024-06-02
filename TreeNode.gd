class_name SpellTreeNode

var _spellName: String
var _children: Array[SpellTreeNode]

func _init(name: String = '', child: Array[SpellTreeNode] = []):
	_spellName = name
	_children = child

func get_children() -> Array[SpellTreeNode]:
	return _children

func get_children_spells() -> Array[String]:
	var result: Array[String] = []
	for child in _children:
		result.append(child.get_spell_name())
	return result

func get_spell_name() -> String:
	return _spellName

func set_spell_name(name: String) -> void:
	_spellName = name

func add_children(node: SpellTreeNode) -> void:
	_children.append(node)
	
func is_child_empty() -> bool:
	return _children.size() == 0
	
