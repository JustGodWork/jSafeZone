--[[
--Created Date: Tuesday August 23rd 2022
--Author: JustGod
--Made with ❤
-------
--Last Modified: Tuesday August 23rd 2022 9:52:56 pm
-------
--Copyright (c) 2022 JustGodWork, All Rights Reserved.
--This file is part of JustGodWork project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
-------
--]]

local disabledSafeZonesKeys = {
	{ group = 2, key = 37,   message         = Lang.addEntry("no_weapon")   },
	{ group = 0, key = 24,   message         = Lang.addEntry("restricted")  },
	{ group = 0, key = 69,   message         = Lang.addEntry("restricted")  },
	{ group = 0, key = 92,   message         = Lang.addEntry("restricted")  },
	{ group = 0, key = 106,  message         = Lang.addEntry("restricted")  },
	{ group = 0, key = 168,  message         = Lang.addEntry("restricted")  },
}

---@param coords table | vector3
---@param radius number
jSafeZone.add = function(coords, radius)
    local safeZone = {
        x = coords.x,
        y = coords.y,
        z = coords.z,
        radius = radius,
    }
    table.insert(jSafeZone.safeZones, safeZone)
end

---@param coords table | vector3
jSafeZone.deleteSafeZone = function(coords)
    for i, safeZone in ipairs(jSafeZone.safeZones) do
        if safeZone.x == coords.x and safeZone.y == coords.y and safeZone.z == coords.z then
            table.remove(jSafeZone.safeZones, i)
            break
        end
    end
end

local SafeZone = Zone("SafeZone");

local isNotified = false;

SafeZone:start(function()
    SafeZone:setTimer(1000)
    for i = 1, #jSafeZone.safeZones do
        local z = jSafeZone.safeZones[i]
        SafeZone:setCoords(vector3(z.x, z.y, z.z))
        local plyPed = jLib.player.getPed()

        SafeZone:isPlayerInRadius(z.radius or 50, function()
            SafeZone:setTimer(0)
            DisablePlayerFiring(PlayerId(), true)

            local vehicles = jLib.Game.GetVehiclesInArea(z, 50)

            if #vehicles > 0 then
                for vehicle = 1, #vehicles do
                    local veh = vehicles[vehicle]
                    if not IsVehicleSeatFree(veh, -1) 
                        and IsPedAPlayer(GetPedInVehicleSeat(veh, -1)) 
                    then
                        SetEntityNoCollisionEntity(plyPed, veh, true)
                        SetEntityNoCollisionEntity(veh, plyPed, true)
                    end
                end
            end

            if not IsPauseMenuActive() then
                DisableControlAction(2, 140, true)
                for key = 1, #disabledSafeZonesKeys, 1 do
                    DisableControlAction(disabledSafeZonesKeys[key].group, disabledSafeZonesKeys[key].key, true)

                    if IsDisabledControlJustReleased(disabledSafeZonesKeys[key].group, disabledSafeZonesKeys[key].key) then
                        SetCurrentPedWeapon(plyPed, GetHashKey("WEAPON_UNARMED"), true)
                        if disabledSafeZonesKeys[key].message and not isNotified then
                            jLib.Notification.simple(disabledSafeZonesKeys[key].message, 6)
                            isNotified = true;
                            SetTimeout(1000, function()
                                isNotified = false;
                            end)
                        end
                    end
                end
            end
        end, true)
        SafeZone:radiusEvents(z.radius or 50.0, function()
            NetworkSetFriendlyFireOption(false)
            SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
            jLib.Notification.simple(Lang.addEntry("enter_safezone"));
        end, function()
            NetworkSetFriendlyFireOption(true)
            jLib.Notification.simple(Lang.addEntry("leave_safezone"));
        end);
    end
end);

jLib.Events.onNet("jSafeZone:toggleZones", function(bool)
    if bool then 
        if not SafeZone:isRunning() then SafeZone:start() end
    else 
        if SafeZone:isRunning() then SafeZone:stop() end
    end
end);