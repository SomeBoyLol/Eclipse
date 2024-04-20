gui:style({})

open = gui:create("window", {color = {36/255, 36/255, 36/255}})
open.title = gui:create("frame", {text = "Open a file", width = 450, height = 100, x = 50, y = 50, font = 45, textAlignmentX = "left", textAlignmentY = "top", color = {1, 0, 0, 0}})

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
    width = 700;
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

gui:style({subtitle})

open.path = gui:create("frame", {text = "Path"})
gui:style({input})
open.pathInput = gui:create("input", {})
open.pasteClipboard = gui:create("button", {text = "Paste from Clipboard", y = 280, width = 200, height = 40, textAlignmentX = "center", textAlignmentY = "center", func = function()
    open.pathInput.text = love.system:getClipboardText()
end})
open.clear = gui:create("button", {text = "Clear", x = 260, y = 280, width = 100, height = 40, textAlignmentX = "center", textAlignmentY = "center", func = function()
    open.pathInput.text = ""
end})
gui:style({})
open.results = gui:create("frame", {text = "", x = -100, width = 600, height = 800, textColor = {1, 0, 0}, color = {56/255, 56/255, 56/255}, alignmentX = "right", alignmentY = "center", textAlignmentX = "left", textAlignmentY = "top"})

gui:style({})

gui:style({smallbutton})
open.back = gui:create("button", {text = "Back", func = function() menu = home end})

open.next = gui:create("button", {text = "Open", x = 190, func = function()
    local success, result = pcall(function () editor:openMap(open.pathInput.text) end)

    if success then
        menu = editorGUI
    else
        open.results.text = result
    end
end})