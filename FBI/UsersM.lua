local BU = {
  Developerlist = {
    ["Youssef_14444888"] = true, 
    ["sad_sad826"] = true, 
    ["Lord_Sudo1"] = true, 
    ["SDRO10P"] = true, 
    ["soolkodd"] = true
  },

  DeveloperslistIds = {
    [6066343600] = true,
    [8465861897] = true,
    [5324738339] = true, 
    [5620468151] = true, 
    [3553026648] = true
  }, 

  VIPMembers = {
    ""
  },

  PremiumMembers = {
    ""
  },

  Ranks = {
    ["Youssef_14444888"] = "Dev",
    ["SDRO10P"] = "Distinct",
    ["Fahad_1161"] = "Distinct"
  }
}

for name, _ in pairs(BU.Developerlist) do
    if not BU.Ranks[name] then
        BU.Ranks[name] = "Dev"
    end
end

for _, member in pairs(BU.VIPMembers) do
    if not BU.Ranks[member] then
        BU.Ranks[member] = "VIP"
    end
end

for _, member in pairs(BU.PremiumMembers) do
    if not BU.Ranks[member] then
        BU.Ranks[member] = "Premium"
    end
end

return BU
