local github = menu.list(menu.my_root(), "Updates", {"moddersupdate"}, "")
menu.hyperlink(github, "Discord", "https://discord.gg/")

async_http.init("raw.githubusercontent.com","",function(text)
    menu.action(github, "Changelog", {"modderschangelog"}, text, function() end)
    response=true;
end)
async_http.dispatch()
repeat util.yield()
until response

if not dev_mode then
    async_http.init("raw.githubusercontent.com","/Touft/Bad_Modders/main/BadModdersVersion.txt",function(b)
    currentVer=tonumber(b)
    response=true;
    if BadModdersVersion~=currentVer then
        util.toast("New Version found")async_http.init('raw.githubusercontent.com','/Touft/Bad_Modders/main/BadModders.lua',function(c)
        local d=select(2,load(c))
        if d then
            util.toast("Update failed to download, please re-download manually via Github or using Addict Discord Server.")
            return
            end;
            local e=io.open(filesystem.scripts_dir()..SCRIPT_RELPATH,"wb")
            e:write(c)
            e:close()
            util.toast("Update Done!")
            util.restart_script()
            end)
            async_http.dispatch()
        end
    end,
    function()
        response=true
    end)
    async_http.dispatch()
    repeat util.yield()
    until response
end
--=========================================UPDATES==============================================--

----------------------------------------------------------------

util.show_corner_help(" \n~p~Let's find some ~r~BAD MODDERS\n ")

util.on_stop(function ()
end)
    
players.dispatch_on_join()

--==================================================================--



local badModders = {
    "LaFrappe667",
    "ll-LaPuenta-ll",
    "johnnynotfound",
    "Qbakaa",
    "KilliKiituri",
    "ExtraLT",
    "ciupakabra95",
    "gamercats2",
    "Cloudflare",
    "JustCallMeDenny",
    "TheROME007",
    "",
    "",
    "",
    "",
    ""
}

local rids = {
    "210533533",
    "236797318",
    "192652074",
    "229365247",
    "138885648",
    "242394341",
    "166449239",
    "79991903",
    "55401915",
    "242595307",
    "160274841",
    "",
    "",
    "",
    "",
    ""
}

local playersList = players.list(true, true, true)
local playersName = {}
local playersRid = {}

for _, playerId in ipairs(playersList) do
    local playerName = players.get_name(playerId)
    table.insert(playersName, playerName)

    local playerRid = players.get_rockstar_id(playerId)
    table.insert(playersRid, playerRid)
end

---------------------------------------------------------------

menu.divider(menu.my_root(), "")
local modders = menu.list(menu.my_root(), "Bad Modders", {}, "")


--------------------------------------------------------------------

local badModders_menus = {}
for i, modder in ipairs(badModders) do
    badModders_menus[i] = menu.list(modders, modder, {}, "")
end

for i, rid in ipairs(rids) do
    menu.list(badModders_menus[i], rid, {}, "")
end

for i, playerName in ipairs(playersName) do
    local playerRid = tostring(playersRid[i])
    local foundByRid = false
    local foundByName = false
    
    for j, modderName in ipairs(badModders) do
        local normalizedPlayerName = string.lower(playerName):gsub("%s+", "")
        local normalizedModderName = string.lower(modderName):gsub("%s+", "")
        
        if normalizedPlayerName == normalizedModderName then
            local ridToCompare = rids[j]:gsub("%s+", "")
            if playerRid == ridToCompare then
                print("!!! " .. playerName .. " is a Bad Modder with RID " .. playerRid .. " (he is on the list)")
                util.toast("!!! " .. playerName .. " is a Bad Modder with RID " .. playerRid .. " (he is on the list)")
                foundByRid = true
                foundByName = true
            else
                foundByName = true
            end
        end
    end
    
    local playerRidNormalized = playerRid:gsub("%s+", "")
    for j, rid in ipairs(rids) do
        local normalizedRid = rid:gsub("%s+", "")
        
        if playerRidNormalized == normalizedRid then
            foundByRid = true
            break
        end
    end
    
    if foundByRid and foundByName then
    elseif foundByRid then
        print("!!! Only the RID corresponds to " .. playerName .. " (it's probably him, he can change his name but not his RID)")
        util.toast("!!! Only the RID corresponds to " .. playerName .. " (it's probably him, he can change his name but not his RID)")
    elseif foundByName then
        print("!!! Only the NAME corresponds to " .. playerName .. " (it's probably not him, he can change his name but not his RID)")
        util.toast("!!! Only the NAME corresponds to " .. playerName .. " (it's probably not him, he can change his name but not his RID)")
    end
end

--====================END========================--
