--Changed to rm_run to avoid issues with calling it init, had issues with random errors due to it being called init(no other reason that I could figure out).
package.path = "/lib/?.lua;/usr/lib/?.lua;/home/lib/?.lua;./?.lua;/home/bin/lib/?.lua";

local comp = require("component");
local mT = require("moveTo");
local version = require("version");

print("Welcome to Naragath\'s Robot Miner v" .. version.major .. "." .. version.minor .. "." .. version.build);
print("Loading please wait...");
mT.setHome("rm1");
mT.returnHome();