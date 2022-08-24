--[[
--Created Date: Tuesday August 23rd 2022
--Author: JustGod
--Made with ❤
-------
--Last Modified: Tuesday August 23rd 2022 8:38:01 pm
-------
--Copyright (c) 2022 JustGodWork, All Rights Reserved.
--This file is part of JustGodWork project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
-------
--]]

fx_version "cerulean"
game "gta5"

author "JustGod"
github "https://github.com/JustGodWork"
description "SafeZone system using jLib"

shared_scripts {
    "Config.lua",
    "@jLib/lang.lua",
    "@jLib/import.lua",
    "locales/*.lua"
}

server_scripts {
    "server/main.lua"
}

client_scripts {
    "client/main.lua"
}

dependencies {
    "es_extended",
    "jLib"
}