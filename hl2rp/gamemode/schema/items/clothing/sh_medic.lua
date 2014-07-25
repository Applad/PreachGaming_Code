ITEM.name = "Rebel Medic Outfit"
ITEM.desc = "A medical variant of the rebel outfit."
ITEM.model = Model("models/humans/group03m/male_04.mdl")
ITEM.replacement = {"group(%d+)", "group03m"}
ITEM.flag = "v"
ITEM.price = 75
ITEM.weight = -3
ITEM.data = {
  Armor = 25
}
ITEM.functions = {}
ITEM.functions.Wear = {
  run = function(client)
    if (SERVER) then
      client:SetArmor(data.Armor)
    end
}