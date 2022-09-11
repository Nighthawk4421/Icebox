local QBCore = exports['qb-core']:GetCoreObject()
--[[
RegisterNetEvent('icebox:client:icechain', function(fromchain, tochain)
    QBCore.Functions.Progressbar('Icing out' .. fromchain.label .. 'to' .. tochain.label, 'Icing out' .. fromchain.label .. 'to' .. tochain.label, 5000, false, false, false, 'amb@world_human_smoking@male@male_a@enter', nil, nil, function()
        TriggerServerEvent('icebox:server:icechain', fromchain, tochain)
    end, nil)
end)
]]
RegisterNetEvent('icebox:client:wearchain', function(item)
    ped = PlayerPedId()
    SetPedComponentVariation(ped, nil, Config.WearableChains[item].drawid, Config.WearableChains[item].textureid)
end)

exports['qb-target']:AddBoxZone("IceboxClockIn", vector3(-1256.48, -811.41, 17.84), 6.45, 6.35, {
	name = "IceBoxClockIn",
	heading = 308.08,
	debugPoly = false,
	minZ = 1.77834,
	maxZ = 338.87834,
}, {
	options = {
		{
            type = "server",
            event = "icebox:ToggleDuty",
			icon = "fas fa-sign-in-alt",
			label = "Clock In",
			job = "icebox",
		},
	},
	distance = 2.5
})


RegisterNetEvent('icebox:client:openStash')
AddEventHandler('icebox:client:openStash', function()
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "IceboxStash", {maxweight = 1000000, slots = 40})
    TriggerEvent("inventory:client:SetCurrentStash", "IceboxStash")
end)


exports['qb-target']:AddBoxZone("IceBoxStash", vector3(-1257.96, -822.85, 17.1), 2.45, 2.35, {
	name = "IceBoxStash",
	heading = 219.51,
	debugPoly = false,
	minZ = 1.77834,
	maxZ = 338.87834,
}, {
	options = {
		{
            type = "client",
            event = "icebox:client:openStash",
			icon = "fas fa-sign-in-alt",
			label = "Stash",
			job = "icebox",
		},
	},
	distance = 2.5
})


RegisterNetEvent('icebox:client:iceoutchain', function(harvestdrug)
    local playerPed = PlayerPedId()
    local hasItem = QBCore.Functions.HasItem('goldchain')
	local hasItem2 = QBCore.Functions.HasItem('washeddiamonds')
    local animDict = "anim@amb@business@meth@meth_monitoring_cooking@cooking@"
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do Wait(10) end
    Wait(10)
    if hasItem and hasItem2 then
        TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_ATM", 0, false)
        TriggerServerEvent("iceboxchainice:removeItem", 'goldchain', 1)
		TriggerServerEvent("iceboxchainice:removeItem", 'washeddiamonds', 1)
        QBCore.Functions.Progressbar('You start to ', ' You are icing out the chain ', 5000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true
            }, {}, {}, {}, function()
                QBCore.Functions.Notify('You are icing the chain. Wait for the process to finish %1', 'success', 1000)
                Wait(2500)
                QBCore.Functions.Notify('You are icing the chain. Wait for the process to finish %10', 'success', 1000)
                Wait(2500)
                QBCore.Functions.Notify('You are icing the chain. Wait for the process to finish %20', 'success', 1000)
                Wait(2500)
                QBCore.Functions.Notify('You are icing the chain. Wait for the process to finish %30', 'success', 1000)
                Wait(2500)
                QBCore.Functions.Notify('You are icing the chain. Wait for the process to finish %40', 'success', 1000)
                Wait(2500)
                QBCore.Functions.Notify('You are icing the chain. Wait for the process to finish %50', 'success', 1000)
                Wait(2500)
                QBCore.Functions.Notify('You are icing the chain. Wait for the process to finish %60', 'success', 1000)
                Wait(2500)
                QBCore.Functions.Notify('You are icing the chain. Wait for the process to finish %70', 'success', 1000)
                Wait(2500)
                QBCore.Functions.Notify('You are icing the chain. Wait for the process to finish %80', 'success', 1000)
                Wait(2500)
                QBCore.Functions.Notify('You are icing the chain. Wait for the process to finish %90', 'success', 1000)
                Wait(2500)
                QBCore.Functions.Notify('You are icing the chain. Wait for the process to finish %100', 'success', 1000)
                Wait(2500)
                TriggerServerEvent('icebox:server:icechain')
                QBCore.Functions.Notify('You have iced out the chain ', 'success', 5000)
            end)
        else
            QBCore.Functions.Notify('You dont have the right ingredients', 'error', 5000)
        end
        ClearPedTasks(playerPed)
end)


exports['qb-target']:AddBoxZone("IceChain", vector3(-1255.42, -825.21, 17.05), 1.45, 5.35, { -- The name has to be unique, the coords a vector3 as shown, the 1.5 is the length of the boxzone and the 1.6 is the width of the boxzone, the length and width have to be float values
	name = "IceChain",
	heading = 219.51,
	debugPoly = false,
	minZ = 1.77834,
	maxZ = 338.87834, -- This is the top of the boxzone, this can be different from the Z value in the coords, this has to be a float value
}, {
  	options = { -- This is your options table, in this table all the options will be specified for the target to accept
		{ -- This is the first table with options, you can make as many options inside the options table as you want
		num = 1, -- This is the position number of your option in the list of options in the qb-target context menu (OPTIONAL)
		type = "client", -- This specifies the type of event the target has to trigger on click, this can be "client", "server", "command" or "qbcommand", this is OPTIONAL and will only work if the event is also specified
		event = "icebox:client:iceoutchain", -- This is the event it will trigger on click, this can be a client event, server event, command or qbcore registered command, NOTICE: Normal command can't have arguments passed through, QBCore registered ones can have arguments passed through
		icon = 'fas fa-sign-in-alt', -- This is the icon that will display next to this trigger option
		label = 'Ice Gold Chain', -- This is the label of this option which you would be able to click on to trigger everything, this has to be a string
		targeticon = 'fas fa-eye', -- This is the icon of the target itself, the icon changes to this when it turns blue on this specific option, this is OPTIONAL
		job = 'icebox', -- This is the job, this option won't show up if the player doesn't have this job, this can also be done with multiple jobs and grades, if you want multiple jobs you always need a grade with it: job = {["police"] = 0, ["ambulance"] = 2},
		}
	},
	distance = 2.5, -- This is the distance for you to be at for the target to turn blue, this is in GTA units and has to be a float value
})

RegisterNetEvent('icebox:client:washdiamonds', function(harvestdrug)
    local playerPed = PlayerPedId()
    local hasItem = QBCore.Functions.HasItem('diamond')
    local animDict = "amb@world_human_maid_clean@"
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do Wait(10) end
    Wait(10)
    if hasItem then
        TriggerEvent('animations:client:EmoteCommandStart', {"clean2"})
		status = true
        TriggerServerEvent("iceboxchainice:removeItem", 'diamond', 1)
        QBCore.Functions.Progressbar('You start to ', ' You are washing the diamonds ', 5000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true
            }, {}, {}, {}, function()
                QBCore.Functions.Notify('Washing the diamonds. Wait for the process to finish %1', 'success', 1000)
                Wait(2500)
                QBCore.Functions.Notify('Washing the diamonds. Wait for the process to finish %10', 'success', 1000)
                Wait(2500)
                QBCore.Functions.Notify('Washing the diamonds. Wait for the process to finish %20', 'success', 1000)
                Wait(2500)
                QBCore.Functions.Notify('Washing the diamonds. Wait for the process to finish %30', 'success', 1000)
                Wait(2500)
                QBCore.Functions.Notify('Washing the diamonds. Wait for the process to finish %40', 'success', 1000)
                Wait(2500)
                QBCore.Functions.Notify('Washing the diamonds. Wait for the process to finish %50', 'success', 1000)
                Wait(2500)
                QBCore.Functions.Notify('Washing the diamonds. Wait for the process to finish %60', 'success', 1000)
                Wait(2500)
                QBCore.Functions.Notify('Washing the diamonds. Wait for the process to finish %70', 'success', 1000)
                Wait(2500)
                QBCore.Functions.Notify('Washing the diamonds. Wait for the process to finish %80', 'success', 1000)
                Wait(2500)
                QBCore.Functions.Notify('Washing the diamonds. Wait for the process to finish %90', 'success', 1000)
                Wait(2500)
                QBCore.Functions.Notify('Washing the diamonds. Wait for the process to finish %100', 'success', 1000)
                Wait(2500)
                TriggerServerEvent('icebox:server:washdiamonds')
                QBCore.Functions.Notify('You have washed the diamonds ', 'success', 5000)
				TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            end)
        else
            QBCore.Functions.Notify('You dont have the right ingredients', 'error', 5000)
        end
        ClearPedTasks(playerPed)
end)


exports['qb-target']:AddBoxZone("WashDiamonds", vector3(-1252.48, -822.89, 17.05), 1.45, 3.35, { -- The name has to be unique, the coords a vector3 as shown, the 1.5 is the length of the boxzone and the 1.6 is the width of the boxzone, the length and width have to be float values
	name = "WashDiamonds",
	heading = 306.85,
	debugPoly = false,
	minZ = 1.77834,
	maxZ = 338.87834, -- This is the top of the boxzone, this can be different from the Z value in the coords, this has to be a float value
}, {
  	options = { -- This is your options table, in this table all the options will be specified for the target to accept
		{ -- This is the first table with options, you can make as many options inside the options table as you want
		num = 1, -- This is the position number of your option in the list of options in the qb-target context menu (OPTIONAL)
		type = "client", -- This specifies the type of event the target has to trigger on click, this can be "client", "server", "command" or "qbcommand", this is OPTIONAL and will only work if the event is also specified
		event = "icebox:client:washdiamonds", -- This is the event it will trigger on click, this can be a client event, server event, command or qbcore registered command, NOTICE: Normal command can't have arguments passed through, QBCore registered ones can have arguments passed through
		icon = 'fas fa-sign-in-alt', -- This is the icon that will display next to this trigger option
		label = 'Wash the diamonds', -- This is the label of this option which you would be able to click on to trigger everything, this has to be a string
		targeticon = 'fas fa-eye', -- This is the icon of the target itself, the icon changes to this when it turns blue on this specific option, this is OPTIONAL
		job = 'icebox', -- This is the job, this option won't show up if the player doesn't have this job, this can also be done with multiple jobs and grades, if you want multiple jobs you always need a grade with it: job = {["police"] = 0, ["ambulance"] = 2},
		}
	},
	distance = 2.5, -- This is the distance for you to be at for the target to turn blue, this is in GTA units and has to be a float value
})


CreateThread(function()
    local c = Config.Locations["icebox"]
    local Blip = AddBlipForCoord(c.x, c.y, c.z)
    SetBlipSprite (Blip, 446)
    SetBlipDisplay(Blip, 4)
    SetBlipScale  (Blip, 0.7)
    SetBlipAsShortRange(Blip, true)
    SetBlipColour(Blip, 0)
    SetBlipAlpha(Blip, 0.7)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Icebox Jewelry")
    EndTextCommandSetBlipName(Blip)
end)





--[[
function ToggleProps(whic)
	local which = whic
	if type(whic) == "table" then
		which = tostring(Config.WearableChains)
	end
	Wait(50)

	if Cooldown then return end
	local Prop = Props[which]
	local Ped = PlayerPedId()
	local Cur = { -- Lets get out currently equipped prop.
		Id = Prop.Prop,
		Ped = Ped,
		Prop = GetPedPropIndex(Ped, Prop.Prop),
		Texture = GetPedPropTextureIndex(Ped, Prop.Prop),
	}
	SetPedComponentVariation(ped, 7, Config.WearableChains, Config.WearableChains, 0)
]]----[[

--[[
varaiable 1: player Id clothing
ped = PlayerPedId()
pedchain = QBCore.Functions.HasItem(Config.WearableChains[item])
if pedchain then
    SetPedComponentVariation(ped, 7, 0, 0, 0)
else
    TriggerClientEvent('icebox:client:wearchain')
end
if (player clothing id = variable)

{
 put playerclothing to 0 or -1 (What ever it is to take it off)


variable 2 = 0 or -1
} 
if (varaible 2  = 0 or -1 )
{

playerclothing to variable1

}


exports['qb-target']:AddBoxZone("IceboxClockIn", vector3(441.7989, -982.0529, 30.67834), 0.45, 0.35, {
	name = "ICeBoxClockIn",
	heading = 11.0,
	debugPoly = false,
	minZ = 30.77834,
	maxZ = 30.87834,
}, {
	options = {
		{
            type = "client",
            event = "icebox:ToggleDuty",
			icon = "fas fa-sign-in-alt",
			label = "Clock In",
			job = "icebox",
		},
	},
	distance = 2.5
})

]]



RegisterNetEvent('icebox:ToggleDuty', function()
    onDuty = not onDuty
    TriggerServerEvent("QBCore:ToggleDuty")
end)


