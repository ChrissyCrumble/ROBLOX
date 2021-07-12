-- // Only allow to be executed once
assert(not getgenv().AntiKickExecuted, "Anti Kick is already running!")

-- // Services
local Players = game:GetService("Players")

-- // Vars
local LocalPlayer = Players.LocalPlayer

-- // What to do when Kick detected
local function kickDetected(Player, Reason)
    warn("Kick attempted for: " .. Reason)
end

-- // Index hook
hookfunction(LocalPlayer.Kick, kickDetected)

-- // Namecall hook
local __namecall
__namecall = hookmetamethod(game, "__namecall", function(self, ...)
    -- // Vars
    local args = {...}
    local method = getnamecallmethod()
    
    -- // Check if kick attempt
    if (string.lower(method) == "kick") then
        -- // Alert
        kickDetected(self, args[1])
        
        -- // Cancel it
        return
    end
    
    -- // Return - so everything else that uses namecall does not break
    return __namecall(self, ...)
end)

-- // Credits
getgenv().AntiKickExecuted = true
messagebox("Loaded.\n\n\nCreated by Stefanuk12.", "Anti Kick", 0)
