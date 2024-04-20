editor.layer = 1
editor.brush = 1
editor.tool = "brush"
editor.hover = false
editor.inbound = false --if the mouse is on the grid or not

editor.grid = true

assetManagerHover = false
topbarHover = false
titlebarHover = false

editor.targetX = nil
editor.targetY = nil

editor.selectX = 0
editor.selectY = 0
editor.selectWidth = 0
editor.selectHeight = 0
editor.selectFactor = 16

editor.selectColliderClass = nil
editor.drawingCollider = false
editor.startColliderX = 0
editor.startColliderY = 0

map = {}
map.name = "map"
map.scale = 16
map.width = 1
map.height = 1
map.directory = ""
map.layers = {{}, {}, {}, {}, {}, {}, {}}
map.colliders = {}

maploader = coroutine.create(function() end)

tileset = {}

function resetTileset()
    tileset = {}
    setmetatable(tileset, metatileset)
end

camSpeed = 1000

maploading = false

require("editor/map")
require("editor/export")
require("editor/controller")
require("editor/tileset")
require("editor/colliders")