local PlayerPedId = PlayerPedId

AddEventHandler('onResourceStop', function(res)
    if res == GetCurrentResourceName() then
        SSRCore.resetPlayerState()
        DisplayRadar(false)
    end
end)

local function emitVehicleStateChanged()
    local ped = PlayerPedId()
    if not ped or ped == 0 then
        return
    end

    TriggerEvent("ssr_core:vehicleStateChanged", IsPedInAnyVehicle(ped, true))
end

AddEventHandler("gameEventTriggered", function(name, args)
    if name ~= "CEventNetworkPlayerEnteredVehicle" and name ~= "CEventNetworkPlayerExitedVehicle" then
        return
    end

    local ped = args and args[1]
    if ped ~= PlayerPedId() then
        return
    end

    emitVehicleStateChanged()
end)

AddEventHandler("playerSpawned", function()
    emitVehicleStateChanged()
end)

CreateThread(function()
    Wait(0)
    emitVehicleStateChanged()
end)
