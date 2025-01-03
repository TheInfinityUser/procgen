function DrawGrid(rangeX, rangeY)
	love.graphics.setLineWidth(1)
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
	love.graphics.setLineWidth(1)
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
	love.graphics.setLineWidth(4)
	love.graphics.setColor(0.5, 0.5, 1.0, 0.5)
	if exit.direction == "top" or exit.direction == "bottom" then
		love.graphics.line(
			(exit.position.x + 0.1) * GridSize,
			exit.position.y * GridSize,
			(exit.position.x + 0.9) * GridSize,
			exit.position.y * GridSize
		)
	elseif exit.direction == "left" or exit.direction == "right" then
		love.graphics.line(
			exit.position.x * GridSize,
			(exit.position.y + 0.1) * GridSize,
			exit.position.x * GridSize,
			(exit.position.y + 0.9) * GridSize
		)
	end
end
