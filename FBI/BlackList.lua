local Players = game:GetService("Players")
local PermanentBand = nil

local blacklist = {
    [7639808387] = {
        message = "You are permanently banned. Contact us via Telegram",
        expiration = PermanentBand
    },
    [7837080873] = {
        message = "You are permanently banned. Contact us via Telegram",
        expiration = PermanentBand
    },
    [5416068413] = {
        message = "You are permanently banned. Contact us via Telegram",
        expiration = PermanentBand
    },
    [3227272858] = {
        message = "You are permanently banned. Contact us via Telegram",
        expiration = PermanentBand
    },
    [4474298399] = {
        message = "You are permanently banned. Contact us via Telegram",
        expiration = PermanentBand
    },
    [7903982191] = {
        message = "You are permanently banned. Contact us via Telegram",
        expiration = PermanentBand
    },
    [7945902429] = {
        message = "You are permanently banned. Contact us via Telegram",
        expiration = PermanentBand
    },
    [3021383877] = {
        message = "You are permanently banned. Contact us via Telegram",
        expiration = PermanentBand
    },
    [7990357915] = {
        message = "You are permanently banned. Contact us via Telegram",
        expiration = PermanentBand
    },
    [8317463544] = {
        message = "You are permanently banned. Contact us via Telegram",
        expiration = PermanentBand
    },
    [4352257349] = {
        message = "You are permanently banned. Contact us via Telegram",
        expiration = PermanentBand
    },
    [7766369589] = {
        message = "You are permanently banned. Contact us via Telegram",
        expiration = PermanentBand
    },
    [2019090458] = {
        message = "You are permanently banned. Contact us via Telegram",
        expiration = PermanentBand
    },
    [8357013756] = {
        message = "You are permanently banned. Contact us via Telegram",
        expiration = PermanentBand
    },
    [7881771359] = {
        message = "You are permanently banned. Contact us via Telegram",
        expiration = PermanentBand
    },
    [000] = {
        message = "You are temporarily banned",
        expiration = os.time{year = 2025, month = 5, day = 1, hour = 10, min = 0, sec = 0} 
    }
}

local now = os.time()

for userId, data in pairs(blacklist) do
    if data.expiration and now >= data.expiration then
        blacklist[userId] = nil
    end
end

for _, player in ipairs(Players:GetPlayers()) do
    local data = blacklist[player.UserId]
    if data then
        if data.expiration == nil then
            player:Kick(data.message)
            wait(10)
            game:Shutdown()
        elseif now < data.expiration then
            local remaining = math.floor((data.expiration - now) / 60)
            local expirationDate = os.date("%Y-%m-%d %H:%M:%S", data.expiration)
            local msg = string.format("%s | Time left: %d minutes | Expiration Date: %s", data.message, remaining, expirationDate)
            player:Kick(msg)
            wait(10)
            game:Shutdown()
        end
    end
end
