--[[

    Credit for art:

    Credit for music:

]]

require 'src/Dependencies'

function love.load()
    love.window.setTitle('Project')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    math.randomseed(os.time())

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    gStateStack = StateStack()
    gStateStack:push(StartState())

    love.keyboard.keysPressed = {}
    love.mouse.keysPressed = {}
    love.mouse.keysReleased = {}
    love.mouse.wheelMoved = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    love.keyboard.keysPressed[key] = true
end

function love.wheelmoved(x, y)
    if x>0 then
        love.mouse.wheelMoved[1] = true
    end
    if x<0 then
        love.mouse.wheelMoved[2] = true
    end
    if y>0 then
        love.mouse.wheelMoved[3] = true
    end
    if y<0 then
        love.mouse.wheelMoved[4] = true
    end
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.mousepressed(x, y, key)
    love.mouse.keysPressed[key] = true
end

function love.mousereleased(x, y, key)
    love.mouse.keysReleased[key] = true 
end

function love.mouse.wasPressed(key)
    return love.mouse.keysPressed[key]
end

function love.mouse.wasReleased(key)
    return love.mouse.keysReleased[key]
end

function love.mouse.wasWheelMoved(key)
    return love.mouse.wheelMoved[key]
end

function love.update(dt)
    Timer.update(dt)
    gStateStack:update(dt)

    love.keyboard.keysPressed = {}
    love.mouse.keysPressed = {}
    love.mouse.keysReleased = {}
    love.mouse.wheelMoved = {}
end

function love.draw()
    push:start()
    gStateStack:render()
    push:finish()
end