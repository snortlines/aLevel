--[[------------------------------------------------------------------------------
 *  Copyright (C) Fluffy(76561197976769128 - STEAM_0:0:8251700) - All Rights Reserved
 *  Unauthorized copying of this file, via any medium is strictly prohibited
 *  Proprietary and confidential
--]]------------------------------------------------------------------------------

local mat = Material("pp/blurscreen");

---
--- SetPrivateInt
---
function aLevel.PLAYER:SetPrivateInt(identifier, integer)
    if (not IsValid(self)) then
        return false;
    end

    self[identifier] = integer;
end

---
--- IsDoubleDigit
---
function aLevel.IsDoubleDigit(digit)
    return digit >= 10 and digit <= 99;
end

---
--- DrawSimpleTextOutlined
---
function aLevel.DrawTextOutlined(str, font, posx, posy, clr, clr2, tpos1)
    draw.DrawText(str, font, posx + 2, posy + 1, clr2, tpos1);
    draw.DrawText(str, font, posx, posy, clr, tpos1);
end

---
--- DrawPanelBlur
---
function aLevel:DrawPanelBlur(panel, blur)
    local blur = (blur or 5);
    local sw = ScrW();
    local sh = ScrH();

    local x, y = panel:LocalToScreen(0, 0);
    local w, h = panel:GetSize();

    surface.SetDrawColor(0, 0, 0, 255);
    surface.SetMaterial(mat);

    local perX, perY = x / sw, y / sh;
    local perW, perH = (x + w) / sw, (y + h) / sh;

    for i = 1, blur do
        mat:SetFloat("$blur", i);
        mat:Recompute();

        render.UpdateScreenEffectTexture();
        surface.DrawTexturedRectUV(0, 0, w, h, perX, perY, perW, perH);
    end
end


net.Receive("aLevel.SetPrivateInt", function()
    LocalPlayer():SetPrivateInt(net.ReadString(), net.ReadUInt(32));
end);