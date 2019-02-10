--[[------------------------------------------------------------------------------
 *  Copyright (C) Fluffy(76561197976769128 - STEAM_0:0:8251700) - All Rights Reserved
 *  Unauthorized copying of this file, via any medium is strictly prohibited
 *  Proprietary and confidential
--]]------------------------------------------------------------------------------

util.AddNetworkString("aLevel.SetPrivateInt");

---
--- SetPrivateInt
---
function aLevel.PLAYER:SetPrivateInt(identifier, integer)
    if (not IsValid(self)) then
        return false;
    end

    self[identifier] = integer;

    net.Start("aLevel.SetPrivateInt")
        net.WriteString(identifier);
        net.WriteUInt(integer, 32);
    net.Send(self);
end