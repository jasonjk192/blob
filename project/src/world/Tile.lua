--[[
    GD50
    Pokemon

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Tile = Class{}

function Tile:init(x, y, type, variant)
    self.x = x
    self.y = y
    self.type = type
    self.variant = variant
end

function Tile:update(dt)

end

function Tile:render()
    if not (self.type == 'empty' or self.type == nil) then
    love.graphics.draw(tileTextures[self.type], tileFrames[self.type][self.variant],
        (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)
    end
end