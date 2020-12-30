function displaytext(text,x,y,font,color)
    if color then
        love.graphics.setColor(color.r, color.g, color.b, color.a)
    else
        love.graphics.setColor(0, 1, 0, 1)
    end
    if font then
        love.graphics.setFont(gFonts[font])
    else
        love.graphics.setFont(gFonts['small'])
    end
    love.graphics.print(text,x,y)
    love.graphics.setColor(1, 1, 1, 1)
end

--[[function displaytext(text,x,y)
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.setFont(gFonts['small'])
    love.graphics.print(text,x,y)
    love.graphics.setColor(1, 1, 1, 1)
end]]

function math.round(n, deci)
    deci = 10^(deci or 0)
    return math.floor(n*deci+.5)/deci
end

function math.clamp(n, low, high)
    return math.min(math.max(n, low), high)
end

function table_2dto1d(x,y , size)
    return (x + (y - 1)*size)
end

function table_1dto2d(index , size)
    local i = index - 1
    local x = i%size
    local y = (i - x)/size
    return x + 1, y + 1
end