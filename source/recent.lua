recents = {}

function updateRecents(map)
    local date = os.date("*t")
    --print(date.year)

    local info = {}
    info.name = map.name
    if map.directory == "" then
        info.directory = map.name
    else
        info.directory = map.directory
    end

    info.date = date.day.."/"..date.month.."/"..date.year.." "..date.hour..":"..string.format("%02d", date.min)

    for i, recentFile in ipairs(recents) do
        if recentFile.directory == info.directory then
            table.remove(recents, i)
        end
    end

    table.insert(recents, 1, info)

    save()

    updateRecentsList()
end

function updateRecentsList()
    for i, info in ipairs(recents) do
        if i > 5 then
            return
        end

        createRecent(info.name, info.directory, info.date, i)
    end
end