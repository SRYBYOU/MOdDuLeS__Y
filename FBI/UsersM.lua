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

  Owners = {},
  AdminsMembers = {},
  VIPMembers = {},
  VIPTGIDs = {},

  PremiumMembers = {
    ["Hdjsisjsbsv"] = {
        expirationDate = os.time{year = 2025, month = 6, day = 10}
    }
  },

  PremiumTGIDs = {
    "5541578106"
  },

  DistinctMembers = {}, 

  Ranks = {
    ["Youssef_14444888"] = "Dev",
    ["SDRO10P"] = "Distinct",
    ["Fahad_1161"] = "Distinct", 
    ["Hdjsisjsbsv"] = "Distinct"
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
  local currentRank = BU.Ranks[name]
  local currentPriority = priority[currentRank] or 0
  local premiumPriority = priority["Premium"]

  if data.expirationDate and os.time() < data.expirationDate then
    
    if premiumPriority > currentPriority then
      if not BU.PreviousRanks[name] then
        BU.PreviousRanks[name] = currentRank
      end
      BU.Ranks[name] = "Premium"
    end
  elseif currentRank == "Premium" then
    
    if BU.PreviousRanks[name] then
      BU.Ranks[name] = BU.PreviousRanks[name]
    else
      BU.Ranks[name] = nil
    end
    BU.PreviousRanks[name] = nil
  end
end

return BU
