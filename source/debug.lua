debug = {}
debug.mode = false

local font = love.graphics.newFont(12)

function debug:update(dt)
end

function debug:draw()
    if not debug.mode then
        return
    end

    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle("fill", 0, 0, 300, love.graphics:getHeight())

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(font)
    love.graphics.print("FPS: "..love.timer:getFPS())
    love.graphics.print("Inbound: "..tostring(editor.inbound), 0, 12)
    love.graphics.print("Tool:"..editor.tool, 0, 24)
end