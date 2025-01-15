--atlas is a sprite sheet


--we are defining a function to take an atlas/spriteSheet
--and devide it into multiple rectangles called quads
function GenerateQuads(atlas, tilewidth, tileheight)
    --calculate the number of tiles in the sheet
    local sheetWidth = atlas:getWidth() / tilewidth
    local sheetHeight = atlas:getHeight() / tileheight

    --a counter to keep track of all quads
    local sheetCounter = 1

    --create a table to hold the quads
    local spriteSheet = {}

    -- -1 so it starts from 0
    --it will start from top left 
    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            --Create a Quad for Each Tile
            spriteSheet[sheetCounter] = 
                    --this creates quads from the spritesheet
                    love.graphics.newQuad(x * tilewidth, y * tileheight, tilewidth, 
                    tileheight, atlas:getDimensions())

            sheetCounter = sheetCounter + 1
        end
    end

    --return the table
    return  spriteSheet
end


--[[
    This function is specifically made to piece out the paddles from the
    sprite sheet. For this, we have to piece out the paddles a little more
    manually, since they are all different sizes.
]]
function table.slice(tbl, first, last, step)
    local sliced = {}

    -- #tbl is the size of the table
    for i = first or 1, last or #tbl, step or 1 do
        sliced[#sliced+1] = tbl[i]
    end

    --return a segment of a table we are in
    return sliced
end

function GenerateQuadsPaddle(atlas)
    local x = 0
    local y = 64

    local counter = 1
    local quads = {}

    --total of 4 loops because we have 4 different colors for the paddle
    for i = 0 , 3 do

        --create the quads for all sizes and store them
        --smallest
        quads[counter] = love.graphics.newQuad(x, y, 32, 16, atlas:getDimensions())
        counter = counter + 1
        --medium
        quads[counter] = love.graphics.newQuad(x + 32, y, 64, 16, atlas:getDimensions())
        counter = counter + 1
        --large
        quads[counter] = love.graphics.newQuad(x + 96 , y, 96, 16, atlas:getDimensions())
        counter = counter + 1
        --huge
        quads[counter] = love.graphics.newQuad(x, y + 16, 128 , 16, atlas:getDimensions())
        counter = counter + 1
        
        --perepate the X and Y for the next color
        x = 0
        y = y + 32
    end

    return quads
end

function GenerateQuadsBalls(atlas)
    local x = 96
    local y = 48

    local counter = 1
    local quads = {}

    for i = 0, 3 do
        quads[counter] = love.graphics.newQuad(x, y, 8, 8, atlas:getDimensions())
        x = x + 8 
        counter = counter + 1
    end

    x = 96
    y = 56 

    for i = 0, 2 do
        quads[counter] = love.graphics.newQuad(x, y, 8, 8, atlas:getDimensions())
        x = x + 8
        counter = counter + 1
    end
    
    return quads
end

function GenerateQuadsBricks(atlas)
    return table.slice(GenerateQuads(atlas, 32, 16), 1, 21)
end

function GenerateQuadsPowerUps(atlas)
    return table.slice(GenerateQuads(atlas, 16,16), 145, 155)
end

