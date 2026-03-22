local PlayerPedId = PlayerPedId

State = {
    crouched = false,
    pointing = false,
    handsup = false
}

function SafeReset()
    local ped = PlayerPedId()

    if State.crouched then
        ResetPedMovementClipset(ped, 0)
        State.crouched = false
    end

    if State.pointing then
        ClearPedSecondaryTask(ped)
        SetPedCurrentWeaponVisible(ped, true, true, true, true)
        SetPedConfigFlag(ped, 36, false)
        State.pointing = false
    end

    if State.handsup then
        ClearPedTasks(ped)
        State.handsup = false
    end
end

AddEventHandler('onResourceStop', function(res)
    if res == GetCurrentResourceName() then
        SafeReset()
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
