function editor:loadTileset(settings)
    tileset = {}
    tileset.name = settings.name or "Tileset"
    tileset.scale = settings.scale or 16
    tileset.sprite = settings.sprite
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

    print(table.show(tileset))

    tileset = tileset
    setmetatable(tileset, metatileset)

    updateTilesetPallet(tileset)
end