extends StaticBody2D
@export var itemsNames: String = ""
@onready var player = get_tree().get_first_node_in_group("player")
@onready var keluarga = get_tree().get_first_node_in_group("fotoKeluarga")
@onready var chatBox = get_tree().get_first_node_in_group("chatBox")
@onready var ruangTamu = get_tree().get_first_node_in_group("ruangTamu")
@onready var mindBox = get_tree().get_first_node_in_group("mindBox")
var canInterac = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if itemsNames == "Foto":
		$Sprite2D.frame = 2
		
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("action") and canInterac == true:
		if itemsNames == "Foto":
			print("pentilkuda")
		else:
			televisionScane()
			
	if event.is_action_pressed("ui_cancel"):
		if itemsNames == "Foto":
			print("pentilkuda")
		else:
			matikanManual()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		canInterac = true
		player.tampilkan(itemsNames)
		
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		canInterac = false
		player.noTampilkan()
		if GameState.aksesTV == true:
			mindBox.afterTV()
		else:
			pass
		
		
func televisionScane():
	$Sprite2D.frame = 1
	GameState.tvHidup = true
	chatBox.tampilkanBerita(0)
		
		
func matikanTV():
	await get_tree().create_timer(0.3).timeout
	$Sprite2D.frame = 0
	GameState.tvHidup = false
	GameState.karakterCanMove = false
	if GameState.ruangTamu == true:
		GameState.karakterCanMove = true
	else :
		ruangTamu.gelapkanRuangan()
		await get_tree().create_timer(0.5).timeout
		keluarga.fotoKelapKelip()
	
	
func matikanManual():
	await get_tree().create_timer(0.3).timeout
	chatBox.matikanBerita()
	$Sprite2D.frame = 0
	GameState.tvHidup = false

	
