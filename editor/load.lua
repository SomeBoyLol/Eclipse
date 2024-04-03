editor.layer = 1
editor.brush = 1
editor.hover = false

assetManagerHover = false
topbarHover = false
titlebarHover = false

editor.selectX = 1
editor.selectY = 1

map = {}
map.scale = 16
map.width = 1
map.height = 1
map.directory = ""
map.layers = {{}, {}, {}, {}, {}, {}, {}}

metatileset = {}
metatileset.__index = function()
    return love.graphics.newQuad(0, 0, 0, 0, epicImage)
end

maploader = coroutine.create(function() end)

tileset = {}
setmetatable(tileset, metatileset)

camSpeed = 1000

maploading = false

require("editor/map")
require("editor/export")
require("editor/controller")
require("editor/tileset")