local function farmtest()
	local plr = game:GetService('Players').LocalPlayer
	local id = plr.UserId
	local RunService = game:GetService('RunService')
	local replicated_storage = game:GetService('ReplicatedStorage')
	local id_earth = 3311165597


	local function  advertencia( message )
		warn(message)
	end


	local folderData = game.ReplicatedStorage.Datas[id]
	local questRemote = replicated_storage.Package.Events.Qaction
	local punchRemote = replicated_storage.Package.Events.p
	local equipRemote = replicated_storage.Package.Events.equipskill
	local rebirthRemote = replicated_storage.Package.Events.reb
	local melee_rs = replicated_storage.Package.Events.mel

	local stats_bills_requeriment = 20000000
	local quest = {}
	local planet = ""

	local millon = 1000000
	local transformaciones = {'Kaioken', 'FSSJ', 'SSJ', 'SSJ Kaioken', 'SSJ2', 'SSJ2 Kaioken', 'LSSJ Kaioken', 'Mystic Kaioken', 'SSJ5', 'LSSJ3', 'SSJG4', 'LSSJ4', 'LSSJG', 'Super Broly', 'True God of Destruction', 'True God of Creation', 'SSJB4', 'Ultra Ego'}
	local attacks_melee = {
		{name = "God Slicer",requerido = millon * 60},
		{name = "Spirit Barrage",requerido = millon * 60},
		{name = "Super Dragon Fist",requerido = millon * 50},
		{name = "Spirit Breaking Cannon",requerido = 200000},
		{name = "Mach Kick",requerido = 90000},
		{name = "High Power Rush",requerido = 65000},
		{name = "Meteor Crash",requerido = 28000},
		{name = "Wolf Fang Fist",requerido = 2000},
	}


	local quests = {
		bills = {
			{name_quest = "Vekuta (SSJBUI)",minimo = 5500000000, name_boss = "Vekuta (SSJBUI)"},
			{name_quest = "Wukong Rose",minimo = 5000000000, name_boss = "Wukong Rose"},
			{name_quest = "Vekuta (LBSSJ4)",minimo = 4200000000, name_boss = "Vekuta (LBSSJ4)"},
			{name_quest = "Wukong (LBSSJ4)",minimo = 2700000000, name_boss = "Wukong (LBSSJ4)"},
			{name_quest = "Vegetable (LBSSJ4)",minimo = 1800000000, name_boss = "Vegetable (LBSSJ4)"},
			{name_quest = "Vis (20%)",minimo = 1000000000, name_boss = "Vis (20%)"},
			{name_quest = "Vills (50%)",minimo = 600000000, name_boss = "Vills (50%)"},
			{name_quest = "Wukong (Omen)",minimo = 300000000, name_boss = "Wukong (Omen)"},
			{name_quest = "Vegetable (GoD in-training)",minimo = 200000000, name_boss = "Vegetable (GoD)"},
		},

		earth = {
			{name_quest = "SSJG Kakata",minimo = 150000000, name_boss = "SSJG Kakata"},
			{name_quest = "Broccoli",minimo = 50000000, name_boss = "Broccoli",},
			{name_quest = "SSJB Wukong",minimo = 8000000, name_boss = "SSJB Wukong"},
			{name_quest = "Kai-fist Master",minimo = 6500000, name_boss = "Kai-fist Master"},
			{name_quest = "SSJ2 Wukong",minimo = 5000000, name_boss = "SSJ2 Wukong"},
			{name_quest = "Perfect Atom",minimo = 3500000, name_boss = "Perfect Atom"},
			{name_quest = "Chilly",minimo = 2200000, name_boss = "Chilly"},
			{name_quest = "Super Vegetable",minimo = 750000, name_boss = "Super Vegetable"},
			{name_quest = "Mapa",minimo = 200000, name_boss = "Mapa"},
			{name_quest = "Radish",minimo = 100000, name_boss = "Radish"},
			{name_quest = "Kid Nohag",minimo = 50000, name_boss = "Kid Nohag"},
			{name_quest = "Klirin",minimo = 25000, name_boss = "Klirin"},
			{name_quest = "X Fighter Trainer", minimo = 0, name_boss = "X Fighter"}
		}
	}



	local function getStrength()
		local strength = folderData.Strength.Value
		local energy = folderData.Energy.Value
		local defense = folderData.Defense.Value
		local speed = folderData.Speed.Value

		local valueMinimo = strength

		if energy < valueMinimo then
			valueMinimo = energy
		end
		if defense < valueMinimo then
			valueMinimo = defense
		end
		if speed < valueMinimo then
			valueMinimo = speed
		end

		return valueMinimo
	end


	local function block()
		local args = {[1] = true}
		game:GetService("ReplicatedStorage").Package.Events.block:InvokeServer(unpack(args))
	end

	local function charge()
		local args = {[1] = "Blacknwhite27"}
		game:GetService("ReplicatedStorage").Package.Events.cha:InvokeServer(unpack(args))
	end


	local function blocharg()
		block()
		charge()
	end


	local function getQuest()
		return game:GetService("ReplicatedStorage").Datas[id].Quest.Value
	end

	local function tp_bills_planet()
		replicated_storage.Package.Events.TP:InvokeServer("Vills Planet") -- vamos a bills planet
	end


	local function tp_earth()
		local A_1 = "Earth"
		local Event = game:GetService("ReplicatedStorage").Package.Events.TP
		Event:InvokeServer(A_1)
	end


	local function returnQuest()
		local get_value = getStrength()

		if game.PlaceId == id_earth then
			planet = 'earth'
		else
			planet = 'bills'
		end

		for _, boss in ipairs(quests[planet]) do
			if get_value > boss.minimo then
				quest = {
					quest = boss.name_quest,
					boss = boss.name_boss
				}
				advertencia('La mision seleccionada es: '..boss.name_quest)
				break
			end
		end

		if get_value >= stats_bills_requeriment and game.PlaceId == id_earth then -- vamos a bills planet
			tp_bills_planet()
		elseif get_value < stats_bills_requeriment and game.PlaceId ~= id_earth then
			while true do
				tp_earth()
				wait(2)
			end
		end
		return quest
	end


	local function transform()
		local selected_form = plr.Status.SelectedTransformation
		local transformation = plr.Status.Transformation

		while selected_form.Value ~= transformation.Value do
			game:GetService("ReplicatedStorage").Package.Events.ta:InvokeServer()
			wait(1)
		end
	end


	local function tranform_equipped()
		for i = #transformaciones, 1, -1 do
			if equipRemote:InvokeServer( transformaciones[i] ) then
				break
			end
		end
		task.wait()
		transform()
	end


	local function quest()
		local boss = returnQuest()
		local boss_quest = boss.quest -- name quest
		local enemy_name = boss.boss -- name boss

		while getQuest() ~= boss_quest do
			local succes, fallo = pcall(function()
				questRemote:InvokeServer(workspace.Others.NPCs[boss_quest])
			end)
			if fallo then
				advertencia('Error al seleccionar la mision: '..fallo)
			end
			task.wait(0.1)
		end
		advertencia('Ya la tienes seleccionada!')
		return boss
	end


	local function player_attack()
		local get_value = getStrength()

		if get_value >= attacks_melee[1].requerido then -- revisamos si la fuerza es mayor
			for _, melee in pairs(attacks_melee) do
				if get_value >= melee.requerido then
					melee_rs:InvokeServer(melee.name, "Blacknwhite27")
				end
				task.wait(0.1)
			end
		else
			punchRemote:FireServer('Blacknwhite27',1)
		end
	end


	local function attack_boss( boss )
		while boss:FindFirstChild('Humanoid') and boss:FindFirstChild('HumanoidRootPart') and boss.Humanoid.Health > 0 do
			local succes, fallo = pcall(function()
				plr.Character.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0,0,2)
				spawn(player_attack)
			end)
			if fallo then
				advertencia('Error en ir al boss en attack_boss: '..fallo)
			end
			task.wait()
		end

		advertencia('Ya murio el insecto!!!!')
		rebirthRemote:InvokeServer()
		task.wait(0.5)
	end


	local function rebirth_farm()
		while true do
			local succes, fallo = pcall(function()
				tranform_equipped() -- ejecutamos la transformacion
				local boss = quest() -- seleccionamos la mision
				local boss_quest = boss.quest -- name quest
				local enemy_name = boss.boss -- name boss

				while getQuest() == boss_quest do
					warn('Buscando al enemigo actual en el workspace porque ya tiene una mision seleccioanda actualmente!')
					for _, v in next, workspace.Living:GetChildren() do
						if v.Name == enemy_name and v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health > 0  then -- evaluamos si esta en la partida
							advertencia('El jefe fue encontrado: '..v.Name)
							attack_boss( v )
							advertencia('Ya paso la mision')
							break
						end
					end
					task.wait()
				end
				warn('Buscando una nueva mision porque la anterior finalizo!')
			end)
			if fallo then
				advertencia('Error en la logica principal del farm: '..fallo)
			end
			task.wait(1)
		end
	end


	local function start_game()
		replicated_storage.Package.Events.Start:InvokeServer()
		plr.Character.Humanoid.Health = 0
		task.wait(6)
	end

	if game.PlaceId ~= id_earth then
		wait(8)
	else
		wait(5)
	end
	start_game()

	RunService.Stepped:Connect(function()
		blocharg()
		task.wait()
	end)

	plr.Idled:Connect(function()
		game:service'VirtualUser':CaptureController()
		game:service'VirtualUser':ClickButton2(Vector2.new())
	end)

	rebirth_farm()
end

farmtest()
