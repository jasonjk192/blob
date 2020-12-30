charTextures = {
    ['healer_f'] = love.graphics.newImage('graphics/characters/healer_f.png'),
    ['healer_m'] = love.graphics.newImage('graphics/characters/healer_m.png'),
    ['mage_f'] = love.graphics.newImage('graphics/characters/mage_f.png'),
    ['mage_m'] = love.graphics.newImage('graphics/characters/mage_m.png'),
    ['ninja_f'] = love.graphics.newImage('graphics/characters/ninja_f.png'),
    ['ninja_m'] = love.graphics.newImage('graphics/characters/ninja_m.png'),
    ['ranger_f'] = love.graphics.newImage('graphics/characters/ranger_f.png'),
    ['ranger_m'] = love.graphics.newImage('graphics/characters/ranger_m.png'),
}

charFrames = {
    ['healer_f'] = GenerateQuads(charTextures['healer_f'], CHAR_SIZE_X, CHAR_SIZE_Y),
    ['healer_m'] = GenerateQuads(charTextures['healer_m'], CHAR_SIZE_X, CHAR_SIZE_Y),
    ['mage_f'] = GenerateQuads(charTextures['mage_f'], CHAR_SIZE_X, CHAR_SIZE_Y),
    ['mage_m'] = GenerateQuads(charTextures['mage_m'], CHAR_SIZE_X, CHAR_SIZE_Y),
    ['ninja_f'] = GenerateQuads(charTextures['ninja_f'], CHAR_SIZE_X, CHAR_SIZE_Y),
    ['ninja_m'] = GenerateQuads(charTextures['ninja_m'], CHAR_SIZE_X, CHAR_SIZE_Y),
    ['ranger_f'] = GenerateQuads(charTextures['ranger_f'], CHAR_SIZE_X, CHAR_SIZE_Y),
    ['ranger_m'] = GenerateQuads(charTextures['ranger_m'], CHAR_SIZE_X, CHAR_SIZE_Y)
}