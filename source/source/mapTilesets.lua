function saveMapTilesetsPair()
    if tileset.path == nil then
        return
    end

    local tilesetSave = {}
    tilesetSave.tilesetPath = tileset.path
    tilesetSave.mapDirectory = map.directory
    tilesetSave.scale = tileset.scale

    local found = false
    for i, v in pairs(mapTilesets) do
        if v.mapDirectory == map.directory then
            mapTilesets[i] = tilesetSave
            found = true
            break
        end
    end

    if not found then
        table.insert(mapTilesets, tilesetSave)
    end

    save()
end

function openMapTilesetsPair()
    for i, pair in pairs(mapTilesets) do
        if pair.mapDirectory == map.directory then
            success, error = pcall(function() editor:loadTileset({path = pair.tilesetPath, scale = pair.scale}) end)
        end
    end
end