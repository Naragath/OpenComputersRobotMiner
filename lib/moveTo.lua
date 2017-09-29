--Move to library
--Created by Brad "Naragath" Jewell
--Copyright © 2017, Brad "Naragath" Jewell, All Rights Reserved

--You may modify this file as long as you don't claim this to be your own work and give me credit.

local robot = require("robot");
local component = require("component");
--local nav = require("navigation");
--local comp = require("component");
local nav = component.navigation;

--[[
function proxyFor(name, required)
  local address = component and component.list(name)()
  if not address and required then
    error("missing component '" .. name .. "'")
  end
  return address and component.proxy(address) or nil
end

--local robot = proxyFor("robot",true);
local nav = proxyFor("navigation",true);
]]



local zeroNav = {
					firstRun = true,
					data = {}
				};

local moveTo = {};

function moveTo.returnToZero(navID)
	if zeroNav.firstRun then
		local navPoints = nav.findWaypoints(40);
		for i,n in pairs(navPoints) do
			for nv,nz in pairs(n) do
				print(nz.label);
			end
		print(tostring(n));
			--[[
			if n.label == navID then
				zeroNav.data = n;
				zeroNav.firstRun = false;
				print("Found the navPoint, moving to it now...");
			end
			]]
		end
	end
end

function moveTo.moveC(chunkX,chunkY)
  print("Moving...");
end

return moveTo;