--[[
--Created Date: Wednesday August 24th 2022
--Author: JustGod
--Made with ❤
-------
--Last Modified: Wednesday August 24th 2022 1:48:03 am
-------
--Copyright (c) 2022 JustGodWork, All Rights Reserved.
--This file is part of JustGodWork project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
-------
--]]

RegisterCommand("togglesafezone", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not tonumber(args[1]) then 
        if xPlayer then return xPlayer.showNotification("Syntax: 'arg number: 1 / 0'") end
        return print("Syntax: <arg number: 1 / 0>")
    end
    jLib.Events.broadcast("jSafeZone:toggleZones", tonumber(args[1]) ~= 0)
end)