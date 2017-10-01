--Move to library
--Created by Brad "Naragath" Jewell
--Copyright © 2017, Brad "Naragath" Jewell, All Rights Reserved

--You may modify this file as long as you don't claim this to be your own work and give me credit.

--[[
	TODO(General, not limited to this library): As of version 0.0.40
		-Add comms with controller server || Partially done, need to add more
		-Add dig commands
		-Add movement controls(basic)
		-Add terrain navigation(to destination, wether homebase or target chunk for mining)
		-Add power commands(generator usage, charger finder)
		-Add general update code || Partially done, need to add an end of update signaler and autorun
		-Add inventory control(tool usage and empty what is mined, use coal for fuel)
		-Add crafting controls(to replace picks, compact various items[eg. redstone dust->redstone blocks, coal -> coal blocks])
		-Add GUI to server program
		-Add browser controls
		-Add no Navigation methods(so we can use lower tier robots)
		-Cleanup code
		-Create documentation

]]



local robot = require("robot");
local component = require("component");
local sides = require("sides");
local dev = require("Ndebug");
local nav = component.navigation;


local moveTo = {
				hasHome = false,
				homePoint = {},
				currentFacing = 3,  --Default is south, may change this later
				position = {
							x=0,
							y=0,
							z=0
							},
				tPosition = {
							x=0,
							y=0,
							z=0
							}
				};
local navPoints = {};
local range = 200;

function _debug(msg) --Simple debugging while developing, simply prints to the string if inDev is true
	dev.debug(msg);
end

local function fWP(filter)  --Filter waypoints by a filter(a function returning true or false)
	local ret = {};
	for _,w in ipairs(navPoints) do
		if filter(w) then
			_debug("Found a match!");
			_debug("Position X: " .. w.position[1]);
			table.insert(ret,w);
		end
	end
	return ret;
end

function moveTo.updateWaypoints()  --Get all the waypoints within range(mainly only need this to get the home waypoint or later charging stations).
	navPoints = nav.findWaypoints(range);
end

function tLen(t)  --Simple table counting function since table.getn() doesn't work in opencomputers(implemented in a later version of LUA?)
	local count = 0;
	for _ in pairs(t) do
		count = count + 1;
	end
	return count;

end

function moveTo.noNav()  --Should only call if there is no navigation component, later will assume there where the robot is put down is the corner of chunk 0(so we can use it on lower tier robots)
	_debug("ERROR: There is no navigation upgrade in this robot, Naragath\'s robot miner cannot work properly without it...");
end

function moveTo.setHome(navID)  --Make sure to call this before returnHome so that it knows where "home" is at(used to calculate where each chunk available for mining is at at).
		moveTo.updateWaypoints();
		table.insert(moveTo.homePoint,fWP(function(w) return w.label == naveID; end));
		--moveTo.homePoint = fWP(function(w) return w.label == navID; end);
		if next(moveTo.homePoint) == nil then
			moveTo.hasHome = false;
		else
			moveTo.hasHome = true;
		end
end

function moveTo.returnHome()  --Useful to get the robot to go to a spot that the player can easily get to(assuming they don't have or want to use flight)
			if not moveTo.hasHome then
				_debug("Home waypoint has not been set, did it get removed?");
			else
				_debug("Doing some nav stuffz.");
				_debug(type(moveTo.homePoint) .. " homePoint type...");
				for _,hy in pairs(moveTo.homePoint[1]) do
					for hhx,hhy in pairs(hy) do
						_debug(hhx .. ": hhx");
						_debug(hhy .. ": hhy");
					end
				end
				_debug(type(moveTo.homePoint.position) .. " homePoint.position type...");
				moveTo.moveTo(moveTo.homePoint.position);
			end
end

function moveTo.moveTick()  --Without nav we'll have to assume that the first way it's set down is north(or south?), perhaps expose a way for the user to set it in the browser setup?
		if moveTo.tPosition.x - moveTo.position.x > 0 then
			moveTo.currentFacing = nav.getFacing();
			if moveTo.currentFacing == sides.east then
				local success, why = robot.forward();
				if success == nil then
					_debug(why);
				end
			elseif moveTo.currentFacing == sides.north or sides.west then
				robot.turnRight();
			else
				robot.turnLeft();
			end
		else
			
		end
end

function moveTo.moveTo(ax,ay,az)  --Sets where the robot is going to move to, DOES NOT DO ANY MOVEMENT, that is handled in moveTick().
	if type(ax) == "table" then
		_debug("Found a table...");
		ay = ax[2];
		az = ax[3];
		ax = ax[1];  --Make sure to assign x last or else y and z can't be assigned(as x will no longer be a table).
	end
	_debug(type(ax));
	moveTo.tPosition.x = ax;
	moveTo.tPosition.y = ay;
	moveTo.tPosition.z = az;
	_debug("Moving to " .. tostring(ax) .. "," .. tostring(ay) .. "," .. tostring(az) .. ".");
end

function moveTo.moveC(chunkX,chunkY)  --Move to specific chunk(THIS IS NOT X,Y POSITION IN THE WORLD.  This is x,y chunk based on where the starting point is)[eg. 5,4 is 5 chunks to the right, 4 chunks forward
  _debug("Moving...");
  
end

return moveTo;