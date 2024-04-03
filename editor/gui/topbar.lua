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
}

gui:style({frame1})
local topbar = gui:create("frame", {text = "", width = coreWidth, height = 100, y = 50,  alignmentY = "top"})

gui:style({button2, {font = 18, x = 10, y = 10, width = 80, height = 80}})
topbar.brush = gui:create("button", {text = "Brush", func = function() editor.brush = 1 end})
topbar.erase = gui:create("button", {text = "Erase", func = function() editor.brush = 0 end, x = 100})

gui:style({button2, {font = 18, x = 10, y = 10, width = 80, height = 80}})
for i = 1, #map.layers do
    local layerbutton = gui:create("button", {text = "Layer "..i, x = 90 * (i + 2), func = function(self) editor.layer = self.number end})
    layerbutton.number = i
    function layerbutton:customUpdate(self, dt)
        if editor.layer == self.number then
            self.color = self.hoverColor
        end
    end
    table.insert(topbar, layerbutton)
end

editorGUI.topbar = topbar

topbarHover = false

function topbarLoad(map)
    gui:style({frame1})

    local topbar = gui:create("frame", {text = "", width = coreWidth, height = 100, y = 50, alignmentY = "top", name = "topbar frame"})
    function topbar:customUpdate(self, dt)
        local mx, my = love.mouse:getPosition()
        mx, my = mx / scale, my / scale
    
        if mx > self.screenX and mx < self.screenX + self.width and my > self.screenY and my < self.screenY + self.height then
            topbarHover = true
        else
            topbarHover = false
        end
    end

    gui:style({button2, {font = 18, x = 10, y = 10, width = 80, height = 80}})
    topbar.brush = gui:create("button", {text = "Brush", func = function() editor.brush = 1 end, name = "brush button"})
    topbar.erase = gui:create("button", {text = "Erase", func = function() editor.brush = 0 end, x = 100, name = "erase button"})

    gui:style({button2, {font = 18, x = 10, y = 10, width = 80, height = 80}})
    for i = 1, #map.layers do
        local layerbutton = gui:create("button", {text = "Layer "..i, x = 90 * (i + 2), func = function(self) editor.layer = self.number end, name = "layer button "..i})
        layerbutton.number = i
        function layerbutton:customUpdate(self, dt)
            if editor.layer == self.number then
                self.color = self.hoverColor
            end
        end
        table.insert(topbar, layerbutton)
    end

    editorGUI.topbar = topbar

    --fixes epic bug
    editorGUI.topbar:childrenUpdate(love.timer:getDelta())
end

topbarLoad(map)