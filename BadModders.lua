
if not async_http.have_access() then
    util.toast("Disable 'Disable Internet Access'!")
    util.stop_script()
end

local response = false
local localVer = 0.8
local localKs = false
async_http.init("raw.githubusercontent.com", "/Touft/Bad_Modders/main/BadModersVersion.txt", function(output)
    currentVer = tonumber(output)
    response = true
    if localVer ~= currentVer then
        util.toast("[Bad Modders] There is an update, click on the button to update the script.")
        menu.action(menu.my_root(), "Update Lua", {}, "", function()
            async_http.init('raw.githubusercontent.com','/Touft/Bad_Modders/main/BadModders.lua',function(a)
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
until response                                                         --Skidded but bro, this is just for updates


util.show_corner_help(" §\n~p~Let's find some ~r~BAD MODDERS\n§ ")





local badModders = {
    "ll-LaPuenta-ll",
    "LaFrappe667",
    "butwhen",
    "Aeko13760",
    "Juke755",
    "johnnynotfound",
    "Qbakaa",
    "KilliKiituri",
    "ExtraLT",
    "ciupakabra95",
    "gamercats2",
    "Cloudflare",
    "JustCallMeDenny",
    "TheROME007",
    "CoronavirusKill",
    "The_British_Guy6",
    "FreeLancer_07",
    "..Prime",
    "swagxton",
    "usedKeyboardWarr",
    "End-In-Passive",
    "qDependency",
    "La69emeFace",
    "Lissssaaa",
    "Awxnox",
    "Jeruvxia"
}

local rids = {
    "236797318",
    "210533533",
    "178813985",
    "196275741",
    "144659014",
    "192652074",
    "229365247",
    "138885648",
    "242394341",
    "166449239",
    "79991903",
    "55401915",
    "242595307",
    "160274841",
    "139253764",
    "246724247",
    "235426568",
    "238957858",
    "211270440",
    "243421618",
    "131564119",
    "88201667 ",
    "193782695",
    "246530233",
    "238684227",
    "221585116"
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


menu.divider(menu.my_root(), "LAST UPDATE")
menu.divider(menu.my_root(), "28/02/2024   18H40")
local modders = menu.list(menu.my_root(), "Bad Modders", {}, "")


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
                print("[Bad Modders] " .. playerName .. " is a Bad Modder with RID " .. playerRid .. " (he is on the list)")
                util.toast("[Bad Modders] " .. playerName .. " is a Bad Modder with RID " .. playerRid .. " (he is on the list)")
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
        print("[Bad Modders] Only the RID corresponds to " .. playerName .. " (it's probably him, he can change his name but not his RID)")
        util.toast("[Bad Modders] Only the RID corresponds to " .. playerName .. " (it's probably him, he can change his name but not his RID)")
    elseif foundByName then
        print("[Bad Modders] Only the NAME corresponds to " .. playerName .. " (it's probably not him, he can change his name but not his RID)")
        util.toast("[Bad Modders] Only the NAME corresponds to " .. playerName .. " (it's probably not him, he can change his name but not his RID)")
    end
end


util.on_stop(function ()
end)
    
players.dispatch_on_join()



--                     ___
--                  __/_  `.  .-"""-.
--                  \_,` | \-'  /   )`-')
--                   "") `"`    \  ((`"`
--                  ___Y  ,    .'7 /|
--                 (_,___/...-` (_/_/ 
--                This is my dog, Horya

--Ty to ChatGPT for helping me (he is a good dev)
--Ty to akayagi_au_ for doing NOTHING
--Ty to .touftouf. for helping me a lot (this is me hehe)
--Ty to im_too_strong for trying to help me
--Ty to microsoft_ma for trying to help me
--Ty to r_i_d_g_e for helping me