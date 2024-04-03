gui:style({})
loading = gui:create("window", {color = {36/255, 36/255, 36/255}})

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

gui:style({})
loading.title = gui:create("frame", {text = "Loading", x = 0, y = 0, width = coreWidth, height = coreHeight, textAlignmentX = "center", textAlignmentY = "center", font = 36, color = {0, 0, 0, 0}})
loading.title.dir = 1
function loading.title:customUpdate(self, dt)
    dt = love.timer.getDelta()
    if self.x >= 100 and self.dir == 1 then
        self.dir = -1
    elseif self.x <= -100 and self.dir == -1 then
        self.dir = 1
    end
    self.x = self.x + (100 * self.dir * dt)
end