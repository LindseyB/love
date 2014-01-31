require "hero"
require "pick_up"

function love.load()
	math.randomseed(os.time())
	hero = Hero.create()
	hero:load()

	score = 0
	game_over = false

	-- sounds
	pickup = PickUp:create("sprites/star.png", 70, 70, math.random(70, love.graphics.getWidth())-70, math.random(70, love.graphics.getHeight()-70))
	music = love.audio.newSource("audio/looperman-l-0782612-0069158-40a-soundscape-drown.wav")
	ting = love.audio.newSource("audio/196106__aiwha__ding.wav", "static")
	music:setLooping(true)
	music:play()

	background = love.graphics.newImage("sprites/background.jpg")
	particle = love.graphics.newImage("sprites/star.png")
	
	-- fonts	
	score_font = love.graphics.newImageFont("sprites/font.png", "0123456789")
	game_over_font = love.graphics.newFont("fonts/orangejuice.ttf", 72)
	game_over_font_small = love.graphics.newFont("fonts/orangejuice.ttf", 36)
	score_dude = love.graphics.newImage("sprites/hud_p1Alt.png")

	love.graphics.setFont(score_font)

	-- lets try particles
	system = love.graphics.newParticleSystem(particle, 10)
	system:setEmissionRate(100)
	system:setSpeed(300)
	system:setLinearAcceleration(0,0,0,0)
	system:setSizes(0.5)
	system:setColors(255, 255, 255, 170)
	system:setPosition(0, 0)
	system:setEmitterLifetime(1)
	system:setParticleLifetime(1,1)
	system:setDirection(0)
	system:setSpread(360)
	system:setRadialAcceleration(-1000,-1000)
	system:setTangentialAcceleration(1000,1000)
	system:stop()
	system_x = 0
	system_y = 0
end

function love.update(dt)
	hero:update(dt)

	if hero:lose() then
		love.graphics.setFont(game_over_font)
		game_over = true
	end

	system:update(dt)

	if love.keyboard.isDown("left") then
		hero:move(hero.Directions.Left, dt)
	elseif love.keyboard.isDown("right") then
		hero:move(hero.Directions.Right, dt)
	elseif love.keyboard.isDown("up") then
		hero:jump()
		--hero:move(hero.Directions.Up, dt)
	elseif love.keyboard.isDown("down") then
		--hero:move(hero.Directions.Down, dt)
	elseif love.keyboard.isDown("q") then
		love.event.push('quit')
	elseif love.keyboard.isDown("return") and game_over then
		resetGame()
	else
		hero:stop()
	end

	if pickup:collide(hero.x, hero.y, hero.width, hero.height) then
		system_x, system_y = pickup.x, pickup.y
		system:stop()
		system:start()
		ting:stop()
		ting:play()
		score = score + 1
		pickup = PickUp:create("sprites/star.png", 70, 70, math.random(70, love.graphics.getWidth()-70), math.random(70, love.graphics.getHeight())-70)
	end
end

function love.draw()
	love.graphics.setBackgroundColor(0,0,0)
	love.graphics.setColor(255,255,255,255)
	drawBackground()

	if game_over then
		drawGameover()
	else
		love.graphics.draw(system, system_x, system_y)
		hero:draw()
		pickup:draw()
		drawScore()
	end
end

function drawBackground()
	for i = 1, math.ceil(love.graphics.getWidth()/background:getWidth()) do
		for j = 1, math.ceil(love.graphics.getHeight()/background:getHeight()) do
			love.graphics.draw(background, (i-1)*background:getWidth(), (j-1)*background:getHeight())
		end
	end
end

function drawScore()
	love.graphics.draw(score_dude, 10, 10)
	love.graphics.print(score, 70, 15)
end

function drawGameover()
	love.graphics.setColor(255,255,255,255)
	love.graphics.printf("Drifted Out to Space", 0, love.graphics.getHeight()/2, love.graphics.getWidth(), "center")
	love.graphics.setFont(game_over_font_small)
	love.graphics.printf("Final score: " .. score, 0, love.graphics.getHeight()/2 + game_over_font:getHeight(), love.graphics.getWidth(), "center")
	love.graphics.printf("Press Enter to Play Again", 0, love.graphics.getHeight()/2 + game_over_font:getHeight() + game_over_font_small:getHeight(), love.graphics.getWidth(), "center")

end

function resetGame()
	pickup = PickUp:create("sprites/star.png", 70, 70, math.random(70, love.graphics.getWidth())-70, math.random(70, love.graphics.getHeight()-70))
	love.graphics.setFont(score_font)
	score = 0
	hero:reset()
	game_over = false
end
