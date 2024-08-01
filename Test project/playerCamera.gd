extends Camera2D

var mapTile:Vector2 = Vector2(1,1)
var tileSize:Vector2 = Vector2(1088,736)
# Called when the node enters the scene tree for the first time.
func _ready():
	setCamera()
	print("snowman")
	print("(o.o)/")
	print("/(:)")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player = get_parent().global_position
	if player.x < limit_left:
		mapTile.x -= 1
		setCamera()
	if player.x > limit_right:
		mapTile.x += 1
		setCamera()
	if player.y < limit_top:
		mapTile.y -= 1
		setCamera()
	if player.y > limit_bottom:
		mapTile.y += 1
		setCamera()

func setCamera():
	limit_left = (mapTile.x - 1) * tileSize.x
	limit_right = mapTile.x * tileSize.x
	limit_top = (mapTile.y - 1) * tileSize.y
	limit_bottom = mapTile.y * tileSize.y
