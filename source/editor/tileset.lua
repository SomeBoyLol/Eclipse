tileset = {}

metatileset = {}
metatileset.quad = love.graphics.newQuad(0, 0, 0, 0, 1, 1)
metatileset.sprite = love.graphics.newImage("sprites/icons.png")
metatileset.scale = 16
metatileset.__index = function(table, key)
    if type(key) == "number" then
        return metatileset.quad
    elseif key == "sprite" then
        return metatileset.sprite
    elseif key == "scale" then
        return metatileset.scale
    end
end

setmetatable(tileset, metatileset)

function editor:loadTileset(settings)
    tileset = {}
    tileset.name = settings.name or "Tileset"
    tileset.scale = settings.scale or 16
    tileset.path = settings.path or settings.source

    local file = io.open(tileset.path, "rb")
    local fileData = file:read("*a")
    file:close()
    fileData = love.filesystem.newFileData(fileData, "tileset.png")
    local imageData = love.image.newImageData(fileData)

    tileset.sprite = love.graphics.newImage(imageData)
    tileset.width = tileset.sprite:getWidth() / tileset.scale
    tileset.height = tileset.sprite:getHeight() / tileset.scale

    for y = 1, tileset.height do
        y = y - 1
        for x = 1, tileset.width do
            x = x - 1
            local tile = love.graphics.newQuad(x * tileset.scale, y * tileset.scale, tileset.scale, tileset.scale, tileset.sprite:getWidth(), tileset.sprite:getHeight())
            table.insert(tileset, tile)
        end
    end

    --print(table.show(tileset))

    setmetatable(tileset, metatileset)

    updateTilesetPallet(tileset)
end