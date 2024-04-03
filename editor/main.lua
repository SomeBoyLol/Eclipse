editor = {}

require("editor/load")

function editor:update(dt)
    if maploading then
        coroutine.resume(maploader)
    end

    if coroutine.status(maploader) == "dead" then
        --maploading = false
        topbarLoad(map)
    end

    if not menu.name == "editorGUI" then
        return
    end

    if maploading then
        return
    end

    editor.hover = not(assetManagerHover or topbarHover or titlebarHover)

    editor.controller:update(dt)

    collectgarbage("collect")
end

function editor:draw()
    if not menu.name == "editorGUI" then
        return
    end

    if maploading then
        return
    end

    cam:attach()

    editor:drawGrid()
    editor:drawMap()

    love.graphics.setColor(1, 1, 1, 0.5)
    love.graphics.rectangle("fill", (editor.selectX or 500) * map.scale, (editor.selectY or 500) * map.scale, map.scale, map.scale)

    cam:detach()
end