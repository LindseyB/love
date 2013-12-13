require "animated_sprite"

function love.load()
	hero = {}
	hero.x = 300
	hero.y = 400
	hero.speed = 300
	animation = AnimatedSprite:create("sprites/hero.png", 32, 32, 4, 4)
	animation:load()
end

function love.update(dt)
	animation:update(dt)

	if love.keyboard.isDown("left") then
		hero.x = hero.x - hero.speed * dt
		animation:set_animation_direction(animation.Directions.Left)
	elseif love.keyboard.isDown("right") then
		hero.x = hero.x + hero.speed*dt
		animation:set_animation_direction(animation.Directions.Right)
	elseif love.keyboard.isDown("up") then
		hero.y = hero.y - hero.speed*dt
		animation:set_animation_direction(animation.Directions.Up)
	elseif love.keyboard.isDown("down") then
		hero.y = hero.y + hero.speed*dt
		animation:set_animation_direction(animation.Directions.Down)
	elseif love.keyboard.isDown("q") then
		love.event.push('quit')
	else
		animation:set_animation(false)
	end
end

function love.draw()
	love.graphics.setColor(255,255,255,255)
	animation:draw(hero.x, hero.y)
end
