require "animated_sprite"

function love.load()
	hero = {}
	hero.x = 300
	hero.y = 400
	hero.speed = 300
	-- hero_sprite = love.graphics.newImage("sprites/mouse.png")
	animation = AnimatedSprite:create("sprites/hero_sprites.png", 64, 128, 10)
	animation:load()
end

function love.update(dt)
	animation:update(dt)

	if love.keyboard.isDown("left") then
		hero.x = hero.x - hero.speed * dt
		animation:set_animation(true)
	elseif love.keyboard.isDown("right") then
		hero.x = hero.x + hero.speed*dt
		animation:set_animation(true)
	elseif love.keyboard.isDown("q") then
		love.event.push('quit')
	else
		animation:set_animation(false)
	end
end

function love.draw()
	love.graphics.setColor(0,255,0,255)
	love.graphics.rectangle("fill", 0, 465, 800, 150)

	love.graphics.setColor(255,255,255,255)
	animation:draw(hero.x, hero.y)
	-- love.graphics.draw(hero_sprite, hero.x, hero.y)
end