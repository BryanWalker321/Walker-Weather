local weatherTypes = {
    "EXTRASUNNY",
    "CLEAR",
    "NEUTRAL",
    "SMOG",
    "FOGGY",
    "OVERCAST",
    "CLOUDS",
    "CLEARING",
    "RAIN",
    "THUNDER",
    "SNOW",       -- Requires blackout
    "BLIZZARD",   -- Requires blackout
    "SNOWLIGHT",
    "XMAS",       -- Requires blackout
    "HALLOWEEN"   -- Requires blackout
}

-- Comment this notify section if you don't want to notify all players when an admin manually triggers the script
local function notifyAllPlayers(message, type)
    TriggerClientEvent('QBCore:Notify', -1, message, type)
end
-- end of notify sectuon

-- Function to set the initial state
local function initializeWeatherAndTime()
    print("^2Walker-Weather ^7by ^1Bryan Walker ^7v^41^7.^40^7.^40")
    print("[Walker-Weather] Setting initial weather and time...")
    exports["qb-weathersync"]:setWeather("CLEAR")
    exports["qb-weathersync"]:setTime(8, 0) -- 8:00 AM
    exports["qb-weathersync"]:setBlackout(false)
    notifyAllPlayers("The weather is now clear, and the time is set to 8:00 AM.", "success")
    print("[Walker-Weather] Weather set to CLEAR, time set to 8:00 AM, and blackout disabled.")
end

-- Function to randomly set weather and handle blackout
local function setRandomWeather()
    local randomWeather = weatherTypes[math.random(#weatherTypes)]
    print("[Walker-Weather] Changing weather to: " .. randomWeather)

    exports["qb-weathersync"]:setWeather(randomWeather)

    -- Enable blackout for specific weather types
    if randomWeather == "SNOW" or randomWeather == "BLIZZARD" or randomWeather == "XMAS" or randomWeather == "HALLOWEEN" then
        exports["qb-weathersync"]:setBlackout(true)
        notifyAllPlayers("A blackout has occurred due to severe weather: " .. randomWeather, "error")
        print("[Walker-Weather] Blackout enabled due to weather: " .. randomWeather)
    else
        -- Notify players if blackout ends
        if exports["qb-weathersync"]:getBlackoutState() then
            notifyAllPlayers("The blackout has ended as the weather has cleared.", "success")
        end
        exports["qb-weathersync"]:setBlackout(false)
        print("[Walker-Weather] Blackout disabled.")
    end
end

-- Function to check server time and trigger weather changes at specific times
local function checkTimeForWeatherChange()
    CreateThread(function()
        while true do
            Wait(1000) -- Check every second
            local hour, minute = os.date("!%H"), os.date("!%M") -- Get server time in GMT

            -- Trigger weather change at 7 or 27 minutes past the hour (this can be changed to suit your own server)
            if minute == "07" or minute == "27" then
                print("[Walker-Weather] Triggering weather change at " .. hour .. ":" .. minute) -- prints confirmation into the console
                setRandomWeather()
                Wait(60000) -- Prevent retriggering within the same minute
            end
        end
    end)
end

-- Event handler for resource start
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        initializeWeatherAndTime()
        checkTimeForWeatherChange() -- Start checking for weather change times
    end
end)

-- Command to manually trigger random weather
RegisterCommand("weathertrig", function(source, args, rawCommand)
    if source > 0 then
        -- Notify the admin who triggered it
        TriggerClientEvent('QBCore:Notify', source, "Manually triggering a random weather change...", "primary")
    end
    setRandomWeather()
end, true) -- 'true' indicates only admins can use this command, change to false if you want all players to be able use it
