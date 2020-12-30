--[[
    GD50
    Angry Birds

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.level = Level()
    self.levelTranslateX = 0
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    -- update camera
    if love.keyboard.isDown('left') then
        self.levelTranslateX = self.levelTranslateX + MAP_SCROLL_X_SPEED * dt
        
        if self.levelTranslateX > VIRTUAL_WIDTH then
            self.levelTranslateX = VIRTUAL_WIDTH
        else
            -- only update background if we were able to scroll the level
            self.level.background:update(dt)
        end
    elseif love.keyboard.isDown('right') then
        self.levelTranslateX = self.levelTranslateX - MAP_SCROLL_X_SPEED * dt

        if self.levelTranslateX < -VIRTUAL_WIDTH then
            self.levelTranslateX = -VIRTUAL_WIDTH
        else
            -- only update background if we were able to scroll the level
            self.level.background:update(dt)
        end
    end

    self.level:update(dt)
end

function PlayState:render()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()))
    love.graphics.setColor(1, 1, 1, 1)

    -- render background separate from level rendering
    self.level.background:render()

    love.graphics.translate(math.floor(self.levelTranslateX), 0)
    self.level:render()
end

function displaytext(text,x,y)
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.setFont(gFonts['medium'])
    love.graphics.print(text,x,y)
    love.graphics.setColor(1, 1, 1, 1)
end

function math.round(n, deci)
    deci = 10^(deci or 0)
    return math.floor(n*deci+.5)/deci
end
