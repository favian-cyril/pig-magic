extends Control
signal spell_created(spell_components)
const VERBS = ['Cast', 'Conjure']
const ADJECTIVES = ['Ball of', 'Big Ball of']
const NOUNS_BALL = ['Fire', 'Ice', 'Earth']
const NOUNS_BIG_BALL = ['Fire', 'Ice', 'Earth', 'Lightning']

var currentIndex := 0
var itemListArray: Array[ItemList] = []
var ui_length := 0
var root := SpellTreeNode.new()
var tree := SpellTree.new(root)

func _ready():
	for verb in VERBS:
		root.add_children(SpellTreeNode.new(verb))
	var childrenRoot = root.get_children()
	for child in childrenRoot:
		for adj in ADJECTIVES:
			child.add_children(SpellTreeNode.new(adj))
		var childs = child.get_children()
		for c in childs:
			for n in NOUNS_BIG_BALL:
				c.add_children(SpellTreeNode.new(n))
	generate_new_list(root.get_children_spells())

func _input(event: InputEvent):
	var selected = itemListArray[-1]
	var isEdge = tree.get_current_node().get_children()[0].is_child_empty();
	if (event.is_action_pressed("ui_up")):
		if (currentIndex > 0):
			currentIndex -= 1
			selected.select(currentIndex)
	elif (event.is_action_pressed("ui_down")):
		if (currentIndex < selected.item_count - 1):
			currentIndex += 1
			selected.select(currentIndex)
	elif (event.is_action_pressed("ui_right") or event.is_action_pressed("ui_accept")):
		if (!isEdge):
			var currentNode = tree.traverse(currentIndex)
			currentIndex = 0
			generate_new_list(currentNode.get_children_spells())
		else:
			spell_created.emit(itemListArray)
			queue_free()
	elif (event.is_action_pressed("ui_left")):
		if (itemListArray.size() > 1):
			ui_length -= selected.size.x + 5
			selected.queue_free()
			itemListArray.pop_back()
			currentIndex = tree.reverse()

func generate_new_list(items: Array[String]):
	var NewList = ItemList.new()
	for i in items:
		NewList.add_item(i)
	var longestString = items.max()
	var longest = NewList.get_theme_font("BitPotion").get_string_size(longestString, HORIZONTAL_ALIGNMENT_LEFT, -1, NewList.get_theme_font_size("BitPotion"))
	NewList.size = Vector2(longest.x + 15, longest.y)
	NewList.auto_height = true
	NewList.position = Vector2(-30 + ui_length, -30)
	ui_length += longest.x + 20
	NewList.select(0)
	call_deferred('add_child', NewList)
	itemListArray.append(NewList)
