--[[------------------------------------------------------------------------------
 *  Copyright (C) Fluffy(76561197976769128 - STEAM_0:0:8251700) - All Rights Reserved
 *  Unauthorized copying of this file, via any medium is strictly prohibited
 *  Proprietary and confidential
--]]------------------------------------------------------------------------------

local mat = Material;
local path = "alevel/";
local current = aLevel.GetCurrentPath();
local materials = {
    {
        name = "aMatShield",
        material = mat(path .. "shield.png", "noclamp smooth")
    },

    {
        name = "aMatBar",
        material = mat(path .. "level_bar.png", "noclamp smooth")
    },

    {
        name = "aMatCross",
        material = mat(path .. "x.png", "noclamp smooth")
    }
};

hook.Add("InitPostEntity", current, function()
    for k, v in ipairs(materials) do
        _G[v.name] = v.material;
    end
end);