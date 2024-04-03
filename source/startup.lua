function startup()
    coreWidth, coreHeight = 1920, 1080
    scale = 1

    --LIBRARIES--
    gui = require("libraries/gui")
    inspect = require("libraries/inspect-master/inspect")
    cam = require("libraries/camera")
    require("libraries/show")

    --MAIN REQUIRE--
    require("editor/main")
    require("source/menu")
    require("source/save")

    require("gui/home")
    require("gui/create")
    require("gui/open")
    require("gui/loading")
    require("gui/newTileset")
end