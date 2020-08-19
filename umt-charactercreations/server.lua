ESX = nil 

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local userlogin = {}

local first_spawn = true
local firstspawn = true

AddEventHandler("es:playerLoaded",function(user_id,source,first_spawn)
	if first_spawn then
		-- local data = vRP.getUData(xPlayer,"vRP:spawnController")
		-- local sdata = json.decode(data) or 0
		local source = source
        local user_id = ESX.GetPlayerFromId(source)

		if user_id then
			Citizen.Wait(1000)
			processSpawnController(source,user_id)
		end
	end
end)

function processSpawnController(source,statusSent,user_id)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if statusSent == 2 then
		if not userlogin[user_id] then
			userlogin[user_id] = true
			doSpawnPlayer(source,user_id,false)
		else
			doSpawnPlayer(source,user_id,true)
		end
	elseif statusSent == 1 or statusSent == 0 then
		userlogin[user_id] = true
		TriggerClientEvent("umt-charactercreations:characterCreate",source)
	end
end

RegisterServerEvent("umt-charactercreations:finishedCharacter")
AddEventHandler("umt-charactercreations:finishedCharacter",function(skin)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET skin = @skin WHERE identifier = @identifier', {
		['@skin'] = json.encode(skin),
		['@identifier'] = xPlayer.identifier
	})

		doSpawnPlayer(source,user_id,true)
end)

function doSpawnPlayer(source,user_id,firstspawn)
	TriggerClientEvent("umt-charactercreations:normalSpawn",source,firstspawn)
end