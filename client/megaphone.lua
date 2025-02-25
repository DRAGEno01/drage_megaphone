local QBCore = exports['qb-core']:GetCoreObject()
local usingMegaphone = false
local megaphoneRange = 150.0
local originalRange = 5.0

RegisterCommand('megaphone', function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle ~= 0 and GetVehicleClass(vehicle) == 18 then -- Class 18 is emergency vehicles
        if GetPedInVehicleSeat(vehicle, -1) == ped then
            usingMegaphone = not usingMegaphone
            TriggerEvent('QBCore:Notify', usingMegaphone and 'Megaphone ON' or 'Megaphone OFF')
            
            if usingMegaphone then
                exports['pma-voice']:setVoiceProperty('radioEnabled', true)
                exports['pma-voice']:setVoiceProperty('voiceRange', megaphoneRange)
                exports['pma-voice']:setVoiceProperty('phoneEnabled', true)
                exports['pma-voice']:setVoiceProperty('micClicks', true)
            else
                exports['pma-voice']:setVoiceProperty('voiceRange', originalRange)
                exports['pma-voice']:setVoiceProperty('phoneEnabled', false)
                exports['pma-voice']:setVoiceProperty('micClicks', false)
            end
        end
    end
end)

RegisterKeyMapping('megaphone', '(drage_megaphone) Toggle Megaphone', 'keyboard', 'B')

CreateThread(function()
    while true do
        Wait(500)
        if usingMegaphone then
            local ped = PlayerPedId()
            if not IsPedInAnyVehicle(ped, false) then
                usingMegaphone = false
                exports['pma-voice']:setVoiceProperty('voiceRange', originalRange)
            end
        end
    end
end) 
