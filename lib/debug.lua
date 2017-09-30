local debug = {
				inDev = true,
				debug = function(msg) if debug.inDev then print(msg); end end
				}
				
return debug;