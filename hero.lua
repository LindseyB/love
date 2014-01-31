require "animated_sprite"

Hero = {}
Hero.__index = Hero

function Hero:create()
	local object = {}

	setmetatable(object, Hero)

	object.x = 300
	object.y = love.graphics.getHeight()-32 
	object.y_velocity = 0
	object.speed = 50
	object.animation = AnimatedSprite:create("sprites/hero.png", 32, 32, 4, 4)
	object.gravity = 500
	object.jump_height = 200
	object.spite_size = 32

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
	if hero.x > love.graphics.getWidth() - hero.spite_size then hero.x = love.graphics.getWidth() - hero.spite_size end
	if hero.x < 0 then hero.x = 0 end

	if hero.y > love.graphics.getHeight() - hero.spite_size then hero.y = love.graphics.getHeight() - hero.spite_size end
	if hero.y < 0 then hero.y = 0 end
end

function Hero:jump()
	if hero.y_velocity == 0 then
		hero.y_velocity = hero.jump_height
	end
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
	if hero.y_velocity ~= 0 then
		hero.y = hero.y - hero.y_velocity * dt
		hero.y_velocity = hero.y_velocity - hero.gravity * dt
		if hero.y > love.graphics.getHeight() - hero.spite_size then
			hero.y_velocity = 0
		end
	end
end