ITEM.name = "Rebel Outfit"
ITEM.desc = "A combination of metropolice uniform and other pieces of fabric."
ITEM.model = Model("models/humans/group03/male_04.mdl")
ITEM.replacement = {"group(%d+)", "group03"}
ITEM.price = 50
ITEM.flag = "v"
ITEM.weight = -2.5
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