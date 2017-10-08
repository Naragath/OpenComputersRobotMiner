--Changed to rm_run to avoid issues with calling it init, had issues with random errors due to it being called init(no other reason that I could figure out).
package.path = "/lib/?.lua;/usr/lib/?.lua;/home/lib/?.lua;./?.lua;/home/bin/lib/?.lua";

local comp = require("component");
local mT = require("moveTo");
local version = require("version");
local ev = require("event");

local m = comp.modem;

print("Welcome to Naragath\'s Robot Miner v" .. version.major .. "." .. version.minor .. "." .. version.build);
print("Loading please wait...");
--mT.setHome("rm1");
--mT.returnHome();
--mT.moveC(2,0);
m.open(1337);


while true do
	local _,_,from,port,_,msg,arg1,arg2 = ev.pull("modem_message");
	if msg == "*SETHOME*" then
		mT.setHome(arg1);
	elseif msg == "*MineChunk*" then
		mT.moveC(arg1,arg2,function() updatePos(moveTo.tPosition.x,moveTo.tPosition.z); end);
	end
end

function updatePos(x,z)
	_debug("Yepp...");
end