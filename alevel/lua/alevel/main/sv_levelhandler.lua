--[[------------------------------------------------------------------------------
 *  Copyright (C) Fluffy(76561197976769128 - STEAM_0:0:8251700) - All Rights Reserved
 *  Unauthorized copying of this file, via any medium is strictly prohibited
 *  Proprietary and confidential
--]]------------------------------------------------------------------------------

util.AddNetworkString("aLevel.ExperienceAdded");
util.AddNetworkString("aLevel.PlayerLeveledUp");

local path = aLevel.GetCurrentPath();

hook.Add("aLevel.OnPlayerLevelUp", path, function(ply)
    local level = ply:GetLevels();

    sql.Query("UPDATE aLevel SET Level = '" .. level .. "' WHERE SteamID = '" .. ply:SteamID64() .. "'");

    net.Start("aLevel.PlayerLeveledUp");
        net.WriteUInt(level, 32);
    net.Send(ply);
end);

hook.Add("aLevel.OnExperienceAdded", path, function(ply, amount)
    if ((ply.aLevel_xpCounter or 0) >= 5) then
        local xp = ply:GetExperience();

        sql.Query("UPDATE aLevel SET Experience = '" .. xp .. "' WHERE SteamID = '" .. ply:SteamID64() .. "'");
    else
        ply.aLevel_xpCounter = (ply.aLevel_xpCounter and ply.aLevel_xpCounter + 1) or 1;
    end

    net.Start("aLevel.ExperienceAdded");
        net.WriteUInt(amount, 32);
    net.Send(ply);
end);

hook.Add("aLevel.OnAbilityPointsAcquired", path, function(ply, amount)
    local points = ply:GetAbilityPoints();

    sql.Query("UPDATE aLevel SET AbilityPoints = '" .. points .. "' WHERE SteamID = '" .. ply:SteamID64() .. "'");
end);