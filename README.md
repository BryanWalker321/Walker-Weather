# Walker-Weather for FiveM

**Dynamic Weather Control Script for FiveM Servers (QB-Core/QBox)**
---
An additional weather controller for QB FiveM Frameworks

## Overview
Walker-Weather is a dynamic weather management script designed specifically for FiveM servers running QB-Core or QBox frameworks. It automatically manages in-game weather conditions, introduces realistic and randomized weather cycles, and supports blackout scenarios for enhanced roleplay immersion. This script ensures that your server environment remains engaging and unpredictable.

---

## What This Script Does

- **Automatic Weather Initialization:**
  - Upon resource startup, the script sets the weather to "CLEAR" and adjusts the in-game time to 8:00 AM. It also ensures that blackout mode is disabled.

- **Randomized Weather Events:**
  - Weather types randomly cycle at specified intervals (default at 7 and 27 minutes past each hour).
  - Certain severe weather conditions like `SNOW`, `BLIZZARD`, `XMAS`, and `HALLOWEEN` trigger an automatic blackout mode, adding realism and roleplay depth.

- **Notifications:**
  - Players receive real-time notifications about weather changes and blackout conditions.

- **Admin-Controlled Manual Weather Triggering:**
  - Admins can manually trigger random weather events using the `/weathertrig` command, useful for special events or roleplay scenarios.

---

## Prerequisites
Before installing Walker-Weather, ensure your FiveM server setup meets the following prerequisites:

- [**QB-Core or QBox Framework**](https://github.com/qbcore-framework)
- [**qb-weathersync**](https://github.com/qbcore-framework/qb-weathersync)

Make sure these resources are properly installed and configured.

---

## Detailed Script Configuration

You can easily adjust the script to better suit your server needs using the provided code comments:

- **Adjust Weather Types:**
  Modify the `weatherTypes` array to include or exclude specific weather types. Remember, weather types marked `-- Requires blackout` will automatically trigger blackouts.

- **Player Notifications:**
  ```lua
  -- Comment this notify section if you don't want to notify all players when an admin manually triggers the script
  local function notifyAllPlayers(message, type)
      TriggerClientEvent('QBCore:Notify', -1, message, type)
  end
  ```
  - Comment out or remove this function to disable player notifications.

- **Weather Change Interval:**
  ```lua
  if minute == "07" or minute == "27" then
  ```
  - Modify these minute markers (`"07"`, `"27"`) to change how frequently weather updates occur.

- **Admin-Only Command:**
  ```lua
  RegisterCommand("weathertrig", function(source, args, rawCommand)
  ```
  - The boolean at the end (`true`) specifies admin-only access. Set it to `false` if you wish to allow all players to use the manual trigger command.

---

## Installation
1. Place the `walker-weather` folder in your server's resources directory.
2. Add `ensure walker-weather` to your server's configuration file (`server.cfg`).
3. Restart your FiveM server or start the resource manually.

---

## Commands
- `/weathertrig` - Manually triggers a random weather event. (Admin-only by default)

---

## Logging
- Walker-Weather logs all weather changes and blackout statuses to the server console, aiding in monitoring and debugging. This section can be commented out
if you do not wish for persistent console logging.

---

## Credits
- Developed by Bryan Walker (@superspiderman4697 on Discord)
- Utilizes the QB-Core ecosystem for seamless integration and reliability.

---

## License
Walker-Weather is open-source and released under the MIT License. You are free to modify and redistribute this script as you see fit, provided attribution is maintained.

---

For questions, suggestions, or support, please open an issue on GitHub or contact @superspiderman4697 on Discord.

