ESX = exports["es_extended"]:getSharedObject()


RegisterNetEvent('krs_bossmenu:money', function(job)
    local xPlayer = ESX.GetPlayerFromId(source)

    print(job)
    TriggerEvent('esx_addonaccount:getSharedAccount', "society_" .. job, function(account)
        print(account.money)
        xPlayer.showNotification('Soldi della società: $ ' .. account.money)
    end)
end)


RegisterNetEvent('krs_bossmenu:preleva', function(importo, job)
    local xPlayer = ESX.GetPlayerFromId(source)

        TriggerEvent('esx_addonaccount:getSharedAccount', "society_" .. job, function(account)
            print(account.money)
            if tonumber(account.money) >= tonumber(importo) then
                
            account.removeMoney(importo)
            xPlayer.addMoney(importo)
        end
    end)
end)

RegisterNetEvent('krs_bossmenu:deposita', function(importo, job)
    local xPlayer = ESX.GetPlayerFromId(source)

    print('dio')
    print(importo)
        TriggerEvent('esx_addonaccount:getSharedAccount', "society_" .. job, function(account)
            print(account.money)
            if xPlayer.getMoney() >= tonumber(importo) then
       
            account.addMoney(importo)
            xPlayer.removeMoney(importo)
        end
    end)
end)



ESX.RegisterServerCallback('assumiGiocatore', function(source, cb, target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local job = xPlayer.getJob().name
    print(job)
    if xPlayer.job.grade_name == 'boss' then
        local xTarget = ESX.GetPlayerFromId(target)
        
        if xTarget then
            xTarget.setJob(job, 1)
            local jobLabel = xTarget.getJob().label
            xTarget.showNotification("Sei stato assunto come " .. jobLabel)
            xPlayer.showNotification("Hai assunto " .. xTarget.getName() .. " come " .. jobLabel)
            cb(true)
        else
            print(('[^3AVVISO^7] Il giocatore ^5%s^7 ha tentato di assumere un giocatore inesistente!'):format(source))
            cb(false)
        end
    else
        print(('[^3AVVISO^7] Il giocatore ^5%s^7 ha tentato di assumere un giocatore!'):format(source))
        cb(false)
    end
end)


ESX.RegisterServerCallback('licenziaGiocatore', function(source, cb, target)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer.job.grade_name == 'boss' then
        local xTarget = ESX.GetPlayerFromId(target)
        
        if xTarget then
            local jobLabel = xTarget.getJob().label
            xTarget.setJob('unemployed', 0)
            xTarget.showNotification("Sei stato licenziato da " .. jobLabel)
            xPlayer.showNotification("Hai licenziato " .. xTarget.getName() .. " da " .. jobLabel)
            cb(true)
        else
            print(('[^3AVVISO^7] Il giocatore ^5%s^7 ha tentato di licenziare un giocatore inesistente!'):format(source))
            cb(false)
        end
    else
        print(('[^3AVVISO^7] Il giocatore ^5%s^7 ha tentato di licenziare un giocatore!'):format(source))
        cb(false)
    end
end)
