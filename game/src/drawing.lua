function DrawGrid(rangeX, rangeY)
	love.graphics.setColor(1.0, 1.0, 1.0, 0.2)

	for i = rangeX[1], rangeX[2] do
		love.graphics.line(
			i * GridSize,
			rangeY[1] * GridSize,
			i * GridSize,
			rangeY[2] * GridSize
		)
	end
	for i = rangeY[1], rangeY[2] do
		love.graphics.line(
			rangeX[1] * GridSize,
			i * GridSize,
			rangeX[2] * GridSize,
			i * GridSize
		)
	end
end

function DrawRoom(room)
	love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
	love.graphics.rectangle(
		"line",
		room.dimensions.x * GridSize,
		room.dimensions.y * GridSize,
		room.dimensions.w * GridSize,
		room.dimensions.h * GridSize
	)
end

function DrawExit(exit)
	if exit.direction == "top" then
		love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
		love.graphics.line(
			exit.position.x * GridSize,
			exit.position.y * GridSize,
			exit.position.x * GridSize,
			(exit.position.y - 1) * GridSize
		)
		love.graphics.line(
			(exit.position.x + 1) * GridSize,
			exit.position.y * GridSize,
			(exit.position.x + 1) * GridSize,
			(exit.position.y - 1) * GridSize
		)
		love.graphics.setColor(1.0, 1.0, 1.0, 0.2)
		love.graphics.rectangle("fill",
			exit.position.x * GridSize,
			(exit.position.y - 1) * GridSize,
			GridSize,
			GridSize
		)
	elseif exit.direction == "bottom" then
		love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
		love.graphics.line(
			exit.position.x * GridSize,
			exit.position.y * GridSize,
			exit.position.x * GridSize,
			(exit.position.y + 1) * GridSize
		)
		love.graphics.line(
			(exit.position.x + 1) * GridSize,
			exit.position.y * GridSize,
			(exit.position.x + 1) * GridSize,
			(exit.position.y + 1) * GridSize
		)
		love.graphics.setColor(1.0, 1.0, 1.0, 0.2)
		love.graphics.rectangle("fill",
			exit.position.x * GridSize,
			exit.position.y * GridSize,
			GridSize,
			GridSize
		)
	elseif exit.direction == "left" then
		love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
		love.graphics.line(
			exit.position.x * GridSize,
			exit.position.y * GridSize,
			(exit.position.x - 1) * GridSize,
			exit.position.y * GridSize
		)
		love.graphics.line(
			exit.position.x * GridSize,
			(exit.position.y + 1) * GridSize,
			(exit.position.x - 1) * GridSize,
			(exit.position.y + 1) * GridSize
		)
		love.graphics.setColor(1.0, 1.0, 1.0, 0.2)
		love.graphics.rectangle("fill",
			(exit.position.x - 1) * GridSize,
			exit.position.y * GridSize,
			GridSize,
			GridSize
		)
	elseif exit.direction == "right" then
		love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
		love.graphics.line(
			exit.position.x * GridSize,
			exit.position.y * GridSize,
			(exit.position.x + 1) * GridSize,
			exit.position.y * GridSize
		)
		love.graphics.line(
			exit.position.x * GridSize,
			(exit.position.y + 1) * GridSize,
			(exit.position.x + 1) * GridSize,
			(exit.position.y + 1) * GridSize
		)
		love.graphics.setColor(1.0, 1.0, 1.0, 0.2)
		love.graphics.rectangle("fill",
			exit.position.x * GridSize,
			exit.position.y * GridSize,
			GridSize,
			GridSize
		)
	end
end
