tileTypes = {'empty','grass','dirt','flower','wall','water','waterfall'}
tileVariants = {0,10,5,5,5,5,5}

tileTextures = {
    ['grass'] = love.graphics.newImage('graphics/tileset/grass.png'),
    ['dirt'] = love.graphics.newImage('graphics/tileset/[A]Dirt1_pipo.png'),
    ['flower'] = love.graphics.newImage('graphics/tileset/[A]Flower_pipo.png'),
    ['wall'] = love.graphics.newImage('graphics/tileset/[A]Wall-Up1_pipo.png'),
    ['water'] = love.graphics.newImage('graphics/tileset/[A]Water1_pipo.png'),
    ['waterfall'] = love.graphics.newImage('graphics/tileset/[A]WaterFall1_pipo.png'),
}

tileFrames = {
    ['grass'] = GenerateQuads(tileTextures['grass'], TILE_SIZE, TILE_SIZE),
    ['dirt'] = GenerateQuads(tileTextures['dirt'], TILE_SIZE, TILE_SIZE),
    ['flower'] = GenerateQuads(tileTextures['flower'], TILE_SIZE, TILE_SIZE),
    ['wall'] = GenerateQuads(tileTextures['wall'], TILE_SIZE, TILE_SIZE),
    ['water'] = GenerateQuads(tileTextures['water'], TILE_SIZE, TILE_SIZE),
    ['waterfall'] = GenerateQuads(tileTextures['waterfall'], TILE_SIZE, TILE_SIZE),
}
