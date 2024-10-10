---@diagnostic disable: undefined-global
local started = false

function love.load()
    image1 = love.graphics.newImage("Untitled97_20241009160710.png")
    mainFont = love.graphics.newFont("retro-pixel-cute-mono.ttf", 20)
    watermarkFont = love.graphics.newFont("NotoSans-Black.ttf", 40)
    audio = love.audio.newSource("audio.ogg", "static")
end

timePassed = 0
transition1Time = 1.25
transition2Time = 4.09
whiteness = 0
transition3Time = 7.15
firstImageX = 0
animationTotalTime = 10.5
step = 0
function love.update(dt)
    if started then
        timePassed = timePassed + 1 * dt
    end
    if timePassed >= transition1Time and step == 0 then
        step = 1
    elseif timePassed >= transition2Time and step == 1 then
        step = 2
    elseif timePassed >= transition3Time and step == 3 then
        step = 4
    elseif timePassed >= animationTotalTime and step == 4 then
        started = false
    end
    if step == 1 then -- Transition 1: Hydraulic Press
        if slide1Scale > 0 then
            slide1Scale = slide1Scale - .01
        end
    elseif step == 2 then  -- Transition 2: Flashbang
        whiteness = whiteness + 1 * dt
        if whiteness >= 1 then
            step = 3
        end
    elseif step == 3 then
        if whiteness > 0 then
            whiteness = whiteness - 1 * dt
        end
    elseif step == 4 then -- Transition 3: xSlide
        if firstImageX > -677 then
            firstImageX = firstImageX - (677/1) * dt
        end
    end
end

slide1Scale = 1.0

function love.draw()
    if started == false and timePassed == 0 then
        -- Draws "Hello world!" at position x: 100, y: 200 with the custom font applied.
	    love.graphics.print("Setup a screen recorder then press SPACE when ready",mainFont, 5, 0)
    elseif started == true then
        print(timePassed)
        love.graphics.draw(image1,firstImageX,0) -- slided image
        love.graphics.draw(image1,firstImageX+677,0) -- finishing image
        love.graphics.draw(image1,0,(555/2)*(1-slide1Scale),0,1,slide1Scale) -- Hydraulic pressed image
    else
        love.graphics.print("animation finished",mainFont, 5, 0)
    end
    love.graphics.setColor(255, 255, 255, whiteness)
    love.graphics.rectangle("fill",0,0,677,555)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print({{1,1,1,.5},"13character5.bsky.social"},watermarkFont, 0, 500)
    
end

function love.keypressed(key, scancode, isrepeat)
    if key == "space" and timePassed == 0 then
        started = true
        love.audio.play(audio)
    --  love.event.quit()
    end
 end