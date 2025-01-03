GridSize = 10
WorldPosition = { x = 0, y = 0 }
WorldScale = 1
Rooms = {}
Exits = {}

require("src.generator")
require("src.controller")
require("src.drawing")

function love.load()
	love.physics.setMeter(GridSize)
end

local s = false
function love.update(dt)
	UpdateWorldPosition(dt)
	SeparateRooms()
end

function love.wheelmoved(x, y)
	UpdateWorldZoom(y)
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
	PrintGeneratorLog()
	love.graphics.translate(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
	love.graphics.scale(WorldScale)
	love.graphics.translate(-love.graphics.getWidth() / 2, -love.graphics.getHeight() / 2)
	love.graphics.translate(WorldPosition.x, WorldPosition.y)
	DrawGrid({ 64 - 4 * 128, 64 + 4 * 128 }, { 36 - 4 * 72, 36 + 4 * 72 })
	for i = 1, #Rooms do
		DrawRoom(Rooms[i])
	end
	for i = 1, #Exits do
		DrawExit(Exits[i])
	end
end
