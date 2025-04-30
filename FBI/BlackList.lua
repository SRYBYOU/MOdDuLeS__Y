local Players = game:GetService("Players")

local blacklist = {
    [123456789] = true,  
    [987654321] = true   
}

for _, player in ipairs(Players:GetPlayers()) do
    if blacklist[player.UserId] then
        player:Kick("You have been banned from using, contact us via Telegram")
    end
end
