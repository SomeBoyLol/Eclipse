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

--MAIN--
main = gui:create("window", {})

gui:style({button1, {font = 28, width = 400, height = 80, alignmentX = "center", alignmentY = "center"}})
main.new = gui:create("button", {text = "New File", y = -100, func = function() menu = create end})
main.open = gui:create("button", {text = "Open File", func = function() menu = open end})

--INFO--
gui:style({})
info = gui:create("window", {name = "skibidi"})
gui:style({frame2, {text = "This is still a WIP. \nSometimes I wonder how the future of this project will look like (written 29/3/2024) \n\nMaxwell is the mascot of eclipse :D"}})
info.body = gui:create("frame", {width = 800, height = 600, alignmentX = "center", alignmentY = "center", y = -50, textAlignmentX = "left", textAlignmentY = "top", textMargin = 25, font = 20})
gui:style({button2})
info.back = gui:create("button", {text = "Back to home", width = 200, height = 70, font = 20, y = 300, alignmentX = "center", alignmentY = "center", func = function() menu = home end})
info.maxwell = gui:create("image", {source = love.graphics.newImage("sprites/maxwell.png"), alignmentX = "left", scale = 0.7})

--EDITOR--

gui:style({})
editorGUI = gui:create("window", {})
editorGUI.name = "editorGUI"
require("editor/gui/assetmanager")
require("editor/gui/topbar")
require("editor/gui/titlebar")

menu = main