-- MINIMAP
local Radar = false

local lastInVehicle = nil

local function applyRadarState(inVehicle)
    if lastInVehicle ~= nil and inVehicle == lastInVehicle then
        return
    end

    lastInVehicle = inVehicle
    Radar = inVehicle

    local ped = PlayerPedId()
    if inVehicle then
        DisablePlayerVehicleRewards(PlayerId())
        if ped and ped ~= 0 then
            SetPedConfigFlag(ped, 35, false)
        end
        DisplayRadar(true)
        return
    end

    DisplayRadar(false)
end

AddEventHandler("ssr_core:vehicleStateChanged", function(inVehicle)
    applyRadarState(inVehicle == true)
end)
