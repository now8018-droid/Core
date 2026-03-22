local crouched = false
RegisterCommand('crouched', function()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, true) or IsEntityDead(ped) then return end

    if crouched then
        ResetPedMovementClipset(ped, 0)
        -- SetPedConfigFlag(ped, 36, 0)
        -- SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
        crouched = false
        return
    end

    SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
    -- SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)

    RequestAnimSet("move_ped_crouched")
    while not HasAnimSetLoaded("move_ped_crouched") do Wait(0) end
    SetPedMovementClipset(ped, "move_ped_crouched", 0.25)
    -- SetPedConfigFlag(ped, 36, 1)
    DisableControlAction( 0, 36, true )
    DisableControlAction( 1, 36, true )
    DisableControlAction( 2, 36, true )

    crouched = true
end, false)

RegisterKeyMapping('crouched', 'Anim: Crouched', 'keyboard', 'LCONTROL')


Citizen.CreateThread(function() 
	while true do 
		Citizen.Wait(0) 
		DisableControlAction(0, 36, true)
	end 
end)

-- ปิดแว่นตบ --
Citizen.CreateThread(function()
    while true do
        SetPedCanLosePropsOnDamage(PlayerPedId(),false,0)
        Citizen.Wait(1000)
    end
end)

-- ปิดระบบใส่หมวกอัตโนมัติเอง
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local playerPed = PlayerPedId()

        SetPedHelmet(playerPed, false)
        RemovePedHelmet(playerPed, true)
    end
end)


-- ปิดตบปืน --
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(7)
        local ped = PlayerPedId()
        if IsPedArmed(ped, 6) then
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
            DisableControlAction(1, 263, true)
            DisableControlAction(1, 264, true)
        end
    end
end)
