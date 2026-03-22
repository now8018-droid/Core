Citizen.CreateThread(function()
    while true do
            InvalidateIdleCam()
            InvalidateVehicleIdleCam()
            Citizen.Wait(20000)
    end
end)