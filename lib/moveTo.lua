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
local navPoints = {};
local homePoint = {};

local function fWP(filter)
	local ret = {};
	for _,w in pairs(navPoints) do
		if filter(w) then
			table.insert(ret,w);
		end
	end
	return ret;
end

function tLen(t)
	local count = 0;
	for _ in pairs(t) do
		count = count + 1;
	end
	return count;

end

function moveTo.returnToZero(navID)
	if zeroNav.firstRun then
		navPoints = nav.findWaypoints(40);
		print(tLen(navPoints));
		homePoint = fWP(function(w) return w.label == navID end);
		zeroNav.firstRun = false;
		print("Found homepoint...");
	end
end

function moveTo.moveC(chunkX,chunkY)
  print("Moving...");
end

return moveTo;