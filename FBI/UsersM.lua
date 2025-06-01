local BU = {
  -- for dev
  Developerlist = {
    ["Youssef_14444888"] = true, 
    ["sad_sad826"] = true, 
    ["Lord_Sudo1"] = true, 
    ["SDRO10P"] = true, 
    ["soolkodd"] = true, 
    ["Hdjsisjssv"] = true
  },

  DeveloperslistIds = {
    [6066343600] = true,
    [8465861897] = true,
    [5324738339] = true, 
    [5620468151] = true, 
    [3553026648] = true
  }, 
  -- owners
  Owners = {},
  -- amdins
  AdminsMembers = {},
  -- vip
  VIPMembers = {},
  
  VIPTGIDs = {},
  -- PM
  PremiumMembers = {
    ["Hdjsisjsbsv"] = {
        expirationDate = os.time{year = 2020, month = 6, day = 10}
    }
  }, 
  PremiumTGIDs = {
    "5541578106"
  },
  -- DIT
  DistinctMembers = {}, 
  -- rank
  Ranks = {
    ["Youssef_14444888"] = "Dev",
    ["SDRO10P"] = "Distinct",
    ["Fahad_1161"] = "Distinct", 
    ["Hdjsisjsbsv"] = "Distinct"
  },
  -- previous
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

for name, data in pairs(BU.PremiumMembers) do
    if data.expirationDate and os.time() < data.expirationDate then
        if BU.Ranks[name] and BU.Ranks[name] ~= "Premium" and not BU.PreviousRanks[name] then
            BU.PreviousRanks[name] = BU.Ranks[name]
        end
        setRank(name, "Premium")
    elseif BU.Ranks[name] == "Premium" then
        if BU.PreviousRanks[name] then
            BU.Ranks[name] = BU.PreviousRanks[name]
        else
            BU.Ranks[name] = nil
        end
        BU.PreviousRanks[name] = nil
    end
end

for name, _ in pairs(BU.DistinctMembers) do setRank(name, "Distinct") end

return BU
