ESX = nil
local playerLoaded = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(250)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    playerLoaded = true
end)

Citizen.CreateThread(function()
    SetDiscordAppId(24345456754757) -- discord id
    SetDiscordRichPresenceAsset('pitrslogo') -- logo presence
    SetDiscordRichPresenceAssetText('FiveM Server') -- presence text
    SetDiscordRichPresenceAssetSmall('esx') -- presence small text

       
    while true do
        Citizen.Wait(15000)

        local onlinePlayers = #GetActivePlayers()
        local maxPlayers = GetConvarInt("sv_maxclients", 64)

        if playerLoaded and ESX then
            local playerId = GetPlayerServerId(PlayerId())
            local playerName = GetPlayerName(PlayerId())

            SetRichPresence(string.format(
                "Nick: %s | ID: %s\nPlayers: %d/%d", -- String Format
                playerName, playerId, onlinePlayers, maxPlayers
            ))

            --SetDiscordRichPresenceAction(0, "Join", "fivem://connect/127.0.0.1:30120") -- Presence action 1
           -- SetDiscordRichPresenceAction(1, "Discord", "https://discord.gg/cJRRN3apdD") -- Presence action 2
        else
            SetRichPresence(string.format("Připojuje se...\nPlayers: %d/%d", onlinePlayers, maxPlayers)) -- String Format Joining server
        end
    end
end)