# aLevel
A simple level / experience system for Garry's Mod. 

This is the foundation of a good leveling system, it is incomplete but that is the way it's suppose to be.
It's not supposed to contain 1000 features or have 100k lines of code, it is here to give you, the upcoming developers or intermediate developers a foundation to work off, it is functional, though.

Comes with a hud, materials, sounds, and is inspired by Assassin's Creed Odyssey.

# Usage.
It should function straight out of the box, however, there is a tiny config file you can mess with.

# Developers.
Theres a few player meta functions you can use, such as:

SHARED ->
player:GetLevels();
player:GetNeededExperience();
player:GetExperience();
player:GetAbilityPoints();
player:GetPrivateInt(identifier, default);

SERVER ->
player:AddExperience(amount);
player:AddLevels(amount);
player:AddAbilityPoints(amount);

CLIENT ->
player:SetPrivateInt(identifier, integer);

# Installation.
Simply drag the addon into your /addons/ folder.
