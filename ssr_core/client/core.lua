SSRCore = SSRCore or {}

local state = SSRCore.state or {
    crouched = false,
    pointing = false,
    handsup = false
}

SSRCore.state = state

function SSRCore.getState()
    return state
end

function SSRCore.getESX()
    if not SSRCore.esx then
        SSRCore.esx = exports["es_extended"]:getSharedObject()
    end

    return SSRCore.esx
end

function SSRCore.resetPlayerState()
    local ped = PlayerPedId()

    if state.crouched then
        ResetPedMovementClipset(ped, 0.25)
        state.crouched = false
    end

    if state.pointing then
        ClearPedSecondaryTask(ped)
        SetPedCurrentWeaponVisible(ped, true, true, true, true)
        SetPedConfigFlag(ped, 36, false)
        state.pointing = false
    end

    if state.handsup then
        ClearPedTasks(ped)
        state.handsup = false
    end
end
