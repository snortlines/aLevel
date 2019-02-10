--[[------------------------------------------------------------------------------
 *  Copyright (C) Fluffy(76561197976769128 - STEAM_0:0:8251700) - All Rights Reserved
 *  Unauthorized copying of this file, via any medium is strictly prohibited
 *  Proprietary and confidential
--]]------------------------------------------------------------------------------

aLevel.PLAYER = FindMetaTable("Player");

---
--- GetCurrentPath
---
function aLevel.GetCurrentPath()
    return debug.getinfo(2).short_src;
end

-- Used Colors.
aLevel.White          = Color(255, 255, 255, 255);
aLevel.WhiteIsh       = Color(200, 200, 200, 200);
aLevel.LessWhite      = Color(100, 100, 100, 100);
aLevel.DarkBlue       = Color(54, 56, 68, 255);
aLevel.Black          = Color(0, 0, 0, 255);
aLevel.Yellow         = Color(200, 200, 35, 255);