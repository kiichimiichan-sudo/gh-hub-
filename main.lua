if _G.ghHubLoaded then
    pcall(function() _G.ghHubLoaded() end)
end
_G.ghHubLoaded = function()
    for _, v in ipairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
        if v.Name == "OrionV2" or v.Name == "Orion" or v.Name == "OrionLib" then
            pcall(function() v:Destroy() end)
        end
    end
end

local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Siro-script/FtaP.90hub/refs/heads/main/Orion"))()