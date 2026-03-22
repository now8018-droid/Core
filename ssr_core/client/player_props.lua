CreateThread(function()
    while true do
        SetPedCanLosePropsOnDamage(PlayerPedId(), false, 0)
        Wait(1000)
    end
end)

CreateThread(function()
    local sleep = 1500

    while true do
        Wait(sleep)

        local ped = PlayerPedId()
        local wearingHelmet = IsPedWearingHelmet(ped)

        if wearingHelmet then
            SetPedHelmet(ped, false)
            RemovePedHelmet(ped, true)
            sleep = 200
        else
            sleep = 1500
        end
    end
end)
