--love.graphics.setBackgroundColor(36/255, 36/255, 36/255)

local button1 = {
    color = {}
}

local section = {
    y = 150;
    height = 800;
    color = {1, 0, 0, 0};
    font = 35;
    textAlignmentX = "left";
    textAlignmentY = "top";
}

home = gui:create("window", {color = {36/255, 36/255, 36/255}})
home.title = gui:create("frame", {text = "Eclipse Studio 2024", width = 450, height = 100, x = 50, y = 50, font = 45, textAlignmentX = "left", textAlignmentY = "top", color = {1, 0, 0, 0}})

local mediumbutton = {
    color = {36/255, 36/255, 36/255};
    hoverColor = {61/255, 61/255, 61/255};
    width = 850;
    height = 100;
    y = 70;
}

gui:style({section})
recent = gui:create("frame", {text = "Open recent", x = 50, width = 850})
gui:style({mediumbutton})
recent.button1 = {}
recent.button2 = {}
recent.button3 = {}
recent.button4 = {}

home.recent = recent

function createRecent(name, directory, date, num)
    num = num - 1
    gui:style({mediumbutton})
    local button = gui:create("button", {text = "", y = (110 * num) + 70})
    button.title = gui:create("frame", {text = name, x = 100, y = 0, width = 500, height = 50, font = 26, color = {1, 0, 0, 0}, textAlignmentX = "left"})
    button.directory = gui:create("frame", {text = directory, x = 100, y = -10, width = 700, font = 16, height = 50, color = {1, 0, 0, 0}, alignmentY = "bottom", textAlignmentX = "left"})
    button.date = gui:create("frame", {text = date, x = 0, y = 0, width = 200, height = 50, alignmentX = "right", alignmentY = "top", font = 16, color = {1, 0, 0, 0}})
    button.icon = gui:create("image", {x = -45, y = 0, source = love.graphics.newImage("sprites/icon file.png"), alignmentX = "left", alignmentY = "center", scale = 0.4})
    home.recent["button"..num] = button
end

createRecent("Map", "C:/Users/inesh/Onedrive/Documents/Programming/love2d/map", "16/03/2024 15:06", 1)
createRecent("Big boy island", "C:/Users/inesh/Onedrive/Documents/Games/bigboyisland", "11/09/2023 12:13", 2)
createRecent("Skibidi Toilet Universe", "C:/Users/inesh/Onedrive/Downlaods/skibidi", "16/03/2024 15:06", 3)
createRecent("Bruh", "C:/Users/inesh/Onedrive/Documents/Programming/love2d/map", "16/03/2024 15:06", 4)
createRecent("New map", "C:/Users/inesh/Onedrive/Documents/Programming/love2d/map", "16/03/2024 15:06", 5)

gui:style({section})
file = gui:create("frame", {text = "Get started", x = -150, width = 700, alignmentX = "right"})

local bigbutton = {
    text = "";
    color = {56/255, 56/255, 56/255};
    hoverColor = {34/255, 29/255, 70/255};
    width = 600;
    height = 150;
    font = 30;
    textAlignmentX = "left";
    textAlignmentY = "top";
    textMargin = 0;
    x = 0;
    y = 20
}

local desc = {
    font = 16;
    color = {1, 0, 0, 0};
    textAlignmentX = "left";
    textAlignmentY = "top";
    alignmentX = "left";
    alignmentY = "top";
    x = 150;
    y = 70;
    width = 400;
    height = 70;
}

local image = {
    alignmentX = "left";
    alignmentY = "center";
    x = -60;
    y = 5;
    scale = 0.75;
}

gui:style({bigbutton})
file.open = gui:create("button", {y = 70, func = function() menu = open end})
file.open.title = gui:create("frame", {text = "Open file", x = 150, color = {0, 0, 0, 0}, textColor = {1, 1, 1}})
gui:style({desc})
file.open.desc = gui:create("frame", {text = "Navigate and edit a file which has been already created"})
gui:style({image})
file.open.icon = gui:create("image", {source = love.graphics.newImage("sprites/oepn folder.png")})

gui:style({bigbutton})
file.create = gui:create("button", {y = 230, func = function() menu = create end})
file.create.title = gui:create("frame", {text = "Create file", x = 150, color = {0, 0, 0, 0}, textColor = {1, 1, 1}})
gui:style({desc})
file.create.desc = gui:create("frame", {text = "Adjust settings and create a new file to get started"})
gui:style({image})
file.create.icon = gui:create("image", {source = love.graphics.newImage("sprites/folder.png")})

gui:style({bigbutton})
file.editor = gui:create("button", {y = 390, func = function() menu = editorGUI end})
file.editor.title = gui:create("frame", {text = "Open Editor", x = 150, color = {0, 0, 0, 0}, textColor = {1, 1, 1}})
gui:style({desc})
file.editor.desc = gui:create("frame", {text = "Go into the editor and continue your project"})
gui:style({image})
file.editor.icon = gui:create("image", {source = love.graphics.newImage("sprites/icon editor.png"), scale = 0.55, x = -50, y = 0})

home.file = file