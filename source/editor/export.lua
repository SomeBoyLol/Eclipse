function exportMap(map)
    local file = io.open(map.directory, "w")

    file:write("local map = {}\n\n")

    file:write('map.name = "'..map.name..'"\n')
    file:write('map.directory = "'..map.directory..'"\n')
    file:write("map.width = "..map.width.."\n")
    file:write("map.height = "..map.height.."\n")
    file:write("map.scale = "..map.scale.."\n\n")

    file:write("map.layers = {\n")

    for index, layer in ipairs(map.layers) do
        file:write("    {\n")
        for y, mapRow in ipairs(layer) do
            local row = "{"
            for x, tile in ipairs(mapRow) do
                row = row..tile.."; "
            end
            row = row.."};"
            file:write("        "..row.."\n")
        end

        file:write("    };\n")
    end

    file:write("}\n\n")

    file:write("map.colliders = {\n")
    for className, class in pairs(map.colliders) do
        file:write('    ["'..className..'"] = {\n')

        for _, collider in pairs(class) do
            file:write("        {x = "..collider.x.."; y = "..collider.y.."; width = "..collider.width.."; height = "..collider.height..";};\n")
        end

        file:write("    };\n")
    end
    file:write("}\n\n")

    file:write("return map")

    file:close()

    if file then
        print("saved map")

        saveMapTilesetsPair()
    end

    updateRecents(map)
end