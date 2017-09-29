--Move to library
--Created by Brad "Naragath" Jewell
--Copyright © 2017, Brad "Naragath" Jewell, All Rights Reserved

--You may modify this file as long as you don't claim this to be your own work and give me credit.

local robot = require("robot");
local comp = require("component");
local nav = comp.navigation;
local zeroNav = {
					firstRun = true,
					data = {}
				};

local moveTo = {};

function moveTo.returnToZero(nav)
	if zeroNav.firstRun then
		local navPoints = nav.findWaypoints(256);
		for i,n in pairs(navPoints) do
			if n.label == nav then
				zeroNav = n;
				print("Found the navPoint, moving to it now...");
			end
		end
	end
end

function moveTo.moveC(chunkX,chunkY)
  print("Moving...");
end

return moveTo;