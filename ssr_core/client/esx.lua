ESX = nil

CreateThread(function()
    while not ESX do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Wait(500)
    end
end)