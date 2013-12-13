require "hero"

function love.load()
	hero = Hero.create()
	hero:load()
end

function love.update(dt)
	Hero:update(dt)

	-- todo: move all the hero movement to a different file to be called in this loop
	if love.keyboard.isDown("left") then
		hero:move(hero.Directions.Left, dt)
	elseif love.keyboard.isDown("right") then
		hero:move(hero.Directions.Right, dt)
	elseif love.keyboard.isDown("up") then
		hero:move(hero.Directions.Up, dt)
	elseif love.keyboard.isDown("down") then
		hero:move(hero.Directions.Down, dt)
	elseif love.keyboard.isDown("q") then
		love.event.push('quit')
	else
		hero:stop()
	end
end

function love.draw()
	love.graphics.setColor(255,255,255,255)
	hero:draw()
end
