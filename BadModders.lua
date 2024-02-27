util.require_natives("3095a")
-- Auto Updater from https://github.com/hexarobi/stand-lua-auto-updater
local status, auto_updater = pcall(require, "auto-updater")
if not status then
    local auto_update_complete = nil util.toast("Installing auto-updater...", TOAST_ALL)
    async_http.init("raw.githubusercontent.com", "/hexarobi/stand-lua-auto-updater/main/auto-updater.lua",
        function(result, headers, status_code)
            local function parse_auto_update_result(result, headers, status_code)
                local error_prefix = "Error downloading auto-updater: "
                if status_code ~= 200 then util.toast(error_prefix..status_code, TOAST_ALL) return false end
                if not result or result == "" then util.toast(error_prefix.."Found empty file.", TOAST_ALL) return false end
                filesystem.mkdir(filesystem.scripts_dir() .. "lib")
                local file = io.open(filesystem.scripts_dir() .. "lib\\auto-updater.lua", "wb")
                if file == nil then util.toast(error_prefix.."Could not open file for writing.", TOAST_ALL) return false end
                file:write(result) file:close() util.toast("Successfully installed auto-updater lib", TOAST_ALL) return true
            end
            auto_update_complete = parse_auto_update_result(result, headers, status_code)
        end, function() util.toast("Error downloading auto-updater lib. Update failed to download.", TOAST_ALL) end)
    async_http.dispatch() local i = 1 while (auto_update_complete == nil and i < 40) do util.yield(250) i = i + 1 end
    if auto_update_complete == nil then error("Error downloading auto-updater lib. HTTP Request timeout") end
    auto_updater = require("auto-updater")
end
if auto_updater == true then error("Invalid auto-updater lib. Please delete your Stand/Lua Scripts/lib/auto-updater.lua and try again") end

auto_updater.run_auto_update({
    source_url="https://raw.githubusercontent.com/Touft/Bad_Modders/main/BadModders.lua",
    script_relpath=SCRIPT_RELPATH,
    verify_file_begins_with="--"
})
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
    "",
    "",
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
    "",
    "",
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

-- Manually check for updates with a menu option
menu.action(script_meta_menu, "Check for Update", {}, "The script will automatically check for updates at most daily, but you can manually check using this option anytime.", function()
    auto_update_config.check_interval = 0
    util.toast("Checking for updates")
    auto_updater.run_auto_update(auto_update_config)
end)

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
