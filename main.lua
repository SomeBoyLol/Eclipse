function love.load()
    require("source/startup")
    startup()

    --editor:createMap({width = 0, height = 0, layers = 1, scale = 64})
    --editor:loadTileset({sprite = love.graphics.newImage("tileset2.png"), scale = 64})

    cam.scale = 1
    editor.open = false

    menu = editorGUI
end

function love.update(dt)
    menu:update(dt)
    editor:update(dt)
end

function love.draw()
    editor:draw()
    love.graphics.push()
    scale = math.min(love.graphics:getWidth()/coreWidth, love.graphics:getHeight()/coreHeight)
    love.graphics.scale(scale, scale)

    love.graphics.rectangle("line", 0, 0, coreWidth, coreHeight)

    menu:draw()
    love.graphics.pop()
end

function love.keypressed(key)
    menu:keypressed(key)

    if key == "escape" then
        love.event.quit()
    elseif key == "space" then
        menu = home
        exportMap(map)
    end
end

function love.mousepressed(x, y, button)
    menu:mousepressed(x, y, button)
end

function love.textinput(t)
    menu:textinput(t)
end

function love.quit()
end