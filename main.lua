function love.load()
	hero = {}
	hero.x = 300
	hero.y = 400
	hero.speed = 300
end

function love.update(dt)
	if love.keyboard.isDown("left") then
		hero.x = hero.x - hero.speed * dt
	elseif love.keyboard.isDown("right") then
		hero.x = hero.x + hero.speed*dt
	elseif love.keyboard.isDown("q") then
		love.event.push('quit')
	end
end

function love.draw()
	love.graphics.setColor(0,255,0,255)
	love.graphics.rectangle("fill", 0, 465, 800, 150)

	love.graphics.setColor(255,255,0,255)
	love.graphics.rectangle("fill",hero.x,hero.y, 30, 65)
end