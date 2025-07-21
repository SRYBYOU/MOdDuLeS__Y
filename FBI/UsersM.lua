local BU = {
  -- for dev
  Developerlist = {
    ["Youssef_14444888"] = true,
    ["373illix"] = true, 
    ["soolkodd"] = true, 
    ["ioonj42"] = true, 
    ["Wowgoodtpsnoob"] = true
  },

  DeveloperslistIds = {
    [6066343600] = true, 
    [3553026648] = true, 
    [5547171466] = true,
    [5457522564] = true,
    [8568786319] = true
  }, 

  Owners = {},
  AdminsMembers = {},
  VIPMembers = {},
  VIPTGIDs = {},
  
  PremiumMembers = {
    ["Neymar_Ez57"] = {
        expirationDate = os.time{year = 2025, month = 6, day = 30}
    }
  }, 

  PremiumTGIDs = {
    "5541578106"
  },
  
  VIPTGIDs = {} 

  DistinctMembers = {}, 

  Ranks = {
    ["Youssef_14444888"] = "Dev",
    ["SDRO10P"] = "Dev",
    ["Fahad_1161"] = "Distinct"
  },

  PreviousRanks = {}
}

local priority = {
    ["Dev"] = 6,
    ["Owner"] = 5,
    ["Admin"] = 4,
    ["VIP"] = 3,
    ["Premium"] = 2,
    ["Distinct"] = 1
}

local function setRank(name, newRank)
    local currentRank = BU.Ranks[name]
    if not currentRank or (priority[newRank] > (priority[currentRank] or 0)) then
        BU.Ranks[name] = newRank
    end
end

for name, _ in pairs(BU.Owners) do setRank(name, "Owner") end
for name, _ in pairs(BU.AdminsMembers) do setRank(name, "Admin") end
for name, _ in pairs(BU.Developerlist) do setRank(name, "Dev") end
for name, _ in pairs(BU.VIPMembers) do setRank(name, "VIP") end
for name, _ in pairs(BU.DistinctMembers) do setRank(name, "Distinct") end

for name, data in pairs(BU.PremiumMembers) do
    if data.expirationDate and os.time() < data.expirationDate then
        if BU.Ranks[name] ~= "Premium" then
            if not BU.PreviousRanks[name] then
                BU.PreviousRanks[name] = BU.Ranks[name]
            end
            BU.Ranks[name] = "Premium"
        end
    elseif BU.Ranks[name] == "Premium" then
        if BU.PreviousRanks[name] then
            BU.Ranks[name] = BU.PreviousRanks[name]
        else
            BU.Ranks[name] = nil
        end
        BU.PreviousRanks[name] = nil
    end
end

return BU
