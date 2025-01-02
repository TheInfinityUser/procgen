local rooms = {}
local exits = {}

local roomCount = 40
local roomRemoveCount = 10
local roomWRange = { 3, 20 }
local roomHRange = { 3, 20 }
local roomXRange = { 20, 60 }
local roomYRange = { 20, 60 }

local log = ""

local function generateRooms()
	rooms = {}

	for i = 1, roomCount + roomRemoveCount do
		rooms[i] = {
			separator = {},
			dimensions = {}
		}

		local x = love.math.random(roomXRange[1], roomXRange[2])
		local y = love.math.random(roomYRange[1], roomYRange[2])
		local w = love.math.random(roomWRange[1], roomWRange[2])
		local h = love.math.random(roomHRange[1], roomHRange[2])

		rooms[i].dimensions.x = x;
		rooms[i].dimensions.y = y;
		rooms[i].dimensions.w = w;
		rooms[i].dimensions.h = h;

		rooms[i].separator.body = love.physics.newBody(World, (x + 0.5 * w) * 10, (y + 0.5 * h) * 10, "dynamic")
		rooms[i].separator.body:setFixedRotation(true)
		rooms[i].separator.shape = love.physics.newRectangleShape((w + 3) * 10, (h + 3) * 10)
		rooms[i].separator.fixture = love.physics.newFixture(rooms[i].separator.body, rooms[i].separator.shape)
	end

	log = log .. "\ngenerated rooms"
end

local function removeRooms()
	for i = 1, roomRemoveCount do
		local r = love.math.random(1, #rooms)
		table.remove(rooms, r)
	end

	log = log .. "\nremoved rooms"
end

local function generateExits()
	log = log .. "\ngenerated exits"
end

function love.load()
	love.physics.setMeter(10)
	World = love.physics.newWorld(0, 0, true)
end

local moveVel = { x = 0, y = 0 }
local worldPos = { x = 0, y = 0 }

function love.update(dt)
	for i = 1, 10 do
		World:update(0.01)
	end

	moveVel.x = (love.mouse.getX() - 400)
	moveVel.y = (love.mouse.getY() - 400)

	worldPos.x = worldPos.x - moveVel.x * dt
	worldPos.y = worldPos.y - moveVel.y * dt

	for i = 1, #rooms do
		rooms[i].dimensions.x = math.floor(rooms[i].separator.body:getX() / 10 - 0.5 * rooms[i].dimensions.w)
		rooms[i].dimensions.y = math.floor(rooms[i].separator.body:getY() / 10 - 0.5 * rooms[i].dimensions.h)
	end
end

function love.keypressed(key)
	if key == "1" then
		generateRooms()
	end
	if key == "2" and #rooms > roomCount then
		removeRooms()
	end
	if key == "3" then
		generateExits()
	end
end

local function drawGrid()
	for xy = 1, 79 do
		love.graphics.setColor(1.0, 1.0, 1.0, 0.1)
		love.graphics.line(
			xy * 10 + worldPos.x % 10,
			0 + worldPos.y % 10,
			xy * 10 + worldPos.x % 10,
			800 + worldPos.y % 10
		)
		love.graphics.line(
			0 + worldPos.x % 10,
			xy * 10 + worldPos.y % 10,
			800 + worldPos.x % 10,
			xy * 10 + worldPos.y % 10
		)
	end
	love.graphics.setColor(0.0, 0.0, 1.0, 0.5)
	love.graphics.circle("fill", worldPos.x + 400, worldPos.y + 400, 10)
end
local function drawRoom(room)
	love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
	love.graphics.circle("fill", room.dimensions.x * 10 + worldPos.x, room.dimensions.y * 10 + worldPos.y, 5)
	love.graphics.rectangle("line", room.dimensions.x * 10 + worldPos.x, room.dimensions.y * 10 + worldPos.y,
		room.dimensions.w * 10,
		room.dimensions.h * 10)
end
local function drawExit(exit)
	love.graphics.setColor(0.5, 1.0, 0.5, 0.5)
	if exit.direction == "top" then
		love.graphics.polygon("fill",
			exit.position.x * 10 + worldPos.x,
			exit.position.y * 10 + worldPos.y,
			(exit.position.x + 1) * 10 + worldPos.x,
			exit.position.y * 10 + worldPos.y,
			(exit.position.x + 0.5) * 10 + worldPos.x,
			(exit.position.y - 0.5) * 10 + worldPos.y
		)
	elseif exit.direction == "bottom" then
		love.graphics.polygon("fill",
			exit.position.x * 10 + worldPos.x,
			exit.position.y * 10 + worldPos.y,
			(exit.position.x + 1) * 10 + worldPos.x,
			exit.position.y * 10 + worldPos.y,
			(exit.position.x + 0.5) * 10 + worldPos.x,
			(exit.position.y + 0.5) * 10 + worldPos.y
		)
	elseif exit.direction == "left" then
		love.graphics.polygon("fill",
			exit.position.x * 10 + worldPos.x,
			exit.position.y * 10 + worldPos.y,
			exit.position.x * 10 + worldPos.x,
			(exit.position.y + 1) * 10 + worldPos.y,
			(exit.position.x - 0.5) * 10 + worldPos.x,
			(exit.position.y + 0.5) * 10 + worldPos.y
		)
	elseif exit.direction == "right" then
		love.graphics.polygon("fill",
			exit.position.x * 10 + worldPos.x,
			exit.position.y * 10 + worldPos.y,
			exit.position.x * 10 + worldPos.x,
			(exit.position.y + 1) * 10 + worldPos.y,
			(exit.position.x + 0.5) * 10 + worldPos.x,
			(exit.position.y + 0.5) * 10 + worldPos.y
		)
	end
end

function love.draw()
	love.graphics.print(log, 80, 80)
	drawGrid()
	for i = 1, #rooms do
		drawRoom(rooms[i])
	end
	for i = 1, #exits do
		drawExit(exits[i])
	end
end
