local gui = {}
gui.__index = gui

gui.stylesheet = {}

--Widget Metatable--
local widget = {}
setmetatable(widget, gui)
widget.__index = widget
function widget:update(dt)
    self.stencil = function()
        love.graphics.rectangle("fill", self.parent.screenX, self.parent.screenY, self.parent.width, self.parent.height)
    end

    self:specializedUpdate(dt)
    self:bodyUpdate(dt)
    self:textUpdate(dt)
    self.customUpdate(dt, self)
    self:childrenUpdate(dt)
end
function widget:draw()
    love.graphics.stencil(self.stencil, "replace", 1)
    love.graphics.setStencilTest("greater", 0)

    self:bodyDraw()
    self:textDraw()
    self:childrenDraw()
end

function widget:customUpdate(dt, self)
end

function widget:mousepressed(x, y, button)
    if button ~= 1 then
        return
    end

    local function checkClick(element)
        if element.class == "button" and element.hover then
            element:func()
        elseif element.class == "input" then
            element.edit = element.hover
        end

        for i, element in pairs(element.children) do
            checkClick(element)
        end
    end

    checkClick(self)
end

function widget:textinput(t)
    local function checkEdit(element)
        if element.class == "input" and element.edit then
            element.text = element.text..t

            return
        end

        for i, element in pairs(element.children) do
            checkEdit(element)
        end
    end

    checkEdit(self)
end

function widget:keypressed(key)
    if not(key == "return" or key == "backspace") then
        return
    end

    local function checkEdit(element)
        if element.class == "input" and element.edit then
            if key == "return" then
                element.edit = false
            elseif key == "backspace" then
                element.text = string.sub(element.text, 1, -2)
            end

            return
        end

        for i, element in pairs(element.children) do
            checkEdit(element)
        end
    end

    checkEdit(self)
end

function widget:bodyUpdate(dt)
    if self.alignmentX == "left" then
        self.screenX = self.x
    elseif self.alignmentX == "center" then
        self.screenX = self.parent.width/2 - self.width/2 + self.x
    else
        self.screenX = self.parent.width - self.width + self.x
    end
    self.screenX = self.screenX + self.parent.screenX

    if self.alignmentY == "top" then
        self.screenY = self.y
    elseif self.alignmentY == "center" then
        self.screenY = self.parent.height/2 - self.height/2 + self.y
    else
        self.screenY = self.parent.height - self.height + self.y
    end
    self.screenY = self.screenY + self.parent.screenY
end
function widget:bodyDraw()
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.screenX, self.screenY, self.width, self.height)
end

function widget:textUpdate(dt)
    self.textWidth, self.textWrapped = self.font:getWrap(self.text, self.width - self.textMargin * 2)

    self.textX = self.screenX + self.textMargin
    if self.textAlignmentY == "top" then
        self.textY = self.screenY + self.textMargin
    elseif self.textAlignmentY == "center" then
        self.textY = self.screenY + self.height / 2 - (#self.textWrapped * self.font:getHeight(self.text) / 2)
    else
        self.textY = self.screenY + self.height - (#self.textWrapped * self.font:getHeight(self.text)) - self.textMargin
    end
end
function widget:textDraw()
    love.graphics.setColor(self.textColor)
    love.graphics.setFont(self.font)
    for i, text in ipairs(self.textWrapped) do
        i = i - 1
        love.graphics.printf(text, self.textX, self.textY + i * self.font:getHeight(self.text), self.width - self.textMargin * 2, self.textAlignmentX)
    end
end

function widget:childrenUpdate(dt)
    self.children = {}

    for i, element in pairs(self) do
        if type(element) == "table" and element.class ~= nil then
            table.insert(self.children, element)
        end
    end

    for i, element in pairs(self.children) do
        element.parent = {
            screenX = self.screenX;
            screenY = self.screenY;
            width = self.width;
            height = self.height;
        }

        element:update(dt)
    end
end
function widget:childrenDraw()
    for i, element in ipairs(self.children) do
        element:draw()
    end
end
function widget:specializedUpdate(dt)
end


--Window Metatable--
local window = {}
setmetatable(window, widget)
window.__index = window

function window:update(dt)
    self:childrenUpdate(dt)
end

function window:draw()
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.screenX, self.screenY, self.width, self.height)
    love.graphics.push()
    self:childrenDraw()
    love.graphics.pop()
    love.graphics.setStencilTest()
end

--Button Metatable--
local button = {}
setmetatable(button, widget)
button.__index = button

function button:specializedUpdate(dt)
    local mx, my = love.mouse:getPosition()
    mx, my = mx/scale, my/scale

    self.hover = mx > self.screenX and mx < self.screenX + self.width and my > self.screenY and my < self.screenY + self.height

    if self.hover then
        self.color = self.hoverColor
    else
        self.color = self.normalColor
    end
end

--Frame Metatable--
local frame = {}
setmetatable(frame, widget)
frame.__index = frame

--Image Metatable--
local image = {}
setmetatable(image, widget)
image.__index = image

function image:update(dt)
    self.stencil = function()
        love.graphics.rectangle("fill", self.parent.screenX, self.parent.screenY, self.parent.width, self.parent.height)
    end

    self.width = self.source:getWidth() * self.scale
    self.height = self.source:getHeight() * self.scale
    self:bodyUpdate(dt)
    self.customUpdate(dt, self)
end

function image:draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.stencil(self.stencil, "replace", 1)
    love.graphics.setStencilTest("greater", 0)
    love.graphics.draw(self.source, self.screenX, self.screenY, nil, self.scale)
end

--Input Metatable--
local input = {}
setmetatable(input, widget)
input.__index = input

function input:draw()
    love.graphics.stencil(self.stencil, "replace", 1)
    love.graphics.setStencilTest("greater", 0)

    self:bodyDraw()
    self:textDraw()
    self:textCursorDraw()
    self:childrenDraw()
end

function input:specializedUpdate(dt)
    local mx, my = love.mouse:getPosition()
    mx, my = mx/scale, my/scale
    self.hover = mx > self.screenX and mx < self.screenX + self.width and my > self.screenY and my < self.screenY + self.height

    if self.edit then
        self.color = self.editColor
        self.textCursorVisibility = 1
    else
        self.color = self.normalColor
        self.textCursorVisibility = 0
    end

    self.stencil = function()
        love.graphics.rectangle("fill", self.screenX, self.screenY, self.width, self.height)
    end

    if self.textAlignmentX == "left" then
        self.textCursorX = self.textX + self.font:getWidth(self.textWrapped[#self.textWrapped])
    elseif self.textAlignmentX == "center" then
        self.textCursorX = self.screenX + self.width/2 + self.font:getWidth(self.textWrapped[#self.textWrapped])/2
    else
        self.textCursorX = self.screenX + self.width - self.textMargin
    end

    self.textCursorY = self.textY + (#self.textWrapped - 1) * self.font:getHeight(self.text)
end

function input:textCursorDraw()
    love.graphics.setColor(1, 1, 1, self.textCursorVisibility)
    love.graphics.rectangle("fill", self.textCursorX, self.textCursorY, 2, self.font:getHeight(self.text))
end

--Gui code--
function gui:create(class, settings)
    local element = {}

    setmetatable(settings, gui.stylesheet)

    element.class = class
    element.children = {}
    element.parent = {}
    element.name = settings.name or "element"

    element.customUpdate = settings.customUpdate

    if class == "window" then
        setmetatable(element, window)

        element.screenX = 0
        element.screenY = 0
        element.width = coreWidth
        element.height = coreHeight
        element.color = settings.color or {0, 0, 0, 0}
    elseif class == "button" or class == "frame" or class == "input" then
    
        element.color = settings.color or {1, 0, 0}

        element.x = settings.x or 0
        element.y = settings.y or 0
        element.screenX = element.x
        element.screenY = element.y
        element.width = settings.width or 100
        element.height = settings.height or 50

        element.alignmentX = settings.alignmentX or "left"
        element.alignmentY = settings.alignmentY or "top"

        element.font = love.graphics.setNewFont(settings.font or 12)
        element.text = settings.text or class
        element.textWrapped = {element.text}
        element.textColor = settings.textColor or {1, 1, 1}
        element.textX = element.textX or 0
        element.textY = element.textY or 0
        element.textMargin = settings.textMargin or 0
        element.textWidth = 0
        element.textAlignmentX = settings.textAlignmentX or "center"
        element.textAlignmentY = settings.textAlignmentY or "center"

        if class == "button" then
            setmetatable(element, button)

            element.func = settings.func or function() print("button clicked yo") end
            element.hover = false
            element.normalColor = element.color
            element.hoverColor = settings.hoverColor or {1, 1, 0}
        elseif class == "input" then
            setmetatable(element, input)

            element.edit = false
            element.hover = false
            element.normalColor = element.color
            element.editColor = settings.editColor or {0.7, 0, 0}

            element.textCursorX = 0
            element.textCursorY = 0
            element.textCursorVisibility = 0
        else
            setmetatable(element, frame)
        end
    elseif class == "image" then
        setmetatable(element, image)

        element.x = settings.x or 0
        element.y = settings.y or 0
        element.screenX = element.x
        element.screenY = element.y
        element.source = settings.source
        element.scale = settings.scale or 1
        element.width = element.source:getWidth() or 0
        element.height = element.source:getHeight() or 0

        element.alignmentX = settings.alignmentX or "center"
        element.alignmentY = settings.alignmentY or "center"
    end

    return element
end

function gui:style(styles)
    gui.stylesheet = {}

    --print(table.show(styles))

    for i, style in pairs(styles) do
        for key, value in pairs(style) do
            if gui.stylesheet[key] == nil then
                gui.stylesheet[key] = value
            end
        end
    end

    gui.stylesheet.__index = gui.stylesheet
end

return gui