require "animated_sprite"

Hero = {}
Hero.__index = Hero

function Hero:create()
	local object = {}

	setmetatable(object, Hero)

	object.x = 300
	object.y = 400
	object.speed = 50
	object.animation = AnimatedSprite:create("sprites/hero.png", 32, 32, 4, 4)

	object.Directions = {
		["Down"] = 1,
		["Left"] = 2,
		["Right"] = 3,
		["Up"] = 4
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

	-- keep the hero on the screen
	if hero.x > love.graphics.getWidth()-32 then hero.x = love.graphics.getWidth()-32 end
	if hero.x < 0 then hero.x = 0 end

	if hero.y > love.graphics.getHeight()-32 then hero.y = love.graphics.getHeight()-32 end
	if hero.y < 0 then hero.y = 0 end
end

function Hero:stop()
	self.animation:set_animation(false)
end

function Hero:draw()
	self.animation:draw(self.x, self.y)
end

function Hero:update(dt)
	self.animation:update(dt)
end