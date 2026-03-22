local function startPointing()
    local ped = PlayerPedId()

    RequestAnimDict("anim@mp_point")
    while not HasAnimDictLoaded("anim@mp_point") do Wait(20) end

    SetPedCurrentWeaponVisible(ped, false, true, true, true)
    SetPedConfigFlag(ped, 36, true)

    Citizen.InvokeNative(0x2D537BA194896636, ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
end

local function stopPointing()
    local ped = PlayerPedId()

    Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
    ClearPedSecondaryTask(ped)
    SetPedCurrentWeaponVisible(ped, true, true, true, true)
    SetPedConfigFlag(ped, 36, false)

    State.pointing = false
end

RegisterCommand("Pointing", function()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, false) then return end

    if State.pointing then
        stopPointing()
        return
    end

    State.pointing = true
    startPointing()

    CreateThread(function()
        local smoothPitch = 0.5
        local smoothHeading = 0.5
        local rayTimer = 0

        while State.pointing do
            Wait(16)

            if not IsPedOnFoot(ped) or IsPedInAnyVehicle(ped, false) then
                stopPointing()
                break
            end

            local camPitch = math.max(-70.0, math.min(42.0, GetGameplayCamRelativePitch()))
            local camHeading = math.max(-180.0, math.min(180.0, GetGameplayCamRelativeHeading()))

            local targetPitch = (camPitch + 70.0) / 112.0
            local targetHeading = (camHeading + 180.0) / 360.0

            smoothPitch = smoothPitch + (targetPitch - smoothPitch) * 0.20
            smoothHeading = smoothHeading + (targetHeading - smoothHeading) * 0.20

            Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Pitch", smoothPitch)
            Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Heading", smoothHeading * -1.0 + 1.0)

            rayTimer = rayTimer + GetFrameTime()
            if rayTimer >= 0.25 then
                rayTimer = 0
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isBlocked", 0)
            end
        end
    end)
end)

RegisterKeyMapping("Pointing", "Anim: Pointing", "keyboard", "B")

AddEventHandler("ssr_core:vehicleStateChanged", function(inVehicle)
    if inVehicle ~= true or not State.pointing then
        return
    end
    stopPointing()
end)
