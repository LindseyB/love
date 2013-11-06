AnimatedSprite = {}
AnimatedSprite.__index = AnimatedSprite

function AnimatedSprite:create(file, width, height, frames)
	local object = {}

	setmetatable(object, AnimatedSprite)

	object.file = file
	object.width = width
	object.height = height
	object.frames = frames
	object.sprite_sheet = sprite_sheet
	object.sprites = {}
	object.current_frame = 1
	object.delay = 0.1
	object.delta = 0

	return object
end

function AnimatedSprite:load()
	local source = love.graphics.newImage(self.file)
	self.sprite_sheet = love.graphics.newImage(self.file)

	for i = 1, self.frames do
		local w = self.width * (i-1)
		self.sprites[i] = love.graphics.newQuad(w, 0, self.width, self.height, source:getWidth(), source:getHeight())
	end
end

function AnimatedSprite:update(dt)
	self.delta = self.delta + dt

	if self.delta >= self.delay then
		self.current_frame = (self.current_frame % self.frames) + 1
		self.delta = 0
	end
end

function AnimatedSprite:draw(x, y)
	love.graphics.drawq(self.sprite_sheet, self.sprites[self.current_frame], x, y)
end