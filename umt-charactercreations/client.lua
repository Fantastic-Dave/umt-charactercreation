RegisterNetEvent("umt-charactercreations:characterCreate")
RegisterNetEvent("umt-charactercreations:normalSpawn")


local cam = nil
local freezedOnTop = true
local doStatus = -1
local continuousFadeOutNetwork = false

function f(n)
	n = n + 0.00000
	return n
end


AddEventHandler('playerSpawned', function()
	Citizen.CreateThread(function()
		while not playerLoaded do
			Citizen.Wait(100)
		end

		if firstSpawn then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin == nil then
					TriggerEvent('skinchanger:loadSkinNewAcc', {sex = 0}, OpenSaveableMenu)
				else
					TriggerEvent('skinchanger:loadSkinNewAcc', skin)
				end
			end)

			firstSpawn = false
		end
	end)
end)


function setCamHeight(height)
	local pos = GetEntityCoords(PlayerPedId())
	SetCamCoord(cam,vector3(pos.x,pos.y,f(height)))
end

local function StartFade()
	DoScreenFadeOut(500)
	while IsScreenFadingOut() do
		Citizen.Wait(1)
	end
end

local function EndFade()
	ShutdownLoadingScreen()
	DoScreenFadeIn(500)
	while IsScreenFadingIn() do
		Citizen.Wait(1)
	end
end

Citizen.CreateThread(function()
	while freezedOnTop do
		if doStatus == 1 then
			SetEntityInvincible(PlayerPedId(),true)
			SetEntityVisible(PlayerPedId(),true)
			FreezeEntityPosition(PlayerPedId(),true)
			SetPedDiesInWater(PlayerPedId(),false)
		elseif doStatus == 2 then
			TriggerCamController(doStatus)
			SetEntityInvincible(PlayerPedId(),false)
			SetEntityVisible(PlayerPedId(),true)
			FreezeEntityPosition(PlayerPedId(),false)
			SetPedDiesInWater(PlayerPedId(),true)
			TriggerCamController(-2)
			freezedOnTop = false
		elseif doStatus == 3 then
			freezedOnTop = false
			SetEntityInvincible(PlayerPedId(),false)
			SetEntityVisible(PlayerPedId(),true)
			FreezeEntityPosition(PlayerPedId(),false)
			SetPedDiesInWater(PlayerPedId(),true)
		else
			SetEntityInvincible(PlayerPedId(),true)
			SetEntityVisible(PlayerPedId(),false)
			FreezeEntityPosition(PlayerPedId(),true)
		end
		Citizen.Wait(1)
	end
end)

local altura
function TriggerCamController(statusSent)
	if not DoesCamExist(cam) then
		cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",false)
	end

	if statusSent == -1 then
		local pos = GetEntityCoords(PlayerPedId())
		SetCamCoord(cam,vector3(pos.x,pos.y,f(400)))
		SetCamRot(cam,-f(90),f(0),f(0),2)
		SetCamActive(cam,true)
		StopCamPointing(cam)
		RenderScriptCams(true,true,0,0,0,0)
	elseif statusSent == 2 then
		local pos = GetEntityCoords(PlayerPedId())
		SetCamCoord(cam,vector3(pos.x,pos.y,f(400)))
		altura = 1000
		while altura > 50 do
			if altura <= 300 then
				altura = altura - 6
			elseif altura >= 301 and altura <= 700 then
				altura = altura - 4
			else
				altura = altura - 2
			end
			setCamHeight(altura)
			Citizen.Wait(1)
		end
		DestroyCam(cam, false)
	elseif statusSent == -2 then
		SetCamActive(cam,false)
		StopCamPointing(cam)
		RenderScriptCams(0,0,0,0,0,0)
		SetFocusEntity(PlayerPedId())
	elseif statusSent == 1 then
		SetCamCoord(cam,vector3(23.36666, -652.482, 16.088))
		SetCamRot(cam,f(0),f(0),f(358),15)
		SetCamActive(cam,true)
		RenderScriptCams(true,true,20000000000000000000000000,0,0,0)
	end
end

RegisterNetEvent('ToogleBackCharacter')
AddEventHandler('ToogleBackCharacter',function()
	doStatus = 3
end)


-- local newchar = true
AddEventHandler("umt-charactercreations:characterCreate",function()
	-- if newchar == true then
	doStatus = 1
	SetTimeout(1000,function()
		TriggerCreateCharacter()
		-- newchar = false
	end)
	-- end
end)

AddEventHandler("umt-charactercreations:normalSpawn",function()
	TriggerCamController(-1)
	EndFade()
	doStatus = 2
    RenderScriptCams(false, true, 500, true, true)
end)

local isInCharacterMode = false
local skin = { fathersID = 0, mothersID = 0, skinColor = 0, shapeMix = 0.0, eyebrowsHeight = 0, eyebrowsWidth = 0, noseWidth = 0, noseHeight = 0, noseLength = 0, noseBridge = 0, noseTip = 0, noseShift = 0, cheekboneHeight = 0, cheekboneWidth = 0, cheeksWidth = 0, lips = -1, jawWidth = 0, jawHeight = 0, chinLength = 0, chinPosition = 0, chinWidth = 0, chinShape = 0, neckWidth = 0, moles_2 = 0, moles_1 = -1, watches_1 = -1, lipstick_2 = 0, pants_1 = 0, sun_2 = 0, helmet_2 = 0, complexion_2 = 0, bodyb_1 = 0, chest_3 = 0, lipstick_3 = 0, torso_2 = 0, bags_2 = 0, pants_2 = 0, bracelets_1 = -1, beard_2 = 0, chest_1 = -1, sun_1 = -1, lipstick_4 = 0, makeup_1 = -1, hair_color_1 = 0, eyebrows_2 = 0, ears_2 = 0, bags_1 = 0, blush_1 = -1, makeup_4 = 0, complexion_1 = -1, glasses_1 = 0, beard_3 = 0, bracelets_2 = 0, chest_2 = 0, eyebrows_4 = 0, blush_2 = 0, bodyb_2 = 0, face = 0, helmet_1 = -1, makeup_2 = 0, bproof_1 = 0, torso_1 = 0, decals_1 = 0, beard_4 = 0, chain_2 = 0, skin = 0, chain_1 = 0, hair_color_2 = 0, lipstick_1 = -1, bproof_2 = 0, blemishes_1 = -1, age_2 = 0, shoes_2 = 0, blush_3 = 0, hair_1 = 0, eye_color = 0, shoes_1 = 0, decals_2 = 0, beard_1 = -1, mask_2 = 0, sex = 0, age_1 = -1, mask_1 = 0, watches_2 = 0, arms = 0, ears_1 = -1, tshirt_1 = 0, makeup_3 = 0, blemishes_2 = 0, tshirt_2 = 2, hair_2 = 0, glasses_2 = 0, eyebrows_3 = 0, arms_2 = 0, eyebrows_1 = 0 }
local characterNome = ""
local characterSobrenome = ""
local characterAge = 0

function TriggerCreateCharacter()
		TriggerCamController(-1)
		isInCharacterMode = true
		StartFade()
		continuousFadeOutNetwork = true
		TriggerCamController(-2)
		changeGender("mp_m_freemode_01")
		refreshDefaultCharacter()
		TaskUpdateSkinOptions()
		TaskUpdateFaceOptions()
		TaskUpdateHeadOptions()
		SetEntityCoordsNoOffset(PlayerPedId(),23.36666, -652.482, 16.088,true,true,true) 
		SetEntityHeading(PlayerPedId(),f(400))
		TriggerCamController(doStatus)
		Citizen.Wait(5000)
		EndFade()
		SetNuiFocus(isInCharacterMode,isInCharacterMode)
		SendNUIMessage({ CharacterMode = isInCharacterMode, CharacterMode2 = not isInCharacterMode, CharacterMode3 = not isInCharacterMode })
		
		RequestAnimDict("anim@amb@clubhouse@mini@darts@")
		while not HasAnimDictLoaded("anim@amb@clubhouse@mini@darts@") do
			Citizen.Wait(0)
		end
		TaskPlayAnim(PlayerPedId(), "anim@amb@clubhouse@mini@darts@" , "wait_idle", 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
end

function refreshDefaultCharacter()
	SetPedDefaultComponentVariation(PlayerPedId())
	SetPedHeadBlendData(GetPlayerPed(-1), 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.0, false)
end

function changeGender(model)
	local mhash = GetHashKey(model)
	while not HasModelLoaded(mhash) do
		RequestModel(mhash)
		Citizen.Wait(10)
	end

	if HasModelLoaded(mhash) then
		SetPlayerModel(PlayerId(),mhash)
		SetPedMaxHealth(PlayerPedId(),200)
		SetEntityHealth(PlayerPedId(),200)
		SetPedDefaultComponentVariation(GetPlayerPed(-1))
		SetPedHeadBlendData(GetPlayerPed(-1), 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.0, false)
		SetModelAsNoLongerNeeded(mhash)
	end
end

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		if continuousFadeOutNetwork then 

			for _, player in ipairs(GetActivePlayers()) do
				if player ~= PlayerId() and NetworkIsPlayerActive(player) then
					NetworkFadeOutEntity(GetPlayerPed(player),false)
				end
			end
		else
			Citizen.Wait(1000)
		end
	end
end)

RegisterNUICallback('cDone',function(data,cb)
	SetNuiFocus(isInCharacterMode, isInCharacterMode)
	SendNUIMessage({ CharacterMode = not isInCharacterMode, CharacterMode2 = isInCharacterMode, CharacterMode3 = not isInCharacterMode })
end)

RegisterNUICallback('BackPart1', function(data,cb)
	SetNuiFocus(isInCharacterMode, isInCharacterMode)
	SendNUIMessage({ CharacterMode = isInCharacterMode, CharacterMode2 = not isInCharacterMode, CharacterMode3 = not isInCharacterMode })
end)

RegisterNUICallback('cDonePart2', function(data,cb)
	SetNuiFocus(isInCharacterMode, isInCharacterMode)
	SendNUIMessage({ CharacterMode = not isInCharacterMode, CharacterMode2 = not isInCharacterMode, CharacterMode3 = isInCharacterMode })
end)

RegisterNUICallback('BackPart2', function(data,cb)
	SetNuiFocus(isInCharacterMode, isInCharacterMode)
	SendNUIMessage({ CharacterMode = not isInCharacterMode, CharacterMode2 = isInCharacterMode, CharacterMode3 = not isInCharacterMode })
end)

RegisterNUICallback('cDoneSave',function(data,cb)
	StartFade()
	isInCharacterMode = false
	SetNuiFocus(isInCharacterMode,isInCharacterMode)
	SendNUIMessage({ CharacterMode = isInCharacterMode, CharacterMode2 = isInCharacterMode, CharacterMode3 = isInCharacterMode })

	SetEntityCoordsNoOffset(PlayerPedId(),2042.94, 3457.4, 43.79,true,true,true)
	SetEntityHeading(PlayerPedId(), 316.73)
	continuousFadeOutNetwork = false

	for _, player in ipairs(GetActivePlayers()) do
		if player ~= PlayerId() and NetworkIsPlayerActive(player) then
			NetworkFadeInEntity(GetPlayerPed(id),true)
		end
	end

	TriggerEvent("esx_skin:setLastSkinNewAcc", skin)
	TriggerEvent("skinchanger:setLastSkinNewAcc", skin)
	TriggerServerEvent("umt-charactercreations:finishedCharacter", skin)
	ClearPedTasksImmediately(PlayerPedId())
end)

RegisterNUICallback('cChangeHeading',function(data,cb)
	SetEntityHeading(PlayerPedId(),f(data.camRotation))
	cb('ok')
end)

RegisterNUICallback('ChangeGender',function(data,cb)
	skin.sex = data.gender
	if data.gender == 1 then
		changeGender("mp_f_freemode_01")
	else
		changeGender("mp_m_freemode_01")
	end
	refreshDefaultCharacter()
	TaskUpdateSkinOptions()
	TaskUpdateFaceOptions()
	TaskUpdateHeadOptions()
	
	RequestAnimDict("anim@amb@clubhouse@mini@darts@")
	while not HasAnimDictLoaded("anim@amb@clubhouse@mini@darts@") do
		Citizen.Wait(0)
	end
	TaskPlayAnim(PlayerPedId(), "anim@amb@clubhouse@mini@darts@" , "wait_idle", 8.0, 1.0, -1, 1, 0, 0, 0, 0 )

	cb('ok')
end)

RegisterNUICallback('UpdateSkinOptions',function(data,cb)
	skin.fathersID = data.fathersID
	skin.mothersID = data.mothersID
	skin.skinColor = data.skinColor
	skin.shapeMix = data.shapeMix
	TaskUpdateSkinOptions()
	cb('ok')
end)

function TaskUpdateSkinOptions()
	local data = skin

	if data.fathersID == 45 and data.mothersID == 45 then
		SetPedHeadBlendData(PlayerPedId(), data.fathersID, data.fathersID, data.skinColor, data.fathersID, data.fathersID, data.fathersID, 1.0, 1.0, 1.0, false)
	else
		SetPedHeadBlendData(PlayerPedId(), data.fathersID, data.mothersID, 0, data.skinColor, 0, 0, f(data.shapeMix), 0.0, 0.0, false)
	end
end

RegisterNUICallback('UpdateFaceOptions',function(data,cb)
	skin.eye_color = data.eyesColor
	skin.eyebrowsHeight = data.eyebrowsHeight
	skin.eyebrowsWidth = data.eyebrowsWidth
	skin.noseWidth = data.noseWidth
	skin.noseHeight = data.noseHeight
	skin.noseLength = data.noseLength
	skin.noseBridge = data.noseBridge
	skin.noseTip = data.noseTip
	skin.noseShift = data.noseShift
	skin.cheekboneHeight = data.cheekboneHeight
	skin.cheekboneWidth = data.cheekboneWidth
	skin.cheeksWidth = data.cheeksWidth
	skin.lips = data.lips
	skin.jawWidth = data.jawWidth
	skin.jawHeight = data.jawHeight
	skin.chinLength = data.chinLength
	skin.chinPosition = data.chinPosition
	skin.chinWidth = data.chinWidth
	skin.chinShape = data.chinShape
	skin.neckWidth = data.neckWidth
	TaskUpdateFaceOptions()
	cb('ok')
end)

function TaskUpdateFaceOptions()
	local ped = PlayerPedId()
	local data = skin

	-- Olhos
	SetPedEyeColor(ped,data.eye_color)
	-- Sobrancelha
	SetPedFaceFeature(ped,6,data.eyebrowsHeight)
	SetPedFaceFeature(ped,7,data.eyebrowsWidth)
	-- Nariz
	SetPedFaceFeature(ped,0,data.noseWidth)
	SetPedFaceFeature(ped,1,data.noseHeight)
	SetPedFaceFeature(ped,2,data.noseLength)
	SetPedFaceFeature(ped,3,data.noseBridge)
	SetPedFaceFeature(ped,4,data.noseTip)
	SetPedFaceFeature(ped,5,data.noseShift)
	-- Bochechas
	SetPedFaceFeature(ped,8,data.cheekboneHeight)
	SetPedFaceFeature(ped,9,data.cheekboneWidth)
	SetPedFaceFeature(ped,10,data.cheeksWidth)
	-- Boca/Mandibula
	SetPedFaceFeature(ped,12,data.lips)
	SetPedFaceFeature(ped,13,data.jawWidth)
	SetPedFaceFeature(ped,14,data.jawHeight)
	-- Queixo
	SetPedFaceFeature(ped,15,data.chinLength)
	SetPedFaceFeature(ped,16,data.chinPosition)
	SetPedFaceFeature(ped,17,data.chinWidth)
	SetPedFaceFeature(ped,18,data.chinShape)
	-- Pescoço
	SetPedFaceFeature(ped,19,data.neckWidth)
end

RegisterNUICallback('UpdateHeadOptions',function(data,cb)
	skin.hair_1 = data.hairModel
	skin.hair_color_1 = data.firstHairColor
	skin.hair_color_2 = data.secondHairColor
	skin.eyebrows_1 = data.eyebrowsModel
	skin.eyebrows_3 = data.eyebrowsColor
	skin.beard_1 = data.beardModel
	skin.beard_3 = data.beardColor
	skin.chest_1 = data.chestModel
	skin.chest_3 = data.chestColor
	skin.blush_1 = data.blushModel
	skin.blush_3 = data.blushColor
	skin.lipstick_1 = data.lipstickModel
	skin.lipstick_3 = data.lipstickColor
	skin.blemishes_1 = data.blemishesModel
	skin.age_1 = data.ageingModel
	skin.complexion_1 = data.complexionModel
	skin.sun_1 = data.sundamageModel
	skin.moles_1 = data.frecklesModel
	skin.makeup_1 = data.makeupModel

	skin.eyebrows_2 = 10
	skin.beard_2 = 10
	skin.chest_2 = 10
	skin.blush_2 = 10
	skin.lipstick_2 = 10
	skin.blemishes_2 = 10
	skin.age_2 = 10
	skin.complexion_2 = 10
	skin.sun_2 = 10
	skin.moles_2 = 10
	skin.makeup_2 = 10
	TaskUpdateHeadOptions()
	cb('ok')
end)

function TaskUpdateHeadOptions()
	local ped = PlayerPedId()
	local data = skin

	-- Cabelo
	SetPedComponentVariation(ped,2,data.hair_1,0,0)
	SetPedHairColor(ped,data.hair_color_1,data.hair_color_2)
	-- Sobracelha 
	SetPedHeadOverlay(ped,2,data.eyebrows_1,0.99)
	SetPedHeadOverlayColor(ped,2,1,data.eyebrows_3,data.eyebrows_3)
	-- Barba
	SetPedHeadOverlay(ped,1,data.beard_1,0.99)
	SetPedHeadOverlayColor(ped,1,1,data.beard_3,data.beard_3)
	-- Pelo Corporal
	SetPedHeadOverlay(ped,10,data.chest_1,0.99)
	SetPedHeadOverlayColor(ped,10,1,data.chest_3,data.chest_3)
	-- Blush
	SetPedHeadOverlay(ped,5,data.blush_1,0.99)
	SetPedHeadOverlayColor(ped,5,2,data.blush_3,data.blush_3)
	-- Battom
	SetPedHeadOverlay(ped,8,data.lipstick_1,0.99)
	SetPedHeadOverlayColor(ped,8,2,data.lipstick_3,data.lipstick_3)
	-- Manchas
	SetPedHeadOverlay(ped,0,data.blemishes_1,0.99)
	SetPedHeadOverlayColor(ped,0,0,0,0)
	-- Envelhecimento
	SetPedHeadOverlay(ped,3,data.age_1,0.99)
	SetPedHeadOverlayColor(ped,3,0,0,0)
	-- Aspecto
	SetPedHeadOverlay(ped,6,data.complexion_1,0.99)
	SetPedHeadOverlayColor(ped,6,0,0,0)
	-- Pele
	SetPedHeadOverlay(ped,7,data.sun_1,0.99)
	SetPedHeadOverlayColor(ped,7,0,0,0)
	-- Sardas
	SetPedHeadOverlay(ped,9,data.moles_1,0.99)
	SetPedHeadOverlayColor(ped,9,0,0,0)
	-- Maquiagem
	SetPedHeadOverlay(ped,4,data.makeup_1,0.99)
	SetPedHeadOverlayColor(ped,4,0,0,0)
end

Citizen.CreateThread(function()   -- AFK cinematic off
  while true do
    N_0xf4f2c0d4ee209e20() 
    Wait(1000)
  end 
end)
