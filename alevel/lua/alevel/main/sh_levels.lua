--[[------------------------------------------------------------------------------
 *  Copyright (C) Fluffy(76561197976769128 - STEAM_0:0:8251700) - All Rights Reserved
 *  Unauthorized copying of this file, via any medium is strictly prohibited
 *  Proprietary and confidential
--]]------------------------------------------------------------------------------

---
--- GetLevels
---
function aLevel.PLAYER:GetLevels()
    return self:GetPrivateInt("level", 1);
end

---
--- GetNeededExperience
---
function aLevel.PLAYER:GetNeededExperience()
    return (self:GetLevels() * aLevel.Experience) * aLevel.Modifier;
end

---
--- GetExperience
---
function aLevel.PLAYER:GetExperience()
    return self:GetPrivateInt("experience", 0);
end

---
--- GetAbilityPoints
---
function aLevel.PLAYER:GetAbilityPoints()
    return self:GetPrivateInt("ability_points", 0);
end