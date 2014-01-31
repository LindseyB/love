PickUp = {}
PickUp.__index = PickUp

function PickUp:create(file, width, height, x, y)
	local object = {}

	setmetatable(object, PickUp)

	object.image = love.graphics.newImage(file)
	object.x = x
	object.y = y
	object.width = width
	object.height = height
	object.quad = love.graphics.newQuad(0, 0, width, height, object.image:getWidth(), object.image:getHeight())

	return object
end

function PickUp:draw()
	love.graphics.draw(self.image, self.quad, self.x, self.y)
end

function PickUp:collide(x, y, w, h)
	return  x < self.x+self.width and
			self.x < x+w and
		 	y < self.y+self.height and
		 	self.y < y+h
end