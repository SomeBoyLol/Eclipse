gui:style({})

newTileset = gui:create("window", {color = {36/255, 36/255, 36/255}})
newTileset.title = gui:create("frame", {text = "New Tileset", width = 450, height = 100, x = 50, y = 50, font = 45, textAlignmentX = "left", textAlignmentY = "top", color = {1, 0, 0, 0}})

newTileset.maxwell = gui:create("image", {source = love.graphics.newImage("sprites/maxwell.png"), x = 340, alignmentX = "left", alignmentY = "top", scale = 0.5})
newTileset.maxwellText = gui:create("frame", {text = "Hi my name is maxwell.", color = {0, 0, 0, 0}, x = 700, y = 50, width = 600, height = 200, textAlignmentX = "left", textAlignmentY = "top", textMargin = 15, font = 20})

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
newTileset.name = gui:create("frame", {text = "Name"})
gui:style({input})
newTileset.nameInput = gui:create("input", {text = "ambatukam"})

--SOURCE-- IM MORBING RAHHH
gui:style({subtitle})
newTileset.source = gui:create("frame", {text = "Tileset Sprite Source", y = 300})
gui:style({input})
newTileset.sourceInput = gui:create("input", {text = "C:/Users/inesh/OneDrive/Documents", y = 360})
newTileset.pasteClipboard = gui:create("button", {text = "Paste from Clipboard", y = 410, width = 200, height = 40, textAlignmentX = "center", textAlignmentY = "center", func = function()
    newTileset.sourceInput.text = love.system:getClipboardText()
end})
newTileset.clear = gui:create("button", {text = "Clear", x = 260, y = 410, width = 100, height = 40, textAlignmentX = "center", textAlignmentY = "center", func = function()
    newTileset.sourceInput.text = ""
end})

--SCALE--
gui:style({subtitle})
newTileset.scale = gui:create("frame", {text = "Scale", y = 480})
gui:style({input})
newTileset.scaleInput = gui:create("input", {text = "64", y = 540})

--BOTTOM BUTTONS--
gui:style({smallbutton})
newTileset.back = gui:create("button", {text = "Back", func = function() menu = home end})

newTileset.create = gui:create("button", {text = "Create", x = 190, func = function()
    local success, error = pcall(function() editor:loadTileset({path = newTileset.sourceInput.text, scale = tonumber(newTileset.scaleInput.text)}) end)
    print(error)
    if success then
        menu = editorGUI
    else
        newTileset.maxwellText.textColor = {1, 0, 0}
        newTileset.maxwellText.text = "There seems to be an error unfortunately\n\n"..error
    end
end})