--[[------------------------------------------------------------------------------
 *  Copyright (C) Fluffy(76561197976769128 - STEAM_0:0:8251700) - All Rights Reserved
 *  Unauthorized copying of this file, via any medium is strictly prohibited
 *  Proprietary and confidential
--]]------------------------------------------------------------------------------

---
--- AddExperience
---
function aLevel.PLAYER:AddExperience(amount)
    local currentExperience = self:GetExperience();
    local neededExperience = self:GetNeededExperience();

    amount = amount * (aLevel.VIPModifierGroup[self:GetUserGroup()] and aLevel.VIPModifier or 1);

    if (currentExperience + amount >= neededExperience) then
        self:AddLevels(1);
    else
        self:SetPrivateInt("experience", currentExperience + amount);
    end

    hook.Run("aLevel.OnExperienceAdded", self, amount);

    return true;
end

---
--- AddLevels
---
function aLevel.PLAYER:AddLevels(amount)
    if (self:GetLevels() >= aLevel.MaxLevel) then
        return false;
    end

    self:SetPrivateInt("level", self:GetLevels() + amount);
    self:SetPrivateInt("experience", 0);

    --- Give the user a ability point when he levels up.
    self:AddAbilityPoints(amount);

    hook.Run("aLevel.OnPlayerLevelUp", self, amount);
end

---
--- AddAbilityPoints
---
function aLevel.PLAYER:AddAbilityPoints(amount)
    self:SetPrivateInt("ability_points", self:GetAbilityPoints() + amount);

    hook.Run("aLevel.OnAbilityPointsAcquired", self, amount);
end