--[[------------------------------------------------------------------------------
 *  Copyright (C) Fluffy(76561197976769128 - STEAM_0:0:8251700) - All Rights Reserved
 *  Unauthorized copying of this file, via any medium is strictly prohibited
 *  Proprietary and confidential
--]]------------------------------------------------------------------------------

local SQL = {};
local path = aLevel.GetCurrentPath();

---
--- CreateTables
---
function SQL:CreateTables()
    if (not sql.TableExists("aLevel")) then
        if (sql.Query([[CREATE TABLE aLevel (
            ID INTEGER PRIMARY KEY AUTOINCREMENT,
            SteamID VARCHAR(17),
            Experience INTEGER,
            Level INTEGER,
            AbilityPoints,
            Talents TEXT,
            Unique(SteamID)
        );]]) == false) then
            aLevel.Debug("SQL Error: %s", sql.LastError());
        else
            aLevel.Debug("Successfully created sql table: aLevel");
        end
    end
end

---
--- FormatSQL
---
function SQL:FormatSQL(formatString, ...)
	local repacked 	= {};
	local args		= {...};
	
	for _, arg in ipairs(args) do 
		table.insert(repacked, sql.SQLStr(arg, true));
	end

	return string.format(formatString, unpack(repacked));
end

hook.Add("Initialize", path, function()
    SQL:CreateTables();
end);

hook.Add("PlayerInitialSpawn", path, function(ply)
    if (not IsValid(ply) or ply:IsBot()) then
        return;
    end

    local query = sql.Query(SQL:FormatSQL([[INSERT OR IGNORE INTO aLevel (SteamID, Experience, Level, AbilityPoints, Talents) VALUES('%s', '0', '1', '0', '[]')]], ply:SteamID64()));
    if (query == false) then
        aLevel.Debug("SQL Error at sv_data[56]: %s", sql.LastError());

        return;
    end

    --- Set the players level and experience after doing the sql query above.
    local query = sql.Query("SELECT Experience, Level, AbilityPoints FROM aLevel WHERE SteamID = '" .. ply:SteamID64() .. "'");
    if (query == false) then
        aLevel.Debug("SQL Error at sv_data[64]: %s", sql.LastError());

        return;
    end

    local xp = tonumber(query[1]["Experience"]);
    local level = tonumber(query[1]["Level"]);
    local ability = tonumber(query[1]["AbilityPoints"]);
    
    timer.Simple(2, function()
        if (IsValid(ply)) then
            ply:SetPrivateInt("experience", xp);
            ply:SetPrivateInt("level", level);
            ply:SetPrivateInt("ability_points", ability);
        end
    end);
end);

---
--- GetSQL
---
function aLevel.GetSQL()
    return SQL;
end