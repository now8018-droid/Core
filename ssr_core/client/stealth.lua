CreateThread(function()
    while true do
        local ped = PlayerPedId()

        DisableControlAction(0, 36, true)
        DisableControlAction(1, 36, true)
        DisableControlAction(2, 36, true)

        if GetPedStealthMovement(ped) then
            SetPedStealthMovement(ped, false, 0)
        end

        Wait(0)
    end
end)
