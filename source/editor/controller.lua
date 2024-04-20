editor.controller = {}

function editor.controller:update(dt)
    --tileset pallet coordinate movement
    palletX, palletY = 0, 0

    if editor.hover then
        local speed = camSpeed

        if love.keyboard.isDown("lctrl") then
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

    local pastX, pastY = editor.targetX or 0, editor.targetY or 0

    editor.targetX = round(mx - map.scale / 2, map.scale) / map.scale
    editor.targetY = round(my - map.scale / 2, map.scale) / map.scale

    --quick swap tile feature //// im surprised it actually works
    if love.keyboard.isDown("lshift") and editor.inbound then
        local dx, dy = editor.targetX - pastX, editor.targetY - pastY

        if not(dx == 0) or not(dy == 0) then
            local tileY = math.ceil(editor.brush / tileset.width)
            local tileX = editor.brush - tileset.width * (tileY - 1)

            tileX = tileX + dx
            tileY = tileY + dy
            
            for i, tile in ipairs(tileset) do
                local y = math.ceil(i / tileset.width)
                local x = i - tileset.width * (y - 1)

                if x == tileX and y == tileY then
                    editor.brush = i
                end
            end
        end
    end

    editor.selectX = 0
    editor.selectY = 0
    editor.selectWidth, editor.selectHeight = 0, 0

    editor.inbound = editor.hover

    if not(editor.targetX >= 0 and editor.targetX + 1 <= map.width and editor.targetY >= 0 and editor.targetY + 1 <= map.height) then
        editor.inbound = false
        return
    end

    if editor.hover and editor.tool == "brush" then
        editor.selectX = editor.targetX * map.scale
        editor.selectY = editor.targetY * map.scale
        editor.selectWidth = map.scale
        editor.selectHeight = map.scale

        if love.mouse.isDown(1) then
            map.layers[editor.layer][editor.targetY + 1][editor.targetX + 1] = editor.brush
        end
    end

    if editor.tool == "collider" then
        editor.targetX = round(mx - editor.selectFactor / 2, editor.selectFactor) / map.scale
        editor.targetY = round(my - editor.selectFactor / 2, editor.selectFactor) / map.scale
    
        editor.selectX = editor.targetX * map.scale
        editor.selectY = editor.targetY * map.scale
        editor.selectWidth = editor.selectFactor
        editor.selectHeight = editor.selectFactor
    end

    if editor.hover and editor.drawingCollider and editor.inbound then
        local startX, startY = math.min(editor.startColliderX, editor.selectX), math.min(editor.startColliderY, editor.selectY)
        local endX, endY = (math.max(editor.startColliderX, editor.selectX) + 1), (math.max(editor.startColliderY, editor.selectY) + 1)
        local width, height = endX - startX, endY - startY

        editor.selectX = startX
        editor.selectY = startY
        editor.selectWidth = width + editor.selectFactor
        editor.selectHeight = height + editor.selectFactor
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