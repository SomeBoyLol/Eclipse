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
        end

        pallet["button "..i] = button
    end

    tilesetBody.pallet = pallet
end

tilesetBody.pallet = pallet

--IMAGE BODY--
gui:style({frame1, body})
imageBody = gui:create("frame", {text = "images"})

--COLLIDERS BODY--
gui:style({frame1, body})
collidersBody = gui:create("frame", {text = "colliders"})

assetManager.body = tilesetBody

editorGUI.assetManager = assetManager