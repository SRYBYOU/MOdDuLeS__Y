local BU = {
  Developerlist = {
    ["Youssef_14444888"] = true
  },

  VIPMembers = {
    "Youssef_14444888"
  },

  PremiumMembers = {
    "Youssef_14444888"
  },

  Ranks = {
    ["Youssef_14444888"] = "Dev",
    ["SDRO10P"] = "Distinct",
    ["Fahad_1161"] = "Distinct"
  }
}

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
