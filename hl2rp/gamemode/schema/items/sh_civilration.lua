ITEM.name = "Civil Workers' Ration"
ITEM.desc = "A package containing food and water."
ITEM.model = Model("models/weapons/w_package.mdl")
ITEM.functions = {}
ITEM.functions.Open = {
	run = function(itemTable, client, data)
		if (CLIENT) then return end
		if (faction == FACTION_CIVILWORKER) then
		{
			local odds = math.random(1, 100)

			if (odds >= 1) then
				client:UpdateInv("water_sparkling", 1, nil, true)
			end

			client:UpdateInv("food_supplement_large", 1, nil, true)
			client:GiveMoney(math.random(30, 60))
			client:EmitSound("physics/flesh/flesh_impact_hard"..math.random(1, 5)..".wav")
			end,
			icon = "icon16/arrow_out.png"
		}
		else
			nut.util.Notify("You are not a Civil Worker!", client)
		end
}