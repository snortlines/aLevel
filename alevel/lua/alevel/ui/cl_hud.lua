--[[------------------------------------------------------------------------------
 *  Copyright (C) Fluffy(76561197976769128 - STEAM_0:0:8251700) - All Rights Reserved
 *  Unauthorized copying of this file, via any medium is strictly prohibited
 *  Proprietary and confidential
--]]------------------------------------------------------------------------------

local path = aLevel.GetCurrentPath();
local w, h = ScrW(), ScrH();
local xp = 0;
local ply;
local xpString = "";
local bAlpha = 0;
local tAlpha = 0;
local bFade = CurTime();
local tFade = CurTime();
local animationFade = CurTime();
local animationAlpha = 0;
local level = 0;
local xpReceived = 0;

local function doLevelUpAnimation()
    if (animationFade <= CurTime()) then
        animationAlpha = math.Approach(animationAlpha, 0, 2);
    else
        animationAlpha = math.Approach(animationAlpha, 255, 2);
    end

    local clr = ColorAlpha(aLevel.Yellow, animationAlpha);
    local clr2 = ColorAlpha(aLevel.Black, animationAlpha);
    local white = ColorAlpha(aLevel.White, animationAlpha)

    aLevel.DrawTextOutlined("LEVEL UP", "aLevel.62", (w / 2) + 21, 100, clr, clr2, TEXT_ALIGN_CENTER);

    surface.SetDrawColor(white);
    surface.DrawRect((w / 2) - 225, 193, 150, 1)
    surface.DrawRect((w / 2) + 120, 193, 150, 1)

    aLevel.DrawTextOutlined("Level " .. level, "aLevel.36", (w / 2) + 21, 175, white, clr2, TEXT_ALIGN_CENTER);
    aLevel.DrawTextOutlined("1 Ability Point", "aLevel.42", (w / 2) + 21, 225, clr, clr2, TEXT_ALIGN_CENTER);
    aLevel.DrawTextOutlined("Health and Damage increased", "aLevel.36", (w / 2) + 21, 275, white, clr2, TEXT_ALIGN_CENTER);
end

hook.Add("HUDPaint", path, function()
    ply = ply and IsValid(ply) and ply or LocalPlayer();

    if (not IsValid(ply)) then
        return;
    end

    surface.SetDrawColor(0, 0, 0, 200);
    surface.SetMaterial(aMatShield);
    surface.DrawTexturedRect(w - 101, 49, 44, 44);

    surface.SetDrawColor(255, 255, 255);
    surface.SetMaterial(aMatShield);
    surface.DrawTexturedRect(w - 100, 50, 42, 42);

    surface.SetDrawColor(250, 250, 255, bAlpha);
    surface.DrawOutlinedRect(w - 380, 50 + (15 / 2), 260, 15)

    surface.SetDrawColor(0, 0, 0, bAlpha - 105);
    surface.DrawOutlinedRect(w - 381, 49 + (15 / 2), 262, 17)

    local needed = ply:GetNeededExperience();
    local experience = ply:GetExperience();
    xp = math.min(needed, (xp == experience and xp) or Lerp(0.1, xp, experience));

    local ratio = math.Min(xp / needed, 1);
    surface.SetDrawColor(255, 255, 255, bAlpha);
    surface.SetMaterial(aMatBar);
    surface.DrawTexturedRect(w - 379, 51 + (15 / 2), 260 * ratio, 13)

    local levels = ply:GetLevels();
    aLevel.DrawTextOutlined(levels, "aLevel.20", w - 80, 58, aLevel.Yellow, aLevel.Black, TEXT_ALIGN_CENTER);

    local clr = ColorAlpha(aLevel.Yellow, tAlpha);
    local clr2 = ColorAlpha(aLevel.Black, tAlpha);
    aLevel.DrawTextOutlined(xpString, "aLevel.24", w - 380, 80, clr, clr2, TEXT_ALIGN_LEFT);

    if (bFade <= CurTime()) then
        bAlpha = math.Approach(bAlpha, 0, 3);
    else
        bAlpha = math.Approach(bAlpha, 255, 3);
    end

    if (tFade <= CurTime()) then
        tAlpha = math.Approach(tAlpha, 0, 3);

        if (tAlpha <= 0) then
            xpString = "";
            xpReceived = 0;
        end
    else
        tAlpha = math.Approach(tAlpha, 255, 3);
    end

    doLevelUpAnimation();
end);

net.Receive("aLevel.ExperienceAdded", function()
    bFade = CurTime() + 20;
    tFade = CurTime() + 5;
    
    xpReceived = xpReceived + net.ReadUInt(32);
    xpString = "+" .. xpReceived;
end);

net.Receive("aLevel.PlayerLeveledUp", function()
    animationFade = CurTime() + 15;
    level = net.ReadUInt(32);

    surface.PlaySound("alevel/level_up.mp3");
end);