local QBCore = exports['qb-core']:GetCoreObject()

local activeBlips = {}
local lastNotifyTimes = {
    Injured = 0,
    Dead = 0,
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)

        local ped = PlayerPedId()
        local health = GetEntityHealth(ped)
        local coords = GetEntityCoords(ped)
        local curTime = GetGameTimer()

        for status, data in pairs(Config.NotificationTypes) do
            if status == "Injured" and health > 0 and health < data.HealthThreshold then
                if curTime - lastNotifyTimes[status] > data.Cooldown then
                    lastNotifyTimes[status] = curTime
                    TriggerServerEvent('RedDev-Dispatch:NotifyAmbulance', status, coords)
                end
            elseif status == "Dead" and health <= data.HealthThreshold then
                if curTime - lastNotifyTimes[status] > data.Cooldown then
                    lastNotifyTimes[status] = curTime
                    TriggerServerEvent('RedDev-Dispatch:NotifyAmbulance', status, coords)
                end
            end
        end
    end
end)

RegisterNetEvent('RedDev-Dispatch:Notify')
AddEventHandler('RedDev-Dispatch:Notify', function(status, coords)
    local data = Config.NotificationTypes[status]
    if not data then return end

    if Config.EnableNotifications then
        QBCore.Functions.Notify(data.Message, "error")
    end

    if Config.EnableBlips then
        if #activeBlips >= Config.MaxActiveBlips then
            if DoesBlipExist(activeBlips[1]) then
                RemoveBlip(activeBlips[1])
            end
            table.remove(activeBlips, 1)
        end

        local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite(blip, data.BlipSprite)
        SetBlipColour(blip, data.BlipColor)
        SetBlipScale(blip, 1.0)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Emergency Location")
        EndTextCommandSetBlipName(blip)

        table.insert(activeBlips, blip)

        Citizen.SetTimeout(data.BlipDuration, function()
            if DoesBlipExist(blip) then
                RemoveBlip(blip)
            end
            for i, b in ipairs(activeBlips) do
                if b == blip then
                    table.remove(activeBlips, i)
                    break
                end
            end
        end)
    end
end)
