GridSize = 10
WorldPosition = { x = 0, y = 0 }
Rooms = {}
Exits = {}

require("src.generator")
require("src.controller")
require("src.drawing")

function love.load()
	love.physics.setMeter(GridSize)
end

function love.update(dt)
	UpdateWorldPosition(dt)
end

function love.keypressed(key)
	if key == "1" then
		GenerateRooms()
	end
	if key == "2" then
		RemoveRooms()
	end
	if key == "3" then
		GenerateExits()
	end
end

function love.draw()
	love.graphics.applyTransform(love.math.newTransform(WorldPosition.x, WorldPosition.y))

	PrintGeneratorLog()
	for i = 1, #Rooms do
		DrawRoom(Rooms[i])
	end
	for i = 1, #Exits do
		DrawExit(Exits[i])
	end
end
