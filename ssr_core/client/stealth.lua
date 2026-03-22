CreateThread(function()
    while true do
        local ped = PlayerPedId()

        DisableControlAction(0, 36, true)
        DisableControlAction(1, 36, true)
        DisableControlAction(2, 36, true)

        if IsPedArmed(ped, 6) then
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
            DisableControlAction(1, 263, true)
            DisableControlAction(1, 264, true)
        end

        if GetPedStealthMovement(ped) then
            SetPedStealthMovement(ped, false, 0)
        end

        Wait(0)
    end
end)
