function GenerateQuads(atlas, tileWidth, tileHeight)
    local sheetWidth = atlas:getWidth() / tileWidth
    local sheetHeight = atlas:getHeight() / tileHeight

    local sheetcouter = 1
    local spritesheet = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            spritesheet[sheetcouter] = 
                love.graphics.newQuad(x * tileWidth ,y * tileHeight ,tileWidth,tileHeight, atlas:getDimensions())
            
            sheetcouter = sheetcouter +1
        end
    end

    return spritesheet
end

