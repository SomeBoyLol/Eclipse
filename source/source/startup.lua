function startup()
    coreWidth, coreHeight = 1920, 1080
    scale = 1
    fullscreen = false

    recents = {}
    mapTilesets = {}

    function math.round(num)
        return math.floor(num + 0.5)
    end

    function round(number, factor)
        return math.round(number / factor) * factor
    end

    --LIBRARIES--
    gui = require("libraries/gui")
    inspect = require("libraries/inspect-master/inspect")
    cam = require("libraries/camera")
    require("libraries/show")

    cam.scale = 1

    --MAIN REQUIRE--
    require("editor/main")
    require("source/menu")
    require("source/save")
    require("source/recent")
    require("source/debug")
    require("source/mapTilesets")

    require("gui/home")
    require("gui/create")
    require("gui/open")
    require("gui/loading")
    require("gui/newTileset")

    love.graphics.setDefaultFilter("nearest", "nearest")
end