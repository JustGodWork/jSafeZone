--[[
--Created Date: Wednesday August 24th 2022
--Author: JustGod
--Made with ❤
-------
--Last Modified: Wednesday August 24th 2022 1:28:15 am
-------
--Copyright (c) 2022 JustGodWork, All Rights Reserved.
--This file is part of JustGodWork project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
-------
--]]

jSafeZone = {}

exports("getSafeZones", function()
    return jSafeZone
end)

Config = {
    lang = "fr"
}

function jSafeZone.getConfig()
    return Config
end

jSafeZone.safeZones = {
    { x = 218.76, y = -802.87, z = 30.09, radius = 50.0 }, -- Parking Central
    { x = 429.54, y = -981.86, z = 30.71, radius = 60.0 }, -- Police station
    { x = -38.22, y = -1100.84, z = 26.42, radius = 50.0 }, -- Car dealer
    { x = 295.68, y = -586.45, z = 43.14, radius = 60.0 }, -- Hospital
    { x = -211.34, y = -1322.06, z = 30.89, radius = 65.0 }, -- Benny's,
};