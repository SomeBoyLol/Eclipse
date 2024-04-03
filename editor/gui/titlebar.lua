local button1 = {
    color = {36/255, 158/255, 83/255};
    hoverColor = {30/255, 130/255, 69/255};
}

local button2 = {
    color = {55/255, 55/255, 55/255};
    hoverColor = {64/255, 64/255, 64/255};
}

local frame1 = {
    color = {47/255, 47/255, 47/255};
}

local frame2 = {
    color = {35/255, 35/255, 35/255};
    hoverColor = {45/255, 45/255, 45/255};
}

local regularButton = {
    x = 0;
    y = 0;
    width = 150;
    height = 50;
    font = 18;
}

local smallButton = {
    width = 80;
    height = 50;
}

gui:style({frame2})
local titlebar = gui:create("frame", {text = "", x = 0, y = 0, width = coreWidth, height = 50, font = 20})

function titlebar:customUpdate(self, dt)
    local mx, my = love.mouse:getPosition()
    mx, my = mx / scale, my / scale

    if mx > self.screenX and mx < self.screenX + self.width and my > self.screenY and my < self.screenY + self.height then
        titlebarHover = true
    else
        titlebarHover = false
    end
end

gui:style({frame2, regularButton})

--FPS COUNTER--
titlebar.fps = gui:create("frame", {text = "FPS: ", x = 0})
function titlebar.fps:customUpdate(self, dt)
    self.text = "FPS: "..love.timer:getFPS()
end

--SAVE BUTTON--
gui:style({frame2, smallButton})
titlebar.save = gui:create("button", {text = "", x = 150, func = function()
    exportMap(map)
end})
titlebar.save.icon = gui:create("image", {source = love.graphics.newImage("sprites/save icon.png"), scale = 0.3, y = 5})

--EDIT BUTTON--
gui:style({frame2, smallButton})
titlebar.edit = gui:create("button", {text = "", x = 230, func = function()
end})
titlebar.edit.icon = gui:create("image", {source = love.graphics.newImage("sprites/edit icon.png"), scale = 0.2})

--HOME BUTTON--
gui:style({frame2, smallButton})
titlebar.home = gui:create("button", {alignmentX = "right", text = "", x = 0, func = function()
    menu = home
end})
titlebar.home.icon = gui:create("image", {source = love.graphics.newImage("sprites/home button.png"), scale = 0.35, y = 3})

--INFO BUTTON--
gui:style({frame2, smallButton})
titlebar.info = gui:create("button", {alignmentX = "right", text = "", x = -80, func = function()
    menu = info
end})
titlebar.info.icon = gui:create("image", {source = love.graphics.newImage("sprites/info button.png"), scale = 0.3, x = 0, y = 3})

editorGUI.titlebar = titlebar