local button1 = {
    color = {36/255, 158/255, 83/255};
    hoverColor = {30/255, 130/255, 69/255};
}

local button2 = {
    color = {55/255, 55/255, 55/255};
    hoverColor = {74/255, 74/255, 74/255};
    editColor = {74/255, 74/255, 74/255};
}

local frame1 = {
    color = {47/255, 47/255, 47/255};
}

local frame2 = {
    color = {35/255, 35/255, 35/255};
}

--ASSET MANAGER--
gui:style({frame2})
local assetManager = gui:create("frame", {text = "", width = 600, height = coreHeight - 150, alignmentX = "right", alignmentY = "bottom"})
function assetManager:customUpdate(self, dt)
    local mx, my = love.mouse:getPosition()
    mx, my = mx / scale, my / scale

    if mx > self.screenX and mx < self.screenX + self.width and my > self.screenY and my < self.screenY + self.height then
        assetManagerHover = true
    else
        assetManagerHover = false
    end
end

gui:style({frame2})
assetManager.topbar = gui:create("frame", {text = "", width = 600, height = 50, x = 0, y = 0})

local topbarButton = {
    font = 20;
    width = 150;
    height = 50;
}

--TOPBAR--
gui:style({button2, topbarButton})
assetManager.topbar.tileset = gui:create("button", {text = "Tileset", func = function() assetManager.body = tilesetBody end})
assetManager.topbar.images = gui:create("button", {text = "Images", x = 150, func = function() assetManager.body = imageBody end})
assetManager.topbar.colliders = gui:create("button", {text = "Colliders", x = 300, func = function() assetManager.body = collidersBody end})

--BODY CODE--
assetManager.body = {}

local body = {
    text = "";
    color = {0, 0, 0, 0};
    width = 600;
    height = coreHeight - 200;
    alignmentY = "bottom";
}


--TILESET BODY--
gui:style({frame1, body})
tilesetBody = gui:create("frame", {})
gui:style({button2})
tilesetBody.name = gui:create("frame", {text = "", x = 10, y = 10, font = 18, width = 350, textAlignmentX = "left", textMargin = 20})
tilesetBody.tool = gui:create("frame", {text = 5, x = 370, y = 10, font = 18})

function tilesetBody.tool:customUpdate(self, dt)
    self.text = editor.brush
end

tilesetBody.new = gui:create("button", {text = "New", x = -10, y = 10, font = 18, width = 50, height = 50, alignmentX = "right", func = function() menu = newTileset end})

gui:style({frame2})
local pallet = gui:create("frame", {text = "", y = -10, alignmentX = "center", alignmentY = "bottom", width = 580, height = coreHeight - 280})

palletX, palletY = 1, 1
palletHover = false

function updateTilesetPallet(tileset)
    if not (#tileset > 0) then
        tilesetBody.pallet = {}
        return
    end

    tilesetBody.name.text = tileset.name
    gui:style({frame2})
    local pallet = gui:create("frame", {text = "", y = -10, alignmentX = "center", alignmentY = "bottom", width = 580, height = coreHeight - 280})
    function pallet:customUpdate(self, dt)
        local mx, my = love.mouse:getPosition()
        mx, my = mx / scale, my / scale
        
        palletHover = false

        if mx > self.screenX and mx < self.screenX + self.width and my > self.screenY and my < self.screenY + self.height then
            palletHover = true
        end
    end

    local tilesize = 100

    for i, tile in ipairs(tileset) do
        local y = math.ceil(i / tileset.width)
        local x = i - tileset.width * (y - 1)

        local button = gui:create("button", {text = i, x = (x - 1) * tilesize, y = (y - 1) * tilesize, width = tilesize, height = tilesize, func = function(self)
            if palletHover then
                editor.brush = self.num
            end
        end})

        button.num = i
        local icon = gui:create("image", {source = tileset.sprite, alignmentX = "center", alignmentY = "center", scale = tilesize / tileset.scale})
        icon.quad = tileset[i]

        function icon:draw()
            love.graphics.setColor(1, 1, 1, 0.9)
            love.graphics.draw(self.source, self.quad, self.parent.screenX, self.parent.screenY, nil, self.scale, self.scale)
        end

        button.icon = icon

        function button:customUpdate(self, dt)
            self.x = self.x + palletX
            self.y = self.y + palletY

            if self.num == editor.brush then
                self.color = self.hoverColor
            end
        end

        pallet["button "..i] = button
    end

    tilesetBody.pallet = pallet
    assetManager.body = tilesetBody
end

tilesetBody.pallet = pallet


--IMAGE BODY--
gui:style({frame1, body})
imageBody = gui:create("frame", {text = "images"})


--COLLIDERS BODY--
gui:style({frame1, body})
collidersBody = gui:create("frame", {text = ""})

gui:style({button2})
collidersBody.newClass = gui:create("button", {text = "+", font = 25, alignmentX = "right", x = -10, y = 10, width = 50, height = 50, func = function()
    editor:newColliderClass(assetManager.body.newClassName.text)
end})
collidersBody.newClassName = gui:create("input", {text = "", x = 10, y = 10, width = 400, height = 50, font = 18})


--OPTIONS-- bro this stupid shit is coded so badly is causes so many errors
gui:style({frame2})
options = gui:create("frame", {text = "", y = -10, width = 580, height = 190, alignmentX = "center", alignmentY = "bottom"})
gui:style({button2})
options.colorText = gui:create("frame", {text = "Color (RGB value 0 - 255)", x = 10, y = 10, width = 90, height = 40})
gui:style({button2, {width = 60, height = 40, y = 10}})
--options.color1 = gui:create("input", {text = 255, x = 110, func = function(self) if self.text ~= tostring(tonumber(self.text)) then return end tonumber(self.text) if self.text >= 0 and self.text <= 255 then colliderClassColor[1] = self.text / 255 end end})
--options.color2 = gui:create("input", {text = 255, x = 180, func = function(self) if self.text ~= tostring(tonumber(self.text)) then return end tonumber(self.text) if self.text >= 0 and self.text <= 255 then colliderClassColor[2] = self.text / 255 end end})
--options.color3 = gui:create("input", {text = 255, x = 250, func = function(self) if self.text ~= tostring(tonumber(self.text)) then return end tonumber(self.text) if self.text >= 0 and self.text <= 255 then colliderClassColor[3] = self.text / 255 end end})
options.color1 = gui:create("input", {text = 255, x = 110, func = function(self) tonumber(self.text) colliderClassColor[1] = self.text / 255 end})
options.color2 = gui:create("input", {text = 255, x = 180, func = function(self) tonumber(self.text) colliderClassColor[2] = self.text / 255 end})
options.color3 = gui:create("input", {text = 255, x = 250, func = function(self) tonumber(self.text) colliderClassColor[3] = self.text / 255 end})
options.preview = gui:create("frame", {text = "", x = 320, width = 40})
function options.preview:customUpdate(self, dt)
    self.color = colliderClassColor
end
options.set = gui:create("button", {text = "Set", x = 370, width = 80, func = function()
    if editor.selectColliderClass ~= nil then
        print("skibidi")
        collidersInfo[editor.selectColliderClass].color = {colliderClassColor[1], colliderClassColor[2], colliderClassColor[3]}
    end
end})

gui:style({button2})
options.note = gui:create("frame", {text = "warning: any bad input will cause an error", x = -10, y = 10, alignmentX = "right", alignmentY = "top", height = 40, color = {0, 0, 0, 0}})

gui:style({})
options.maxwell = gui:create("image", {source = love.graphics.newImage("sprites/maxwell.png"), scale = 0.2, alignmentX = "right", x = 15, y = 15})

options.delete = gui:create("button", {color = {1, 0, 0}, text = "", width = 10, height = 10, alignmentX = "right", alignmentY = "bottom", func = function()
    editor:deleteColliderClass(editor.selectColliderClass)
end})

--gotta think of a better naming system
gui:style({button2, {x = 10, y = 60, width = 90, height = 40}})
options.selectFactorText = gui:create("frame", {text = "Change select factor"})
options.selectFactor = gui:create("input", {text = "64", x = 110, width = 60, func = function(self)
    if self.text == tostring(tonumber(self.text)) then
        editor.selectFactor = tonumber(self.text)
    end
end})

gui:style({button2})
options.newCollider = gui:create("button", {text = "New Collider", font = 20, x = 10, y = -10, width = 200, alignmentX = "left", alignmentY = "bottom", func = function()
    editor.tool = "collider"
end})
function options.newCollider:customUpdate(self, dt)
    if editor.tool == "collider" then
        self.color = self.hoverColor
    end
end
options.deleteCollider = gui:create("button", {text = "Delete Collider", font = 20, x = 220, y = -10, width = 200, alignmentX = "left", alignmentY = "bottom", func = function()
    editor.tool = "delete"
end})
function options.deleteCollider:customUpdate(self, dt)
    if editor.tool == "delete" then
        self.color = self.hoverColor
    end
end

collidersBody.options = options


function updateCollidersList()
    gui:style({frame2})
    local list = gui:create("frame", {text = "", x = 10, y = 70, width = 580, height = 600})

    local index = 0
    for className, class in pairs(map.colliders) do
        gui:style({button2})
        local class = gui:create("frame", {text = "", x = 5, y = 45 * index + 5, width = 570, height = 40})
        class.button = gui:create("button", {text = className, font = 16, textMargin = 20, textAlignmentX = "left", width = 530, height = 40, func = function(self)
            editor.selectColliderClass = self.text
        end}) 
        function class.button:customUpdate(self, dt)
            if editor.selectColliderClass == self.text then
                self.color = self.hoverColor
            end
        end

        gui:style({{color = {1, 0, 0}, hoverColor = {0.7, 0, 0}}})
        class.hide = gui:create("button", {text = "Show/hide", width = 40, height = 40, alignmentX = "right", func = function(self)
            collidersInfo[self.className].visible = not(collidersInfo[self.className].visible)
        end})
        class.hide.className = className

        index = index + 1

        list[className.." button"] = class
    end

    collidersBody.list = list
end

assetManager.body = collidersBody

editorGUI.assetManager = assetManager