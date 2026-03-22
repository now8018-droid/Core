local crouchAnimSet = "move_ped_crouched"
local crouchControl = 36
local crouchThreadActive = false
local state = SSRCore.getState()

local function resetCrouch(ped)
    ResetPedMovementClipset(ped, 0.25)
    state.crouched = false
end

local function startCrouchThread()
    if crouchThreadActive then
        return
    end

    crouchThreadActive = true

    CreateThread(function()
        while state.crouched do
            local ped = PlayerPedId()

            if IsPedInAnyVehicle(ped, true) or IsEntityDead(ped) then
                resetCrouch(ped)
                break
            end

            DisableControlAction(0, crouchControl, true)
            DisableControlAction(1, crouchControl, true)
            DisableControlAction(2, crouchControl, true)
            Wait(0)
        end

        crouchThreadActive = false
    end)
end

RegisterCommand('+crouched', function()
    local ped = PlayerPedId()
    if state.crouched or IsPedInAnyVehicle(ped, true) or IsEntityDead(ped) then
        return
    end

    SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)

    RequestAnimSet(crouchAnimSet)
    while not HasAnimSetLoaded(crouchAnimSet) do
        Wait(0)
    end

    SetPedMovementClipset(ped, crouchAnimSet, 0.25)
    state.crouched = true
    startCrouchThread()
end, false)

RegisterCommand('-crouched', function()
    local ped = PlayerPedId()
    if not state.crouched then
        return
    end

    resetCrouch(ped)
end, false)

RegisterKeyMapping('+crouched', 'Anim: Crouched', 'keyboard', 'LCONTROL')
