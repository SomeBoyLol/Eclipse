gui:style({})

create = gui:create("window", {color = {36/255, 36/255, 36/255}})
create.title = gui:create("frame", {text = "Create a new file", width = 450, height = 100, x = 50, y = 50, font = 45, textAlignmentX = "left", textAlignmentY = "top", color = {1, 0, 0, 0}})

local subtitle = {
    x = 50;
    y = 170;
    width = 500;
    height = 50;
    color = {1, 0, 0, 0};
    textAlignmentX = "left";
    font = 30;
}

local input = {
    x = 50;
    y = 230;
    width = 610;
    height = 40;
    textAlignmentX = "left";
    font = 16;
    textMargin = 10;
    color = {56/255, 56/255, 56/255};
    editColor = {64/255, 64/255, 64/255};
    hoverColor = {64/255, 64/255, 64/255};
}

local smallbutton = {
    color = {64/255, 53/255, 130/255};
    hoverColor = {81/255, 67/255, 163/255};
    alignmentX = "left";
    alignmentY = "bottom";
    x = 50;
    y = -50;
    width = 130;
    height = 50;
    font = 20;
}

--NAME--
gui:style({subtitle})
create.name = gui:create("frame", {text = "Name"})
gui:style({input})
create.nameInput = gui:create("input", {text = "Map"})

--SAVE--
gui:style({subtitle})
create.save = gui:create("frame", {text = "Save Directory", y = 300})
gui:style({input})
create.saveInput = gui:create("input", {text = "C:/Users/inesh/OneDrive/Documents", y = 360})

--DIMENSIONS--
gui:style({subtitle})
create.dimensions = gui:create("frame", {text = "Dimensions", y = 430})
gui:style({input})
create.dimensionsWidth = gui:create("input", {text = "10", width = 300, y = 500})
create.dimensionsHeight = gui:create("input", {text = "10", x = 360, width = 300, y = 500})

--LAYERS--
gui:style({subtitle})
create.layers = gui:create("frame", {text = "Layers", y = 560})
gui:style({input})
create.layersInput = gui:create("input", {text = "3", y = 630})

--SCALE--
gui:style({subtitle})
create.scale = gui:create("frame", {text = "Scale", y = 690})
gui:style({input})
create.scaleInput = gui:create("input", {text = "16", y = 760})

gui:style({smallbutton})
create.back = gui:create("button", {text = "Back", func = function() menu = home end})
create.next = gui:create("button", {text = "Next", x = 190, func = function() 
    local succes, result = pcall(function()
        editor:createMap({directory = create.saveInput.text, width = tonumber(create.dimensionsWidth.text), height = tonumber(create.dimensionsHeight.text), layers = tonumber(create.layersInput.text), scale = tonumber(create.scaleInput.text)})
        editor:loadTileset({sprite = love.graphics.newImage("tileset2.png"), scale = 64})
    end)

    editor:createMap({width = tonumber(create.dimensionsWidth.text), height = tonumber(create.dimensionsHeight.text), layers = tonumber(create.layersInput.text), scale = tonumber(create.scaleInput.text)})
    editor:loadTileset({sprite = love.graphics.newImage("tileset2.png"), scale = 64})

    menu = editorGUI

    print(table.show(map))

    if success then
        editor:loadTileset({sprite = love.graphics.newImage("tileset2.png"), scale = 64})
    else
        print("failed")
    end
end})