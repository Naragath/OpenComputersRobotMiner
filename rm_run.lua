--Changed to rm_run to avoid issues with calling it init, had issues with random errors due to it being called init(no other reason that I could figure out).

local comp = require("components");
local mT = require("moveTo");
local version = require("version");

print("Welcome to Naragath\'s Robot Miner v" .. version.major .. "." .. version.minor .. "." .. version.build);
print("Loading please wait...");
