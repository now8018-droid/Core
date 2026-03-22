CreateThread(function()
    local sleep = 1000

    while true do
        Wait(sleep)

        local ped = PlayerPedId()
        if IsPedArmed(ped, 6) then
            sleep = 0
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
            DisableControlAction(1, 263, true)
            DisableControlAction(1, 264, true)
        else
            sleep = 1000
        end
    end
end)
