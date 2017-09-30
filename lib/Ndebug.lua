local Ndebug = {
				inDev = true,
				debug = function(msg) if Ndebug.inDev then print(msg); end end
				}
				
return Ndebug;