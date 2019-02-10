--[[------------------------------------------------------------------------------
 *  Copyright (C) Fluffy(76561197976769128 - STEAM_0:0:8251700) - All Rights Reserved
 *  Unauthorized copying of this file, via any medium is strictly prohibited
 *  Proprietary and confidential
--]]------------------------------------------------------------------------------

local path = aLevel.GetCurrentPath();

hook.Add("OnNPCKilled", path, function(npc, killer)
    if (IsValid(npc) and IsValid(killer) and killer:IsPlayer()) then
        killer:AddExperience(10);
    end
end);

hook.Add("PlayerDeath", path, function(victim, _, attacker)
    if (IsValid(victim) and IsValid(attacker) and attacker:IsPlayer()) then
        if (victim:IsBot() and not aLevel.GetXPFromBots) then
            return;
        end
        
        if (victim == attacker) then
            return;
        end

        if (victim:LastHitGroup() == HITGROUP_HEAD) then
            attacker:AddExperience(100);
        else
            attacker:AddExperience(50);
        end
    end
end);