function save()
    saveData = {}
    saveData.recents = recents
    saveData.mapTilesets = mapTilesets

    love.filesystem.write("data.lua", table.show(saveData, "saveData"))
end

function read()
    --retrieves data if it exists
    if love.filesystem.getInfo("data.lua") then
        local data = love.filesystem.load("data.lua")
        --runs the data code
        data()

        recents = saveData.recents
        if recents == nil then
            recents = {}
        end
        
        mapTilesets = saveData.mapTilesets
        if mapTilesets == nil then
            mapTilesets = {}
        end
    end
end