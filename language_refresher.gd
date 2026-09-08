extends Node

# Stores the original English text of every UI node
var original_texts := {}

func _ready():
	# Refresh UI when language changes
	Localization.language_changed.connect(_refresh_all_ui)

	# Refresh UI when scenes change
	get_tree().tree_changed.connect(_refresh_all_ui)


func _refresh_all_ui():
	var root := get_tree().current_scene
	if root == null:
		return

	# Apply correct font globally
	if Engine.has_singleton("UiTheme"):
		UiTheme.apply_language_font(Localization.LANG)

	# Update all UI nodes
	_update_node_recursive(root)


func _update_node_recursive(node):
	# Update Label
	if node is Label:
		_store_original_text(node)
		node.text = Localization.translate(original_texts[node])

	# Update Button
	if node is Button:
		_store_original_text(node)
		node.text = Localization.translate(original_texts[node])

	# Continue recursion
	for child in node.get_children():
		_update_node_recursive(child)


func _store_original_text(node):
	if not original_texts.has(node):
		original_texts[node] = node.text
