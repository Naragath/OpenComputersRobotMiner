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

local moveTo = {
				hasHome = false,
				homePoint = {}
				};
local navPoints = {};
--local homePoint = {};
local range = 200;
--local hasHome = false;
--local homePoint;

local function fWP(filter)
	local ret = {};
	for _,w in ipairs(navPoints) do
		if filter(w) then
			print("Found a match!");
			print("Position X: " .. w.position[1]);
			table.insert(ret,w);
		end
	end
	return ret;
end

local function updateWaypoints()
	navPoints = nav.findWaypoints(range);
end

function tLen(t)
	local count = 0;
	for _ in pairs(t) do
		count = count + 1;
	end
	return count;

end

function moveTo.setHome(navID)
	self.homePoint = fWP(function(w) return w.label == navID; end);
	if next(self.homePoint) == nil then
		moveTo.hasHome = false;
	else
		moveTo.hasHome = true;
	end
end

function moveTo.returnToZero()
		if not moveTo.hasHome then
			print("Home waypoint has not been set, please select one...");
		else
			print("Doing some nav stuffz.");
		end
	--[[
	if zeroNav.firstRun then
		--navPoints = nav.findWaypoints(40);
		print(tLen(navPoints));
		homePoint = fWP(function(w) return w.label == navID; end);
		zeroNav.firstRun = false;
		print("Found homepoint...");
		print(homePoint.position[1]);
		print(homePoint.position[2]);
		print(homePoint.position[3]);
	end
	]]
end

function moveTo.moveC(chunkX,chunkY)  --Move to specific chunk(THIS IS NOT X,Y POSITION IN THE WORLD.  This is x,y chunk based on where the starting point is)[eg. 5,4 is 5 chunks to the right, 4 chunks forward
  print("Moving...");
  
end

return moveTo;