local world

local roomCount = 40
local roomRemoveCount = math.floor(roomCount / 4)
local roomSeparatorPadding = 1
local roomWRange = { 3, 20 }
local roomHRange = { 3, 20 }
local roomSpawnRadius = math.floor(roomCount / 2)
local exitDensity = 1 / 5

local log = ""

local function randomPointInCircle(radius)
	local x = love.math.random(-radius, radius)
	local y = love.math.random(-radius, radius)

	if x * x + y * y > radius * radius then
		return randomPointInCircle(radius)
	end

	return x + love.graphics.getWidth() / 2 / GridSize, y + love.graphics.getHeight() / 2 / GridSize
end

local function randomIntInRangeCeil(min, max, k)
	return min + math.ceil((max - min) * math.pow(love.math.random(1, 100) / 100, k))
end
local function randomIntInRangeFloor(min, max, k)
	return min + math.floor((max - min) * math.pow(love.math.random(1, 100) / 100, k))
end

function GenerateRooms()
	world = love.physics.newWorld(0, 0, true)

	Rooms = {}
	Exits = {}

	for i = 1, roomCount + roomRemoveCount do
		Rooms[i] = {
			separator = {},
			dimensions = {}
		}

		local x, y = randomPointInCircle(roomSpawnRadius)
		local w = randomIntInRangeCeil(roomWRange[1], roomWRange[2], 2)
		local h = randomIntInRangeCeil(roomHRange[1], roomHRange[2], 2)

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

	log = "1 -> generated rooms"
end

function SeparateRooms()
	if not world then
		return
	end
	for i = 1, 100 do
		world:update(0.01)
	end

	for i = 1, #Rooms do
		Rooms[i].dimensions.x = math.floor(Rooms[i].separator.body:getX() / GridSize - 0.5 * Rooms[i].dimensions.w)
		Rooms[i].dimensions.y = math.floor(Rooms[i].separator.body:getY() / GridSize - 0.5 * Rooms[i].dimensions.h)
	end
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
	Exits = {}

	local function removeTriplet(elements, centreElement)
		for i, v in ipairs(elements) do
			if v == centreElement then
				table.remove(elements, i)
			end
		end
	end

	for i = 1, #Rooms do
		local exitsTop = {}
		local exitsBottom = {}
		local exitsLeft = {}
		local exitsRight = {}

		for j = 1, Rooms[i].dimensions.w do
			table.insert(exitsTop, j)
			table.insert(exitsBottom, j)
		end
		for j = 1, Rooms[i].dimensions.h do
			table.insert(exitsLeft, j)
			table.insert(exitsRight, j)
		end

		local exitCountTop = 0
		local exitCountBottom = 0
		local exitCountLeft = 0
		local exitCountRight = 0

		while exitCountTop + exitCountBottom + exitCountLeft + exitCountRight == 0 do
			exitCountTop = randomIntInRangeFloor(0, math.ceil(Rooms[i].dimensions.w * exitDensity), 2)
			exitCountBottom = randomIntInRangeFloor(0, math.ceil(Rooms[i].dimensions.w * exitDensity), 2)
			exitCountLeft = randomIntInRangeFloor(0, math.ceil(Rooms[i].dimensions.h * exitDensity), 2)
			exitCountRight = randomIntInRangeFloor(0, math.ceil(Rooms[i].dimensions.h * exitDensity), 2)
		end

		local position
		for j = 1, exitCountTop do
			position = exitsTop[love.math.random(1, #exitsTop)]
			removeTriplet(exitsTop, position)
			table.insert(Exits, {
				position = {
					x = Rooms[i].dimensions.x + position - 1,
					y = Rooms[i].dimensions.y
				},
				direction = "top"
			})
		end
		for j = 1, exitCountBottom do
			position = exitsBottom[love.math.random(1, #exitsBottom)]
			removeTriplet(exitsBottom, position)
			table.insert(Exits, {
				position = {
					x = Rooms[i].dimensions.x + position - 1,
					y = Rooms[i].dimensions.y + Rooms[i].dimensions.h
				},
				direction = "bottom"
			})
		end
		for j = 1, exitCountLeft do
			position = exitsLeft[love.math.random(1, #exitsLeft)]
			removeTriplet(exitsLeft, position)
			table.insert(Exits, {
				position = {
					x = Rooms[i].dimensions.x,
					y = Rooms[i].dimensions.y + position - 1
				},
				direction = "left"
			})
		end
		for j = 1, exitCountRight do
			position = exitsRight[love.math.random(1, #exitsRight)]
			removeTriplet(exitsRight, position)
			table.insert(Exits, {
				position = {
					x = Rooms[i].dimensions.x + Rooms[i].dimensions.w,
					y = Rooms[i].dimensions.y + position - 1
				},
				direction = "right"
			})
		end
	end

	log = log .. "\n3 -> generated exits"
end

function PrintGeneratorLog()
	love.graphics.setColor(0.5, 1.0, 0.5, 0.5)
	love.graphics.print(log, 10, 10)
	love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
end
