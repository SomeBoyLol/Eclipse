function love.load()
    require("source/startup")
    startup()

    --editor:createMap({width = 10, height = 10, layers = 1, scale = 64})
    --editor:loadTileset({path = "C:/Users/inesh/OneDrive/Pictures/Saved Pictures/Screenshots/tileset2.png", scale = 64})
    --editor:loadTileset({path = "C:/Users/inesh/OneDrive/Documents/Coding Arc/throwdown/sprites/tileset.png", scale = 16})

    menu = home

    read()

    --editor:openMap("C:/Users/inesh/OneDrive/Documents/Maps/collidertest.lua")

    updateRecentsList()

    resetTileset()
end

function love.update(dt)
    menu:update(dt)
    editor:update(dt)

    debug:update(dt)
end

function love.draw()
    editor:draw()
    love.graphics.push()
    scale = math.min(love.graphics:getWidth()/coreWidth, love.graphics:getHeight()/coreHeight)
    love.graphics.scale(scale, scale)

    love.graphics.rectangle("line", 0, 0, coreWidth, coreHeight)

    menu:draw()
    love.graphics.pop()

    debug:draw()
end

function love.keypressed(key)
    menu:keypressed(key)

    if key == "escape" then
        love.event.quit()
    elseif key == "space" then
    elseif key == "f11" then
        fullscreen = not fullscreen
        love.window.setFullscreen(fullscreen, "desktop")
    elseif key == "tab" then
        debug.mode = not(debug.mode)
    end
end

function love.mousepressed(x, y, button)
    menu:mousepressed(x, y, button)

    if button ~= 1 then
        return
    end

    if editor.hover and editor.tool == "collider" and editor.inbound then
        if editor.selectColliderClass == nil then
            return
        end

        editor.drawingCollider = true
        editor.startColliderX = editor.selectX
        editor.startColliderY = editor.selectY
    end

    if editor.hover and editor.tool == "delete" then
        if editor.selectColliderClass == nil then
            return
        end

        mx, my = cam:getCamPosition(love.mouse:getPosition())

        for i, collider in pairs(map.colliders[editor.selectColliderClass]) do
            if mx > collider.x and mx < collider.x + collider.width and my > collider.y and my < collider.y + collider.height then
                table.remove(map.colliders[editor.selectColliderClass], i)
            end
        end
    end
end

function love.mousereleased(x, y, button)
    if editor.tool == "collider" and editor.drawingCollider then
        editor.drawingCollider = false

        if editor.hover then
            editor:newCollider({x = editor.selectX, y = editor.selectY, width = editor.selectWidth, height = editor.selectHeight, class = editor.selectColliderClass})
            --print(table.show({x = startX, y = startY, width = width, height = height, class = editor.selectColliderClass}))
        end
    end
end

function love.textinput(t)
    menu:textinput(t)
end

function love.directorydropped(path)
    print(path)
end