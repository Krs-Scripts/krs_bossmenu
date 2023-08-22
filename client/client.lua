ESX = exports["es_extended"]:getSharedObject()


local PlayerData = {}

Citizen.CreateThread(function()
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)


RegisterNUICallback('chiudi', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)


function openBossMenu(job)

    SendNUIMessage({
      type = "openBossMenu",
      data = job
    })
    SetNuiFocus(true, true)
end


RegisterNUICallback('preleva', function(data, cb)
    local importo = data.importo
    print(importo)
    TriggerServerEvent('krs_bossmenu:preleva',importo, data.society)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('deposita', function(data, cb)
    local importo = data.importo
    print(importo)
    TriggerServerEvent('krs_bossmenu:deposita',importo, data.society)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('money', function(data, cb)
    print(json.encode(data))
    print(data.society)
    TriggerServerEvent('krs_bossmenu:money', data.society);
    SetNuiFocus(false, false);
    cb('ok');
end)

RegisterNUICallback('licenzia', function(data, cb)
    local playerPed = PlayerPedId()
    local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()

    if closestPlayer ~= -1 and closestPlayerDistance <= 3.0 then 
        local targetServerId = GetPlayerServerId(closestPlayer)

        ESX.TriggerServerCallback('licenziaGiocatore', function()
            cb('ok')
        end, targetServerId)
    else
        ESX.ShowNotification("Nessun player nelle vicinanze") 
    end
    SetNuiFocus(false, false)
end)


RegisterNUICallback('assumi', function(data, cb)
    local playerPed = PlayerPedId()
    local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()

    if closestPlayer ~= -1 and closestPlayerDistance <= 3.0 then 
        local targetServerId = GetPlayerServerId(closestPlayer)

        ESX.TriggerServerCallback('assumiGiocatore', function()
            cb('ok')
        end, targetServerId)
    else
        ESX.ShowNotification("Nessun player nelle vicinanze") 
    end
    SetNuiFocus(false, false)
end)


RegisterNetEvent('krs_bossmenu:openNui', function(job) -- Trigger Open Nui Boss Menu
    openBossMenu(job)
end)


-- Comando Boss Menu
RegisterCommand('apribossmenu', function()
    openBossMenu("police")
end)