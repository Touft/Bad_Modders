
if not async_http.have_access() then
    util.toast("Disable 'Disable Internet Access'!")
    util.stop_script()
end




local response = false
local localVer = 0.3
local localKs = false
async_http.init("raw.githubusercontent.com", "/Touft/Bad_Modders/main/BadModersVersion.txt", function(output)
    currentVer = tonumber(output)
    response = true
    if localVer ~= currentVer then
        util.toast("[Ryze Script] There is an update, click on the button to update the script.")
        menu.action(menu.my_root(), "Update Lua", {}, "", function()
            async_http.init('raw.githubusercontent.com','/Touft/Bad_Modders/blob/main/BadModders.lua',function(a)
                local err = select(2,load(a))
                if err then
                    util.toast("There was a failure updating the script, do it manually from github.")
                return end
                local f = io.open(filesystem.scripts_dir()..SCRIPT_RELPATH, "wb")
                f:write(a)
                f:close()
                util.toast("Script updated :3")
                util.restart_script()
            end)
            async_http.dispatch()
        end)
    end
end, function() response = true end)
async_http.dispatch()
repeat 
    util.yield()
until response
--=========================================UPDATES==============================================--

----------------------------------------------------------------

util.show_corner_help(" \n~p~Let's find some ~r~BAD MODDERS\n ")

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
    "TheROME007"
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
    "160274841"
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

util.on_stop(function ()
end)
    
players.dispatch_on_join()
