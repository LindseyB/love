require "animated_sprite"

Hero = {}
Hero.__index = Hero

function Hero:create()
	local object = {}

	setmetatable(object, Hero)

	object.x = 300
	object.y = love.graphics.getHeight()-97
	object.y_velocity = 0
	object.speed = 50
	object.animation = AnimatedSprite:create("sprites/sheet.png", 72, 97, 11, 2)
	object.gravity = 200
	object.jump_height = 300
	object.width = object.animation.width
	object.height = object.animation.height

	object.Directions = {
		["Down"] = 1,
		["Left"] = 2,
		["Right"] = 1,
		["Up"] = 1
	}

	return object
end

function Hero:load()
	self.animation:load()
end

function Hero:move(direction, dt)
	if direction == self.Directions.Down then
		self.y = self.y + self.speed * dt
		self.animation:set_animation_direction(self.animation.Directions.Down)
	end

	if direction == self.Directions.Left then
		self.x = self.x - self.speed * dt
		self.animation:set_animation_direction(self.animation.Directions.Left)
	end

	if direction == self.Directions.Right then
		self.x = self.x + self.speed * dt
		self.animation:set_animation_direction(self.animation.Directions.Right)
	end

	if direction == self.Directions.Up then
		self.y = self.y - self.speed * dt
		self.animation:set_animation_direction(self.animation.Directions.Up)
	end

	-- keep the self on the screen
	if self.x > love.graphics.getWidth() - self.width then self.x = love.graphics.getWidth() - self.width end
	if self.x < 0 then self.x = 0 end

	if self.y > love.graphics.getHeight() - self.height then self.y = love.graphics.getHeight() - self.height end
	if self.y < 0 then self.y = 0 end
end

function Hero:jump()
	--if self.y_velocity == 0 then
	self.y_velocity = self.jump_height
	--end
end

function Hero:stop()
	self.animation:set_animation(false)
end

function Hero:draw()
	self.animation:draw(self.x, self.y)
end

function Hero:update(dt)
	self.animation:update(dt)

	-- handle jump
	if self.y_velocity ~= 0 then
		self.y = self.y - self.y_velocity * dt
		self.y_velocity = self.y_velocity - self.gravity * dt
		if self.y > love.graphics.getHeight() - self.height then
			self.y_velocity = 0
		end
	end
end