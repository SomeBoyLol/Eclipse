function exportMap(map)
    local file = io.open("map.lua", "w")

    file:write("local map = {}\n\n")

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

    file:write("return map")

    file:close()
end