-- Localize the plugin table so commands can use it.
local PLUGIN = PLUGIN

nut.command.Register({
	onRun = function(client, arguments)
		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector() * 84
			data.filter = client
		local trace = util.TraceLine(data)
		local entity = trace.Entity

		if (IsValid(entity) and PLUGIN:IsDoor(entity) and !entity:GetNetVar("hidden")) then
			if (entity:GetNetVar("unownable")) then
				nut.util.Notify("This door can not be owned.", client)

				return
			end

			local cost = nut.config.doorCost

			if (!client:CanAfford(cost)) then
				nut.util.Notify(nut.lang.Get("no_afford"), client)

				return
			end

			if (!PLUGIN:IsDoorOwned(entity)) then
				entity:SetNetVar("owner", client)
				entity:SetNetVar("title", "Owned Door")

				nut.util.Notify("You now own this door.", client)
			else
				nut.util.Notify("This door is already owned.", client)
			end
		else
			nut.util.Notify("You are not looking at a valid door.", client)
		end
	end
}, "doorbuy")

nut.command.Register({
	onRun = function(client, arguments)
		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector() * 84
			data.filter = client
		local trace = util.TraceLine(data)
		local entity = trace.Entity

		if (IsValid(entity) and PLUGIN:IsDoor(entity) and !entity:GetNetVar("hidden")) then
			if (PLUGIN:GetOwner(entity) == client) then
				entity:SetNetVar("owner", NULL)
				entity:SetNetVar("title", "Door for Sale")

				local amount = nut.config.doorSellAmount

				nut.util.Notify("You unowned this door.", client)
			else
				nut.util.Notify("You do not own this door.", client)
			end
		else
			nut.util.Notify("You are not looking at a valid door.", client)
		end
	end
}, "doorsell")

nut.command.Register({
	onRun = function(client, arguments)
		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector() * 84
			data.filter = client
		local trace = util.TraceLine(data)
		local entity = trace.Entity
		local title = "Owned Door"

		if (#arguments > 0) then
			title = table.concat(arguments, " ")
		end
		
		if (IsValid(entity) and PLUGIN:IsDoor(entity)) then
			if (PLUGIN:GetOwner(entity) == client) then
				entity:SetNetVar("title", title)

				nut.util.Notify("You have changed the door's title.", client)
			else
				nut.util.Notify("You do not own this door.", client)
			end
		else
			nut.util.Notify("You are not looking at a valid door.", client)
		end
	end
}, "doortitle")

nut.command.Register({
	adminOnly = true,
	onRun = function(client, arguments)
		local trace = client:GetEyeTraceNoCursor()
		local entity = trace.Entity

		if (IsValid(entity) and PLUGIN:IsDoor(entity)) then
			local title = "Unownable Door"

			if (#arguments > 0) then
				title = table.concat(arguments, " ")
			end

			entity:SetNetVar("title", title)
			PLUGIN:DoorSetUnownable(entity)
			nut.util.Notify("You have added an unownable door.", client)
		else
			nut.util.Notify("You are not looking at a valid door.", client)
		end
	end
}, "doorsetunownable")

nut.command.Register({
	adminOnly = true,
	onRun = function(client, arguments)
		local trace = client:GetEyeTraceNoCursor()
		local entity = trace.Entity

		if (IsValid(entity) and entity:IsDoor()) then
			local hidden = util.tobool(arguments[1])

			PLUGIN:DoorSetHidden(entity, hidden)
			nut.util.Notify("You have made this door "..(hidden and "hidden" or "unhidden")..".", client)
		else
			nut.util.Notify("You are not looking at a valid door.", client)
		end
	end
}, "doorsethidden")

nut.command.Register({
	adminOnly = true,
	onRun = function(client, arguments)
		local trace = client:GetEyeTraceNoCursor()
		local entity = trace.Entity

		if (IsValid(entity) and PLUGIN:IsDoor(entity)) then
			entity:SetNetVar("title", #arguments > 0 and table.concat(arguments, " ") or "Door for Sale")
			PLUGIN:DoorSetOwnable(entity)
			nut.util.Notify("You have made this door ownable.", client)
		else
			nut.util.Notify("You are not looking at a valid door.", client)
		end
	end
}, "doorsetownable")

nut.command.Register({
	adminOnly = true,
	onRun = function(client, arguments)
		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector() * 84
			data.filter = client
		local trace = util.TraceLine(data)
		local entity = trace.Entity

		if (IsValid(entity) and PLUGIN:IsDoor(entity)) then
			PLUGIN:LockDoor(entity)
			nut.util.Notify("Door locked.", client)
		else
			nut.util.Notify("You are not looking at a valid door.", client)
		end
	end
}, "doorlock")

nut.command.Register({
	adminOnly = true,
	onRun = function(client, arguments)
		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector() * 84
			data.filter = client
		local trace = util.TraceLine(data)
		local entity = trace.Entity

		if (IsValid(entity) and PLUGIN:IsDoor(entity)) then
			PLUGIN:UnlockDoor(entity)
			nut.util.Notify("Door unlocked.", client)
		else
			nut.util.Notify("You are not looking at a valid door.", client)
		end
	end
}, "doorunlock")
