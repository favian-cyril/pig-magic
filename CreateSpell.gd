extends Control

const VERBS = ['Cast', 'Conjure']
const ADJECTIVES = ['Ball of', 'Big Ball of']
const NOUNS_BALL = ['Fire', 'Ice', 'Earth']
const NOUNS_BIG_BALL = ['Fire', 'Ice', 'Earth', 'Lightning']

var selectedIndex = 0
var selected: ItemList
var root = SpellTreeNode.new()
var tree = SpellTree.new(root)
# Called when the node enters the scene tree for the first time.
func _ready():
	for verb in VERBS:
		root.add_children(SpellTreeNode.new(verb))
	var childrenRoot = root.get_children()
	for child in childrenRoot:
		for adj in ADJECTIVES:
			child.add_children(SpellTreeNode.new(adj))
	var VerbsList = ItemList.new()
	for item in root.get_children():
		VerbsList.add_item(item.get_spell_name())
	VerbsList.size = Vector2(40, 40)
	VerbsList.load("res://FontTheme.tres")
	call_deferred('add_child', VerbsList)
	selected = VerbsList
	selected.select(selectedIndex)
	print(selected.position, selected.get_rect(), selected.z_index)

func _input(event: InputEvent):
	selected.select(selectedIndex)
	if (event.is_action_pressed("ui_up")):
		if (selectedIndex > 0):
			selectedIndex -= 1
			selected.select(selectedIndex)
	elif (event.is_action_pressed("ui_down")):
		if (selectedIndex <= selected.item_count):
			selectedIndex += 1
			selected.select(selectedIndex)
	elif (event.is_action_pressed("ui_right")):
		if (!tree.get_current_node().is_child_empty()):
			var currentNode = tree.traverse(selectedIndex)
			generate_new_list(currentNode.get_children_spells())
	elif (event.is_action_pressed("ui_left")):
		if (tree.get_current_node() != root):
			selected.queue_free()
			

func generate_new_list(items: Array[String]):
	var NewList = ItemList.new()
	for i in items:
		NewList.add_item(i)
	selected = NewList
