local world

local roomCount = 20
local roomRemoveCount = 5
local roomSeparatorPadding = 3
local roomWRange = { 3, 20 }
local roomHRange = { 3, 20 }
local roomXRange = { 20, 60 }
local roomYRange = { 20, 60 }

local log = ""

function GenerateRooms()
	world = love.physics.newWorld(0, 0, true)

	Rooms = {}

	for i = 1, roomCount + roomRemoveCount do
		Rooms[i] = {
			separator = {},
			dimensions = {}
		}

		local x = love.math.random(roomXRange[1], roomXRange[2])
		local y = love.math.random(roomYRange[1], roomYRange[2])
		local w = love.math.random(roomWRange[1], roomWRange[2])
		local h = love.math.random(roomHRange[1], roomHRange[2])

		Rooms[i].dimensions.x = x;
		Rooms[i].dimensions.y = y;
		Rooms[i].dimensions.w = w;
		Rooms[i].dimensions.h = h;

		Rooms[i].separator.body = love.physics.newBody(
			world,
			(x + 0.5 * w) * GridSize,
			(y + 0.5 * h) * GridSize,
			"dynamic"
		)
		Rooms[i].separator.body:setFixedRotation(true)
		Rooms[i].separator.shape = love.physics.newRectangleShape(
			(w + roomSeparatorPadding) * GridSize,
			(h + roomSeparatorPadding) * GridSize
		)
		Rooms[i].separator.fixture = love.physics.newFixture(
			Rooms[i].separator.body,
			Rooms[i].separator.shape
		)
	end

	local separated
	while not separated do
		world:update(0.01)
		for i = 1, #Rooms do
			separated = not Rooms[i].separator.body:isAwake()
		end
	end

	for i = 1, #Rooms do
		Rooms[i].dimensions.x = math.floor(Rooms[i].separator.body:getX() / GridSize - 0.5 * Rooms[i].dimensions.w)
		Rooms[i].dimensions.y = math.floor(Rooms[i].separator.body:getY() / GridSize - 0.5 * Rooms[i].dimensions.h)
	end

	log = "1 -> generated rooms"
end

function RemoveRooms()
	if #Rooms <= roomCount then
		return
	end
	for i = 1, roomRemoveCount do
		local r = love.math.random(1, #Rooms)
		table.remove(Rooms, r)
	end

	log = log .. "\n2 -> removed rooms"
end

function GenerateExits()
	log = log .. "\n3 -> generated exits"
end

function PrintGeneratorLog()
	love.graphics.setColor(0.5, 1.0, 0.5, 0.5)
	love.graphics.print(log, 10, 10)
	love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
end
