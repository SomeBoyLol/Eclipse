collidersInfo = {}

colliderClassColor = {1, 1, 1}

function resetCollidersInfo()
    collidersInfo = {}

    for name, class in pairs(map.colliders) do
        local classInfo = {}
        classInfo.color = {1, 0, 0}
        classInfo.visible = true
    
        collidersInfo[name] = classInfo
    end
end

function editor:newColliderClass(name)
    map.colliders[name] = {}

    local classInfo = {}
    classInfo.color = {1, 0, 0}
    classInfo.visible = true

    collidersInfo[name] = classInfo

    updateCollidersList()
end

function editor:deleteColliderClass(name)
    if name == nil then
        return
    end

    map.colliders[name] = nil
    editor.selectColliderClass = nil
    updateCollidersList()
end

function editor:newCollider(settings)
    local collider = {}
    collider.x = settings.x
    collider.y = settings.y
    collider.width = settings.width
    collider.height = settings.height

    table.insert(map.colliders[settings.class], collider)
end

function editor:updateColliders(dt)
end

function editor:drawColliders()
    for className, class in pairs(map.colliders) do
        love.graphics.setColor(collidersInfo[className].color)
        if (collidersInfo[className].visible) then
            for index, collider in pairs(class) do
                love.graphics.rectangle("line", collider.x, collider.y, collider.width, collider.height)
            end
        end
    end
end