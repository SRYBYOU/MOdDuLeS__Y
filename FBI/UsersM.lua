return {
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

for _, member in pairs(VIPMembers) do
    if not Ranks[member] then
        Ranks[member] = "VIP"
    end
end

for _, member in pairs(PremiumMembers) do
    if not Ranks[member] then
        Ranks[member] = "Premium"
    end
end
