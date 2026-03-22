local handsDict = "missminuteman_1ig_2"

CreateThread(function()
    RequestAnimDict(handsDict)
    while not HasAnimDictLoaded(handsDict) do Wait(100) end
end)

RegisterCommand("toggleHandsupPro", function()
    local ped = PlayerPedId()
    if IsEntityDead(ped) or IsPedInAnyVehicle(ped, false) then return end

    State.handsup = not State.handsup

    if State.handsup then
        TaskPlayAnim(ped, handsDict, "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
    else
        ClearPedTasks(ped)
    end
end)

RegisterKeyMapping("toggleHandsupPro", "Anim: Handsup", "keyboard", "X")

AddEventHandler("ssr_core:vehicleStateChanged", function(inVehicle)
    if inVehicle ~= true or not State.handsup then
        return
    end

    local ped = PlayerPedId()
    if ped and ped ~= 0 then
        ClearPedTasks(ped)
    end
    State.handsup = false
end)
