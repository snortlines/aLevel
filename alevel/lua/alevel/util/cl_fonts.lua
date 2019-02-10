--[[------------------------------------------------------------------------------
 *  Copyright (C) Fluffy(76561197976769128 - STEAM_0:0:8251700) - All Rights Reserved
 *  Unauthorized copying of this file, via any medium is strictly prohibited
 *  Proprietary and confidential
--]]------------------------------------------------------------------------------

aLevel.Fonts = {};

local prefix = "aLevel.";

---
--- fontExists
---
local function fontExists(font)
    for k, v in ipairs(aLevel.Fonts) do
        if (v.font == font) then
            return true;
        end
    end

    return false;
end

---
--- removeFont
---
local function removeFont(font)
    for k, v in ipairs(aLevel.Fonts) do
        if (v.font == font) then
            table.remove(aLevel.Fonts, k)
        end
    end

    return true;
end

---
--- createFont
---
local function createFont(name, size, weight)
    table.insert(aLevel.Fonts, {font = name, size = size});
    surface.CreateFont(name, {font = "Roboto", size = size, weight = (weight or 400)});
end

---
--- addFont
---
local function addFont(name, size, weight)
    if (fontExists(name)) then
        removeFont(name);
        createFont(name, size, weight);
    else
        createFont(name, size, weight);
    end

    return true;
end

for i = 12, 48, 2 do
    addFont(prefix .. i, i);
end

addFont(prefix .. 20, 20, 500);
addFont(prefix .. 18, 18, 300);
addFont(prefix .. 22, 22, 300);
addFont(prefix .. 62, 62, 400);