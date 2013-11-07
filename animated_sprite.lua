AnimatedSprite = {}
AnimatedSprite.__index = AnimatedSprite

function AnimatedSprite:create(file, width, height, frames)
	local object = {}

	setmetatable(object, AnimatedSprite)

	object.width = width
	object.height = height
	object.frames = frames
	object.sprite_sheet = love.graphics.newImage(file)
	object.sprites = {}
	object.current_frame = 1
	object.delay = 0.08
	object.delta = 0
	object.animating = false
	object.direction = 1

	return object
end

function AnimatedSprite:load()
	for i = 1, self.frames do
		-- TODO: add support for multiple animations
		local w = self.width * (i-1)
		self.sprites[i] = love.graphics.newQuad(w, 0, self.width, self.height, self.sprite_sheet:getWidth(), self.sprite_sheet:getHeight())
	end
end

function AnimatedSprite:update(dt)
	if self.animating then
		self.delta = self.delta + dt

		if self.delta >= self.delay then
			self.current_frame = (self.current_frame % self.frames) + 1
			self.delta = 0
		end
	end
end

function AnimatedSprite:draw(x, y)
	love.graphics.drawq(self.sprite_sheet, self.sprites[self.current_frame], x, y, 0, self.direction, 1)
end

function AnimatedSprite:set_animation(animating)
	self.animating = animating

	if not animating then
		self.current_frame = 1
	end
end

function AnimatedSprite:set_animation_direction(direction)
	self.animating = true
	self.direction = direction
end
