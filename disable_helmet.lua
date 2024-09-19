-- disable_helmet.lua

local previousVehicle = 0

-- Function to disable helmet when on a bike
local function disableHelmetIfOnBike()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if vehicle ~= 0 and IsThisModelABike(GetEntityModel(vehicle)) then
        SetPedConfigFlag(playerPed, 35, true) -- Disable auto helmet
    else
        SetPedConfigFlag(playerPed, 35, false) -- Enable helmet if not on a bike
    end
end

-- Event to detect when the player enters a vehicle
CreateThread(function()
    while true do
        Wait(500) -- Only check twice per second to save resources

        local playerPed = PlayerPedId()
        local currentVehicle = GetVehiclePedIsIn(playerPed, false)

        -- Only check if the player has entered or exited a vehicle
        if currentVehicle ~= previousVehicle then
            previousVehicle = currentVehicle

            -- Call function to disable helmet if needed
            disableHelmetIfOnBike()
        end
    end
end)

