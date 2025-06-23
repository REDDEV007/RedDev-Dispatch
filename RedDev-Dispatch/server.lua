local QBCore = exports['qb-core']:GetCoreObject()

local function tableContains(tbl, val)
    for _, v in ipairs(tbl) do
        if v == val then return true end
    end
    return false
end

RegisterNetEvent('RedDev-Dispatch:NotifyAmbulance')
AddEventHandler('RedDev-Dispatch:NotifyAmbulance', function(status, coords)
    local players = QBCore.Functions.GetPlayers()
    for _, playerId in pairs(players) do
        local Player = QBCore.Functions.GetPlayer(playerId)
        if Player and Player.PlayerData.job and tableContains(Config.NotifiedJobs, Player.PlayerData.job.name) then
            if Config.NotificationRadius == 0 then
                TriggerClientEvent('RedDev-Dispatch:Notify', playerId, status, coords)
            else
                local playerPed = GetPlayerPed(playerId)
                local playerCoords = GetEntityCoords(playerPed)
                local dist = #(playerCoords - coords)
                if dist <= Config.NotificationRadius then
                    TriggerClientEvent('RedDev-Dispatch:Notify', playerId, status, coords)
                end
            end
        end
    end
end)
