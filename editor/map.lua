function editor:createMap(settings)
    map = {}
    map.scale = settings.scale or 16
    map.width = settings.width or 15
    map.height = settings.height or 15
    map.directory = settings.directory or ""
    map.layers = {}
    map.colliders = {}

    maploading = true

    maploader = coroutine.create(function()
        menu = loading
    
        for layerIndex = 1, settings.layers or 1 do
            local layer = {}
            for y = 1, map.height do
                local row = {}
                for x = 1, map.width do
                    table.insert(row, 0)
                end
                table.insert(layer, row)

                coroutine.yield(maploader)
            end
            table.insert(map.layers, layer)
        end

        menu = editorGUI
        editor.open =  true
        maploading = false
    end)

    topbarLoad(map)
end

function editor:openMap(directory)
    map = {}
    map = require(directory)

    topbarLoad(map)
end

function editor:drawMap()
    love.graphics.setColor(1, 1, 1)
    for layerIndex, layer in ipairs(map.layers) do
        for y, row in ipairs(layer) do
            y = y - 1
            for x, tile in ipairs(row) do
                x = x - 1
                if tile ~= 0 then
                    love.graphics.draw(tileset.sprite, tileset[tile], x * map.scale, y * map.scale)
                end
            end
        end
    end
end

function editor:drawGrid()
    for y = 1, map.height do
        y = y - 1
        love.graphics.rectangle("line", 0, y * map.scale, map.scale * map.width, map.scale)
    end
    for x = 1, map.width do
        x = x - 1
        love.graphics.rectangle("line", x * map.scale, 0, map.scale, map.scale * map.height)
    end
end