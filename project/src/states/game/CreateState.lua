CreateState = Class{__includes = BaseState}
local mouseX=0
local mouseY=0
local mapX=1
local mapY=1
local layer=0
local tiletypecounter=2
local tilevariant = 5
local index = false
local map_size = 30
local scale = 1

function CreateState:init()
    self.camX = 0
    self.camY = 0

    self.layer0 = TileMap(map_size, map_size)
    self.layer1 = TileMap(map_size, map_size)
    self.layer2 = TileMap(map_size, map_size)
    self.layer3 = TileMap(map_size, map_size)
    self.layer4 = TileMap(map_size, map_size)
    self.layer5 = TileMap(map_size, map_size)

    for y = 1, map_size do
        table.insert(self.layer0.tiles, {})
        table.insert(self.layer1.tiles, {})
        table.insert(self.layer2.tiles, {})
        table.insert(self.layer3.tiles, {})
        table.insert(self.layer4.tiles, {})
        table.insert(self.layer5.tiles, {})
        for x = 1, map_size do
            table.insert(self.layer0.tiles[y], Tile(x,y,'grass',10))
            table.insert(self.layer1.tiles[y], Tile(x,y,'empty',0))
            table.insert(self.layer2.tiles[y], Tile(x,y,'empty',0))
            table.insert(self.layer3.tiles[y], Tile(x,y,'empty',0))
            table.insert(self.layer4.tiles[y], Tile(x,y,'empty',0))
            table.insert(self.layer5.tiles[y], Tile(x,y,'empty',0))
        end
    end
end

function CreateState:update(dt)
    index = self:checkTileExist(mapX,mapY,layer)
    local x, y = push:toGame(love.mouse.getPosition())
    mouseX=x*scale+self.camX
    mouseY=y*scale+self.camY
    mapX=math.floor(mouseX/TILE_SIZE)+1
    mapY=math.floor(mouseY/TILE_SIZE)+1
    self:handleInput()
    self:updateCam()
end

function CreateState:handleInput()
    if love.mouse.wasWheelMoved(3) then
        if love.keyboard.isDown('lctrl') then
            layer=math.clamp(layer+1,0,5)
        elseif love.keyboard.isDown('lshift') then
            scale=math.clamp(scale-0.1,1,math.floor(map_size/15))
            self.camX = math.clamp(self.camX,0,TILE_SIZE * map_size - VIRTUAL_WIDTH*scale)
            self.camY = math.clamp(self.camY,0,TILE_SIZE * map_size  - VIRTUAL_HEIGHT*scale)
        else
            tilevariant = math.clamp((tilevariant%(tileVariants[tiletypecounter]))+1, 1, tileVariants[tiletypecounter])
        end
    end
    if love.mouse.wasWheelMoved(4) then
        if love.keyboard.isDown('lctrl') then
            layer=math.clamp(layer-1,0,5)
        elseif love.keyboard.isDown('lshift') then
            scale=math.clamp(scale+0.1,1,math.floor(map_size/15))
            self.camX = math.clamp(self.camX,0,TILE_SIZE * map_size - VIRTUAL_WIDTH*scale)
            self.camY = math.clamp(self.camY,0,TILE_SIZE * map_size  - VIRTUAL_HEIGHT*scale)
        else
            tilevariant = math.clamp(tilevariant==1 and tileVariants[tiletypecounter] or tilevariant-1, 1, tileVariants[tiletypecounter])
        end
    end
    
    if love.mouse.wasPressed(2) then
        if love.keyboard.isDown('lctrl') then
            tiletypecounter = math.clamp(tiletypecounter == 2 and #tileTypes or tiletypecounter-1, 2, #tileTypes)
            tilevariant=1
        else
            tiletypecounter = math.clamp((tiletypecounter%(#tileTypes))+1, 2, #tileTypes)
            tilevariant=1
        end
    end

    if love.mouse.wasPressed(1) then
        if love.keyboard.isDown('lctrl') then 
            if index then
                self:editTileAt(mapX,mapY,layer,'empty',0)
            end
        else
            local tile=Tile(mapX,mapY,tileTypes[tiletypecounter],tilevariant)
            if tileTypes[tiletypecounter] == 'water' then
                tile=Tile(mapX,mapY,tileTypes[tiletypecounter],(tilevariant-1)*8+1)
            end
            if not index then
                self:editTileAt(mapX,mapY,layer,tileTypes[tiletypecounter],tilevariant)
            else
                self:editTileAt(mapX,mapY,layer,tileTypes[tiletypecounter],tilevariant)
            end
        end
    end
end

function CreateState:updateCam()
    local speed = 2
    if love.keyboard.isDown('lshift') then
        speed = 4
    end
    if love.keyboard.isDown('right') then 
        self.camX = math.clamp(self.camX+speed,0,TILE_SIZE * map_size - VIRTUAL_WIDTH*scale)
    elseif love.keyboard.isDown('left') then 
        self.camX = math.clamp(self.camX-speed,0,TILE_SIZE * map_size - VIRTUAL_WIDTH*scale)
    end
    if love.keyboard.isDown('up') then 
        self.camY = math.clamp(self.camY-speed,0,TILE_SIZE * map_size  - VIRTUAL_HEIGHT*scale)
    elseif love.keyboard.isDown('down') then 
        self.camY = math.clamp(self.camY+speed,0,TILE_SIZE * map_size  - VIRTUAL_HEIGHT*scale)
    end
end

function CreateState:checkTileExist(x,y,layer)
    local tile = self:getTileAt(x,y,layer)
    if not tile then return false end
    if tile.type ~= 'empty' then
        return true
    end
    return false
end

function CreateState:render()
    love.graphics.scale(1/scale)
    love.graphics.translate(-math.floor(self.camX), -math.floor(self.camY))
    love.graphics.clear(188/255, 188/255, 188/255, 1)
    self:drawBackGround()
    self:drawForeGround()
    if not index then
        love.graphics.setColor(0, 1, 0, 0.8)
    else
        love.graphics.setColor(1, 0, 0, 0.8)
    end
    love.graphics.rectangle('line', (mapX-1)*TILE_SIZE, (mapY-1)*TILE_SIZE, TILE_SIZE, TILE_SIZE)
    love.graphics.translate(math.floor(self.camX), math.floor(self.camY))
    love.graphics.scale(scale)
    self:drawOptions()
end

function CreateState:drawBackGround()
    self.layer0:render()
    self.layer1:render()
    self.layer2:render()
end

function CreateState:drawForeGround()
    self.layer3:render()
    self.layer4:render()
    self.layer5:render()
end

function CreateState:drawOptions()
    love.graphics.setColor(1, 1, 1, 0.4)
    love.graphics.rectangle('fill', 0, VIRTUAL_HEIGHT-50, VIRTUAL_WIDTH, 50)
    local t = self:getTileAt(mapX,mapY,layer)

    displaytext("Mouse : "..tostring(math.round(mouseX,1))..', '..tostring(math.round(mouseY,1)),10,VIRTUAL_HEIGHT-45,nil,{r=0.2,g=0.5,b=0.5,a=1})
    displaytext("Tile : "..tostring(t.x)..', '..tostring(t.y)..' | '..tostring(t.type)..' | '..tostring(t.variant),10,VIRTUAL_HEIGHT-38,nil,{r=0.2,g=0.5,b=0.5,a=1})
    displaytext("Layer : "..tostring(layer),10,VIRTUAL_HEIGHT-31,nil,{r=0.2,g=0.5,b=0.5,a=1})
    displaytext("Scale Factor : "..tostring(scale),10,VIRTUAL_HEIGHT-24,nil,{r=0.2,g=0.5,b=0.5,a=1})
    if t.type ~= 'empty' then
        love.graphics.draw(tileTextures[t.type], tileFrames[t.type][t.variant],VIRTUAL_WIDTH-80,VIRTUAL_HEIGHT-40)
    end
    if tiletypecounter > 1 then
        if tileTypes[tiletypecounter] == 'water' then
            love.graphics.draw(tileTextures[tileTypes[tiletypecounter]], tileFrames[tileTypes[tiletypecounter]][(tilevariant-1)*8+1],VIRTUAL_WIDTH-40,VIRTUAL_HEIGHT-40)
        else
            love.graphics.draw(tileTextures[tileTypes[tiletypecounter]], tileFrames[tileTypes[tiletypecounter]][tilevariant],VIRTUAL_WIDTH-40,VIRTUAL_HEIGHT-40)
        end
    end
    --love.graphics.draw(tileTextures[], tileFrames[][tilevariant],VIRTUAL_WIDTH-40,VIRTUAL_HEIGHT-40)
end

function CreateState:getTileAt(x,y,layer)
    local tile = self.layer0.tiles[y][x]
    if layer == 0 then
        tile = self.layer0.tiles[y][x]
    elseif layer == 1 then
        tile = self.layer1.tiles[y][x]
    elseif layer == 2 then
        tile = self.layer2.tiles[y][x]
    elseif layer == 3 then
        tile = self.layer3.tiles[y][x]
    elseif layer == 4 then
        tile = self.layer4.tiles[y][x]
    elseif layer == 5 then
        tile = self.layer5.tiles[y][x]
    end
    return tile
end

function CreateState:editTileAt(x, y, layer, type ,variant)
    if layer == 0 then
        self.layer0.tiles[y][x].type = type
        self.layer0.tiles[y][x].variant = variant
    elseif layer == 1 then
        self.layer1.tiles[y][x].type = type
        self.layer1.tiles[y][x].variant = variant
    elseif layer == 2 then
        self.layer2.tiles[y][x].type = type
        self.layer2.tiles[y][x].variant = variant
    elseif layer == 3 then
        self.layer3.tiles[y][x].type = type
        self.layer3.tiles[y][x].variant = variant
    elseif layer == 4 then
        self.layer4.tiles[y][x].type = type
        self.layer4.tiles[y][x].variant = variant
    elseif layer == 5 then
        self.layer5.tiles[y][x].type = type
        self.layer5.tiles[y][x].variant = variant
    end
end