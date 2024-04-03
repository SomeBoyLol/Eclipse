editor.controller = {}

function editor.controller:update(dt)

    palletX, palletY = 0, 0

    if editor.hover then
        local speed = camSpeed

        if love.keyboard.isDown("lshift") then
            speed = speed * 0.5
        end

        if love.keyboard.isDown("w") then
            cam.y = cam.y - speed * dt
        end
        if love.keyboard.isDown("s") then
            cam.y = cam.y + speed * dt
        end
        if love.keyboard.isDown("a") then
            cam.x = cam.x - speed * dt
        end
        if love.keyboard.isDown("d") then
            cam.x = cam.x + speed * dt
        end
    elseif palletHover then
        local speed = 400

        if love.keyboard.isDown("w") then
            palletY = 1 * speed * dt
        end
        if love.keyboard.isDown("s") then
            palletY = -1 * speed * dt
        end
        if love.keyboard.isDown("a") then
            palletX = 1 * speed * dt
        end
        if love.keyboard.isDown("d") then
            palletX = -1 * speed * dt
        end
    end

    mx, my = cam:getCamPosition(love.mouse:getPosition())

    editor.selectX = nil
    editor.selectY = nil
    if editor.hover then
        for y, row in ipairs(map.layers[editor.layer]) do
            y = y - 1
            for x, tile in ipairs(row) do
                x = x - 1
                if mx > x * map.scale and mx < (x + 1) * map.scale and my > y * map.scale and my < (y + 1) * map.scale then
                    editor.selectX = x
                    editor.selectY = y
                end
            end
        end
    end

    if love.mouse.isDown(1) and editor.selectX ~= nil and editor.selectY ~= nil then
        map.layers[editor.layer][editor.selectY + 1][editor.selectX + 1] = editor.brush
    end
end

function love.wheelmoved(x, y)
    if cam.scale <= 1 then
        if y < 0 then
            cam.scale = cam.scale / 2
        elseif y > 0 then
            cam.scale = cam.scale * 2
        end
    else
        if y > 0 then
            cam.scale = cam.scale + 1
        elseif y < 0 then
            cam.scale = cam.scale - 1
        end
    end
end