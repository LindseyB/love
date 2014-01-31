require "hero"
require "pick_up"

function love.load()
	math.randomseed(os.time())
	hero = Hero.create()
	hero:load()

	score = 0

	-- sounds
	pickup = PickUp:create("sprites/star.png", 70, 70, math.random(70, love.graphics.getWidth())-70, math.random(70, love.graphics.getHeight()-70))
	music = love.audio.newSource("audio/looperman-l-0782612-0069158-40a-soundscape-drown.wav")
	ting = love.audio.newSource("audio/196106__aiwha__ding.wav", "static")
	music:setLooping(true)
	music:play()

	background = love.graphics.newImage("sprites/background.jpg")
	font = love.graphics.newImageFont("sprites/font.png", "0123456789")
	score_dude = love.graphics.newImage("sprites/hud_p1Alt.png")
	love.graphics.setFont(font)
end

function love.update(dt)
	hero:update(dt)

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
	else
		hero:stop()
	end

	if pickup:collide(hero.x, hero.y, hero.width, hero.height) then
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

	hero:draw()
	pickup:draw()

	drawScore()
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