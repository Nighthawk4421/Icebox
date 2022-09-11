local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    for i, d in pairs(Config.Chains) do
        QBCore.Functions.CreateUseableItem(i, function(source, item)
            local canUse = QBCore.Functions.CanUseItem(Config.Chains)
            print(canUse)
            print(d)
            player = QBCore.Functions.GetPlayer(source)
            TriggerClientEvent('icebox:client:icechain', source, item, QBCore.Shared.Items[Config.Chains[item.name]])
        end)
    end
end)

RegisterNetEvent('icebox:server:icechain', function(fromchain, tochain)
    player = QBCore.Functions.GetPlayer(source)
    player.Functions.RemoveItem('goldchain', 1, nil)
    player.Functions.AddItem('icedoutgoldchain', 1, {})
end)

RegisterNetEvent('icebox:server:washdiamonds', function(fromchain, tochain)
    player = QBCore.Functions.GetPlayer(source)
    player.Functions.RemoveItem('diamond', 1, nil)
    player.Functions.AddItem('washeddiamonds', 1, {})
end)

RegisterNetEvent('icebox:ToggleDuty', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if Player.PlayerData.job.onduty then
        Player.Functions.SetJobDuty(false)
        TriggerClientEvent('QBCore:Notify', src, ('You clocked in'))
    else
        Player.Functions.SetJobDuty(true)
        TriggerClientEvent('QBCore:Notify', src, ('You clocked out'))
    end
    TriggerClientEvent('QBCore:Client:SetDuty', src, Player.PlayerData.job.onduty)
end)

RegisterServerEvent("iceboxchainice:removeItem")
AddEventHandler("iceboxchainice:removeItem", function(itemname, count)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    xPlayer.Functions.RemoveItem(itemname, count)
end)