StartState = Class{__includes = BaseState}
local num=8
function StartState:init()
    self.table_npc ={}
    self.ground = self:generateGround()
    self:spawnNPC(num)
    gSounds['intro-music']:play()
    self.currentMenuItem = 1
end

function StartState:update(dt)
    for k, npc in pairs(self.table_npc) do
        npc:processAI(self,dt)
    end
        if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
            self.currentMenuItem = self.currentMenuItem == 1 and 2 or 1
            --gSounds['select']:play()
        end
        if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
            if self.currentMenuItem == 1 then
                gStateStack:push(FadeInState({
                    r = 1, g = 1, b = 1
                }, 1,
                function()
                    gSounds['intro-music']:stop()
                    --self.tween:remove()
        
                    gStateStack:pop()
                    
                    gStateStack:push(CreateState())
                    gStateStack:push(DialogueState("" .. 
                        "Welcome to the world of 50Mon! To start fighting monsters with your own randomly assigned" ..
                        " monster, just walk in the tall grass! If you need to heal, just press 'P' in the field! " ..
                        "Good luck! (Press Enter to dismiss dialogues)"
                    ))
                    gStateStack:push(FadeOutState({
                        r = 1, g = 1, b = 1
                    }, 1,
                    function() end))
                end))
            else
                love.event.quit()
            end
        end
end

function StartState:render()
    love.graphics.clear(188/255, 188/255, 188/255, 1)
    self:drawGround()
    --[[local temp_table_npc = self.table_npc
        sort = function(npcA, npcB)
           return npcA.y < npcB.y
        end
        table.sort(temp_table_npc, sort)
    for k, npc in pairs(temp_table_npc) do
        npc:render()
    end]]
    for k, npc in pairs(self.table_npc) do
        npc:render()
    end
    self:drawOptions(12)
    --displaytext("NPC : "..tostring(self.npc.x)..', '..tostring(self.npc.y),10,10)
    --displaytext("NPC dir : "..tostring(self.npc.direction),10,20)
    --displaytext("NPC anim : "..tostring(self.npc.currentAnimation.frames[3]),10,30)
end

function StartState:drawOptions(y)
    love.graphics.setColor(1, 1, 1, 0.5)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 76, VIRTUAL_HEIGHT / 2 + y, 150, 58, 6)

    love.graphics.setFont(gFonts['medium'])
    self:drawTextShadow('Start', VIRTUAL_HEIGHT / 2 + y + 8)
    
    if self.currentMenuItem == 1 then
        love.graphics.setColor(99/255, 155/255, 1, 1)
    else
        love.graphics.setColor(48/255, 96/255, 130/255, 1)
    end
    
    love.graphics.printf('Start', 0, VIRTUAL_HEIGHT / 2 + y + 8, VIRTUAL_WIDTH, 'center')

    -- draw Quit Game text
    love.graphics.setFont(gFonts['medium'])
    self:drawTextShadow('Quit Game', VIRTUAL_HEIGHT / 2 + y + 33)
    
    if self.currentMenuItem == 2 then
        love.graphics.setColor(99/255, 155/255, 1, 1)
    else
        love.graphics.setColor(48/255, 96/255, 130/255, 1)
    end
    
    love.graphics.printf('Quit Game', 0, VIRTUAL_HEIGHT / 2 + y + 33, VIRTUAL_WIDTH, 'center')
end

function StartState:generateGround()
    local level={}
    for x = 0,(VIRTUAL_WIDTH/TILE_SIZE) do
        for y=0,(VIRTUAL_HEIGHT/TILE_SIZE) do
            local dirt_tile=Tile(x,y,'dirt',5)
            table.insert(level,dirt_tile)
            if math.random(5)==1 then
                local grass_tile=Tile(x,y,'grass',1)
                table.insert(level,grass_tile)
            end
        end
    end
    return level
end

function StartState:drawGround()
    for k,tile in pairs(self.ground) do
        love.graphics.draw(tileTextures[tile.type], tileFrames[tile.type][tile.variant],tile.x*TILE_SIZE, tile.y*TILE_SIZE)
    end
    --[[for x = 0,(VIRTUAL_WIDTH/TILE_SIZE) do
        for y=0,(VIRTUAL_HEIGHT/TILE_SIZE) do
            love.graphics.draw(tileTextures['dirt'], tileFrames['dirt'][5],x*TILE_SIZE, y*TILE_SIZE)
            if math.random(5)==1 then
                love.graphics.draw(tileTextures['grass'], tileFrames['grass'][1],x*TILE_SIZE, y*TILE_SIZE)
            end
        end
    end]]
end

function StartState:drawTextShadow(text, y)
    love.graphics.setColor(34/255, 32/255, 52/255, 1)
    love.graphics.printf(text, 2, y + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.printf(text, 1, y + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.printf(text, 0, y + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.printf(text, 1, y + 2, VIRTUAL_WIDTH, 'center')
end

function StartState:spawnNPC(number)
    for i=1,number do
        local directions = {'left', 'right', 'up', 'down'}
        local type = ENTITY_TYPES[math.random(#ENTITY_TYPES)]
        local npc = Entity {
            animations = ENTITY_DEFS[type].animations,
            mapX = math.random(1,10),
            mapY = math.random(1,5),
            width = 32,
            height = 36,
            direction = directions[math.random(#directions)]
        }
        npc.stateMachine = StateMachine {
            ['walk'] = function() return EntityWalkState(npc) end,
            ['idle'] = function() return EntityIdleState(npc) end
        }
        npc:changeState('walk')
        table.insert(self.table_npc,npc)
    end
end