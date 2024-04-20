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

    if menu.editor == nil then
        return
    end

    if maploading then
        return
    end

    editor.hover = not(assetManagerHover or topbarHover or titlebarHover)

    editor.controller:update(dt)
    editor:updateColliders(dt)

    collectgarbage("collect")
end

function editor:draw()
    if menu.editor == nil then
        return
    end

    if maploading then
        return
    end

    cam:attach()

    editor:drawGrid()
    editor:drawMap()
    editor:drawColliders()

    love.graphics.setColor(1, 1, 1, 0.5)
    love.graphics.rectangle("fill", editor.selectX, editor.selectY, editor.selectWidth, editor.selectHeight)

    cam:detach()
end