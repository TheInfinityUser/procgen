function DrawRoom(room)
	love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
	love.graphics.circle(
		"fill",
		room.dimensions.x * GridSize,
		room.dimensions.y * GridSize,
		5
	)
	love.graphics.rectangle(
		"line",
		room.dimensions.x * GridSize,
		room.dimensions.y * GridSize,
		room.dimensions.w * GridSize,
		room.dimensions.h * GridSize
	)
end

function DrawExit(exit)
	love.graphics.setColor(0.5, 1.0, 0.5, 0.5)
	if exit.direction == "top" then
		love.graphics.polygon("fill",
			exit.position.x * GridSize,
			exit.position.y * GridSize,
			(exit.position.x + 1) * GridSize,
			exit.position.y * GridSize,
			(exit.position.x + 0.5) * GridSize,
			(exit.position.y - 0.5) * GridSize
		)
	elseif exit.direction == "bottom" then
		love.graphics.polygon("fill",
			exit.position.x * GridSize,
			exit.position.y * GridSize,
			(exit.position.x + 1) * GridSize,
			exit.position.y * GridSize,
			(exit.position.x + 0.5) * GridSize,
			(exit.position.y + 0.5) * GridSize
		)
	elseif exit.direction == "left" then
		love.graphics.polygon("fill",
			exit.position.x * GridSize,
			exit.position.y * GridSize,
			exit.position.x * GridSize,
			(exit.position.y + 1) * GridSize,
			(exit.position.x - 0.5) * GridSize,
			(exit.position.y + 0.5) * GridSize
		)
	elseif exit.direction == "right" then
		love.graphics.polygon("fill",
			exit.position.x * GridSize,
			exit.position.y * GridSize,
			exit.position.x * GridSize,
			(exit.position.y + 1) * GridSize,
			(exit.position.x + 0.5) * GridSize,
			(exit.position.y + 0.5) * GridSize
		)
	end
end
