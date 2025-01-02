local controlVelocity = { x = 0, y = 0 }

function UpdateWorldPosition(dt)
	controlVelocity.x = (love.mouse.getX() - love.graphics.getWidth() / 2)
	controlVelocity.y = (love.mouse.getY() - love.graphics.getHeight() / 2)

	WorldPosition.x = WorldPosition.x - controlVelocity.x * dt
	WorldPosition.y = WorldPosition.y - controlVelocity.y * dt
end
