local library = game["Run Service"]:IsStudio() and require(script.UiLib) or loadstring(game:HttpGet("https://raw.githubusercontent.com/LARTAJE/LSH_V2_Main/refs/heads/main/LSH_LIBRARY.lua"))()
local Notif = library:InitNotifications()

if _G.LACKSKILL_LOADED == true then
	local LoadingXSX = Notif:Notify("LACKSKILL: plz dont execute teh script more than one time..", 6, "error")
	task.wait(math.huge)
end
_G.LACKSKILL_LOADED = true

local Private = true

library.rank = Private and "Tester" or 'Public'
library.title = "Lackskill | V" .. library.version

-- notification, alert, error, success, information
local Notif = library:InitNotifications()
local LoadingXSX = Notif:Notify("Loading xsx lib and essencials, please be patient.", 6, "information")
local Watermark = library:Watermark("Lackskill | V" .. library.version ..  " | " .. library:GetUsername() .. " | Rank: " .. library.rank)

local CollectionService = game:GetService("CollectionService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local Debris = game:GetService("Debris")
local PlayerService = game:GetService("Players")

local Camera = workspace.CurrentCamera
local ClientG-- the actual games _G
local LocalPlayer = PlayerService.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local PlayerGui = LocalPlayer.PlayerGui
local PlatformHandler = ReplicatedFirst.PlatformHandler
local SelectedConfig = ''
local Configs = {}
local ConfigNames = {}

local MeleeStorage = ReplicatedStorage:WaitForChild("MeleeStorage")
local Events = ReplicatedStorage:WaitForChild("Events",5)

local PlayersInServer = {}
local ItemStats = {

	--//# Food

	["Energy Bar"] = {
		Type = "Food",
		Contraband = false
	},

	["Energy Drink"] = {
		Type = "Food",
		Contraband = false
	},

	["Coffee"] = {
		Type = "Food",
		Contraband = false
	},

	["Soda"] = {
		Type = "Food",
		Contraband = false
	},

	["Canned Beans"] = {
		Type = "Food",
		Contraband = false
	},

	["Canned Corn"] = {
		Type = "Food",
		Contraband = false
	},
	--/#

	--// Healing

	["Medkit"] = {
		Type = "Healing",
		Contraband = false
	},

	["Bandage"] = {
		Type = "Healing",
		Contraband = false
	},

	["Trauma Pad"] = {
		Type = "Healing",
		Contraband = false
	},
	--/#


	--// Misc

	["Lockpick"] = {
		Type = "Misc",
		Contraband = false
	},

	["Bounty Card"] = {
		Type = "Misc",
		Contraband = false
	},
	--/#

	--// Melees


	["Bat"] = {
		Type = "Melee",
		Contraband = false
	},

	["Tomahawk"] = {
		Type = "Melee",
		Contraband = false
	},

	["Spear"] = {
		Type = "Melee",
		Contraband = false
	},

	["Tactical Knife"] = {
		Type = "Melee",
		Contraband = false
	},

	["Trench Knife"] = {
		Type = "Melee",
		Contraband = false
	},

	["Greataxe"] = {
		Type = "Melee",
		Contraband = false
	},

	["Katana"] = {
		Type = "Melee",
		Contraband = false
	},

	["Sledgehammer"] = {
		Type = "Melee",
		Contraband = false
	},

	["Photon Blades"] = {
		Type = "Melee",
		Contraband = true
	},

	--// Guns


	["725"] = {
		Type = "Gun",
		Contraband = false
	},

	["M4A1"] = {
		Type = "Gun",
		Contraband = false
	},
	["AWM"] = {
		Type = "Gun",
		Contraband = false
	},

	["Crossbow"] = {
		Type = "Gun",
		Contraband = false
	},

	["FAMAS"] = {
		Type = "Gun",
		Contraband = false
	},

	["M1911"] = {
		Type = "Gun",
		Contraband = false
	},
	["MP5"] = {
		Type = "Gun",
		Contraband = false
	},
	["SCAR-17"] = {
		Type = "Gun",
		Contraband = false
	},
	["SCAR-20"] = {
		Type = "Gun",
		Contraband = false
	},
	["SPAS-12"] = {
		Type = "Gun",
		Contraband = false
	},
	["TAC-14"] = {
		Type = "Gun",
		Contraband = false
	},
	["G3"] = {
		Type = "Gun",
		Contraband = false
	},
	["G17"] = {
		Type = "Gun",
		Contraband = false
	},

	["G18"] = {
		Type = "Gun",
		Contraband = false
	},

	["MAC-11"] = {
		Type = "Gun",
		Contraband = false
	},

	["AK-47"] = {
		Type = "Gun",
		Contraband = false
	},

	["UZI"] = {
		Type = "Gun",
		Contraband = false
	},

	["M24"] = {
		Type = "Gun",
		Contraband = false
	},


	["Deagle"] = {
		Type = "Gun",
		Contraband = false
	},

	["Photon Accelerator"] = {
		Type = "Gun",
		Contraband = true
	},

	["RSH-12"] = {
		Type = "Gun",
		Contraband = true
	},

	["KS-23"] = {
		Type = "Gun",
		Contraband = true
	},
	--/#


	--// Explosives

	["M79"] = {
		Type = "Explosive",
		Contraband = false
	},

	["GL-06"] = {
		Type = "Explosive",
		Contraband = false
	},

	["RPG-18"] = {
		Type = "Explosive",
		Contraband = true
	},
	--/#

	--// Utility

	["Ammo Box"] = {
		Type = "Utility",
		Contraband = false
	},

	["Flashbang"] = {
		Type = "Utility",
		Contraband = false
	},

	["Grenade"] = {
		Type = "Utility",
		Contraband = false
	},

	["Skyfall T.A.G"] = {
		Type = "Utility",
		Contraband = true
	},

	["Proximity Mine"] = {
		Type = "Utility",
		Contraband = false
	},

	["Incendiary"] = {
		Type = "Utility",
		Contraband = false
	},

	["Smoke"] = {
		Type = "Utility",
		Contraband = false
	},


	--// Armor

	["Light Tactical Armor"] = {
		Type = "Armor",
		Contraband = false
	},

	["Heavy Tactical Armor"] = {
		Type = "Armor",
		Contraband = false
	},

	["Commander Helmet"] = {
		Type = "Armor",
		Contraband = true
	},

	["Commander Vest"] = {
		Type = "Armor",
		Contraband = true
	},

	["Commander Leggings"] = {
		Type = "Armor",
		Contraband = true
	},

	["Operator Helmet"] = {
		Type = "Armor",
		Contraband = true
	},

	["Operator Helmet MK2"] = {
		Type = "Armor",
		Contraband = true
	},

	["Operator Vest"] = {
		Type = "Armor",
		Contraband = true
	},

	["Operator Leggings"] = {
		Type = "Armor",
		Contraband = true
	},

	["Tactical Leggings"] = {
		Type = "Armor",
		Contraband = false
	},

	["Tactical Helmet"] = {
		Type = "Armor",
		Contraband = false
	},

	["Vulture Helmet"] = {
		Type = "Armor",
		Contraband = false
	},

	["Rebel Helmet"] = {
		Type = "Armor",
		Contraband = false
	},

	["Small Backpack"] = {
		Type = "Armor",
		Contraband = false
	},

	["Large Backpack"] = {
		Type = "Armor",
		Contraband = false
	},

	["Night-Vision Goggles"] = {
		Type = "Armor",
		Contraband = false
	},

	["Anti-Flash Goggles"] = {
		Type = "Armor",
		Contraband = false
	},

	["Gas Mask"] = {
		Type = "Armor",
		Contraband = false
	},
	--/#


	--// Keycards

	["Purple Keycard"] = {
		Type = "Keycard",
		Contraband = false
	},

	["Green Keycard"] = {
		Type = "Keycard",
		Contraband = false
	},

	["Orange Keycard"] = {
		Type = "Keycard",
		Contraband = false
	},

	["Blue Keycard"] = {
		Type = "Keycard",
		Contraband = false
	},

	["Red Keycard"] = {
		Type = "Keycard",
		Contraband = false
	},
	--/#

	--// Flares

	["Red Flare Gun"] = {
		Type = "Flares",
		Contraband = false
	},

	["Green Flare Gun"] = {
		Type = "Flares",
		Contraband = false
	},

	--/#

	--// Inhalers

	["Purple Combat Inhaler"] = {
		Type = "Inhaler",
		Contraband = false
	},

	["Green Combat Inhaler"] = {
		Type = "Inhaler",
		Contraband = false
	},

	["Orange Combat Inhaler"] = {
		Type = "Inhaler",
		Contraband = false
	},

}
local Settings = {
	DefaultUIToggleBind = Enum.KeyCode.End,

	KillAura_NPCs = false,
	KillAura_Players = false,
	KillAura_Toggle = false,
	KillAura_Range = 5,
	KillAura_TargetPart = 'Head',

	GunMod_NoRecoil = false,
	GunMod_NoSpread = false,
	GunMod_GamepadRecoil = false,
	GunMod_RapidFire = false,

	Silent_Toggle = false,
	Silent_TargetPartToggle = false,
	Silent_InstaHit = false,
	Silent_VisibleCheck = false,
	Silent_IgnoreFriends = false,
	Silent_ShowFOV = false,
	Silent_ShowSilentTarget = false,
	Silent_IgnoreNPCs = false,
	Silent_AimFov = 100,
	Silent_AimHitChance = 50,
	Silent_TargetPart = 'Head',

	Movement_InfiniteStamina = false,

	QoL_AutoLockpick = false,
	QoL_OpenLootOnLockpick = false,
	QoL_LockpickWait = 0.1,
	QoL_InstaInteract = false,

	PlayerNotifications_Enabled = false,
	PlayerNotifications_NotifyKits = false,
	PlayerNotifications_NotifDangerItems = false,
	PlayerNotifications_PlayerJoins = false,
	PlayerNotifications_AdminJoins = false,
	PlayerNotifications_Kits = {},

	NotifItems_Enabled = false,
	NotifItems_NotifItems = {},
	
	ShowBulletTracers = false
}
local Toggles = {}
local Sliders = {}
local Selectors = {}
local MultiSelectors = {}
local SoundList = {
	['Hover1'] = {
		SoundId = 'rbxassetid://92876108656319';
		Speed = 2;
		Parent = workspace;
		DeleteTime = 5;
		Volume = 0.1
	};
	['Click1'] = {
		SoundId = 'rbxassetid://6895079853';
		Speed = 2;
		Parent = workspace;
		DeleteTime = 5;
		Volume = 1
	};
	['Notif_Success1'] = {
		SoundId = 'rbxassetid://15675059323';
		Speed = 1.5;
		Parent = workspace;
		DeleteTime = 5
	};
	['Notif_Error1'] = {
		SoundId = 'rbxassetid://3779045779';
		Speed = 1.5;
		Parent = workspace;
		DeleteTime = 5
	}
}
local Kits = {
	'Operator',
	'Commander',
	'Blade dancer'
}
local LootTypes = {
	'Food',
	'Healing',
	'Utility' ,
	'Misc',
	'Melee',
	'Gun',
	'Explosive' ,
	'Armor',
	'Keycard',
	'Flare',
	'Contraband'
}
local PlayerDescriptionDump = Instance.new("Folder",nil)
local SilentTargetHightLight = Instance.new("Highlight")
SilentTargetHightLight.FillTransparency = 1

local ExpectedArguments = {--Skidded but whatever xd
	FindPartOnRayWithIgnoreList = {
		ArgCountRequired = 3,
		Args = {
			"Instance", "Ray", "table", "boolean", "boolean"
		}
	},
	FindPartOnRayWithWhitelist = {
		ArgCountRequired = 3,
		Args = {
			"Instance", "Ray", "table", "boolean"
		}
	},
	FindPartOnRay = {
		ArgCountRequired = 2,
		Args = {
			"Instance", "Ray", "Instance", "boolean", "boolean"
		}
	},
	Raycast = {
		ArgCountRequired = 3,
		Args = {
			"Instance", "Vector3", "Vector3", "RaycastParams"
		}
	}
}
local ValidTargetParts = {"Head", "Torso"}

local Drawing_FOVCircle = Drawing.new("Circle")
Drawing_FOVCircle.Thickness = 1
Drawing_FOVCircle.NumSides = 100
Drawing_FOVCircle.Radius = 360
Drawing_FOVCircle.Filled = false
Drawing_FOVCircle.Visible = false
Drawing_FOVCircle.ZIndex = 999
Drawing_FOVCircle.Transparency = 1
Drawing_FOVCircle.Color = Color3.fromRGB(255,255,255)

local BulletTracerColor = Color3.new(1,1,1)

if not RunService:IsStudio() then
	library:Introduction()
end
local Init = library:Init(Settings.DefaultUIToggleBind)
local Gui = Init:GetGui()

--// Locals

local VirtualInputManager = Instance.new("VirtualInputManager")
local PlatformHandler = ReplicatedFirst.PlatformHandler
local NPCList = {}
local CharList = {}
--/#

--// Events

local PickUpEvent = Events:WaitForChild("Loot"):WaitForChild("LootObject")
local StartTask = Events:WaitForChild("Stations"):WaitForChild("StartTask")
local MinigameResult = Events:WaitForChild("Loot"):WaitForChild("MinigameResult")
local DamageEvent = Events:WaitForChild("Player"):WaitForChild("Damage")
local RagdollEvent = Events:WaitForChild("Player"):WaitForChild("Ragdoll")
local HitEvent = MeleeStorage:WaitForChild("Events"):WaitForChild("Hit")
local SwingEvent = MeleeStorage:WaitForChild("Events"):WaitForChild("Swing")
--/#

function HandleSections(Sections)
	for SectionName, Section in Sections do
		task.spawn(Section)
	end
end

function PlaySound(Settings)
	local NewSound = Instance.new('Sound')
	NewSound.SoundId = Settings.SoundId
	NewSound.PlaybackSpeed = Settings.Speed or Settings.PlaybackSpeed
	NewSound.Volume = Settings.Volume or 0.5
	NewSound.Parent = Settings.Parent or workspace
	
	NewSound:Play()
	Debris:AddItem(NewSound, Settings.DeleteTime or NewSound.TimeLength)
end

local function GetPositionOnScreen(Vector)
	local Vec3, OnScreen = Camera:WorldToScreenPoint(Vector)
	return Vector2.new(Vec3.X, Vec3.Y), OnScreen
end

local function GetDirection(Origin, Position)
	return (Position - Origin).Unit * 1000
end

local function GetMousePosition()
	return UserInputService:GetMouseLocation()
end

local function PickUpItem(LootTable,Item,Method)
	PickUpEvent:FireServer(LootTable,Item,Method)
end

local function Damage(Damage,LimbDamageTable)
	DamageEvent:FireServer(Damage,LimbDamageTable)
end

local function CalculateChance(Percentage)
	Percentage = math.floor(Percentage)
	local chance = math.floor(Random.new().NextNumber(Random.new(), 0, 1) * 100) / 100
	return chance <= Percentage / 100
end

local function Get_G()
	local PlatformHandler = PlatformHandler
	PlatformHandler.Enabled = true
	ClientG = getsenv(PlatformHandler)._G
end

local function OpenLoot(Target)
	fireproximityprompt(Target.LootBase.OpenLootTable)
end

local function LockPick(Target,Method)
	MinigameResult:FireServer(Target,Method)
	VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
end

local function RagdollChar()
	RagdollEvent:FireServer()
end

local function Swing()
	SwingEvent:InvokeServer()
end

local function Hit(__ZCharacter,PartToHit)
	local args = {
		[1] = __ZCharacter[PartToHit],
		[2] = __ZCharacter[PartToHit].Position
	}
	HitEvent:FireServer(unpack(args))
end

local function ValidateArguments(Args, RayMethod)
	local Matches = 0
	if #Args < RayMethod.ArgCountRequired then
		return false
	end
	for Pos, Argument in next, Args do
		if typeof(Argument) == RayMethod.Args[Pos] then
			Matches = Matches + 1
		end
	end
	return Matches >= RayMethod.ArgCountRequired
end

local function IsCharacterVisible(Character)
	local Character = Character
	local LocalPlayerCharacter = LocalPlayer.Character

	if not (Character or LocalPlayerCharacter) then
		return
	end 

	local PlayerRoot = Character:FindFirstChild(Settings.Silent_TargetPart) or Character:FindFirstChild("HumanoidRootPart")

	if not PlayerRoot then
		return
	end 

	local CastPoints, IgnoreList = {PlayerRoot.Position, LocalPlayerCharacter, Character}, {LocalPlayerCharacter, Character, workspace.Debris, workspace.Map.RoadDecor,workspace.Map.Vegetation}
	local ObscuringObjects = #Camera:GetPartsObscuringTarget(CastPoints, IgnoreList)

	return ((ObscuringObjects == 0 and true) or (ObscuringObjects > 0 and false))
end

local function GetClosestPlayer()
	local Closest
	local DistanceToMouse
	local ToCheck = Settings.Silent_IgnoreNPCs == false and NPCList or {}
	for _, Char in CharList do
		table.insert(ToCheck, Char)
	end

	for _, Character in ToCheck do
		if Character == LocalPlayer then
			continue
		end
		
		if not Character then
			continue
		end

		if Settings.Silent_VisibleCheck and not IsCharacterVisible(Character) then
			continue
		end
		local Player = PlayerService:GetPlayerFromCharacter(Character)
		if Player and Settings.Silent_IgnoreFriends and Player:IsFriendsWith(LocalPlayer.UserId) then
			continue
		end

		local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
		local Humanoid = Character:FindFirstChild("Humanoid")

		if not HumanoidRootPart or not Humanoid or Humanoid and Humanoid.Health <= 0 then continue end

		local ScreenPosition, OnScreen = GetPositionOnScreen(HumanoidRootPart.Position)
		if not OnScreen then continue end

		local Distance = (GetMousePosition() - ScreenPosition).Magnitude

		if Distance <= (DistanceToMouse or Settings.Silent_AimFov or 2000) then
			Closest = ((Settings.Silent_TargetPart == "Random" and Character[ValidTargetParts[math.random(1, #ValidTargetParts)]]) or Character[Settings.Silent_TargetPart])
			DistanceToMouse = Distance
		end

	end

	return Closest
end

local function InjectCustomConfig()
	task.delay(1,function()
		for _, Module in getgc(true) do 
			if type(Module) == 'table' and rawget(Module, 'Reloading') then 
				if type(Module.Firing) ~= 'table' then
					continue
				end
				if Settings.GunMod_NoRecoil then
					rawset(Module.Firing, 'Recoil', NumberRange.new(0, 0))
					rawset(Module.Firing, 'Shake', 0)
				end
				if Settings.GunMod_RapidFire then
					for _, Mode in Module.Modes do
						rawset(Mode, 'Automatic', true)
						rawset(Mode, 'RPM', 999999)
					end
				end
				if Settings.GunMod_NoSpread then
					rawset(Module.Firing, 'Spread', 0)
				end
			end
		end
	end)
end

local function DoNpcAdd(Inst)
	if Inst and Inst:IsA('Model') and Inst.Parent and not PlayerService:GetPlayerFromCharacter(Inst) then
		table.insert(NPCList, Inst)
	end
end
pcall(function()
	for _, NPC in workspace.NPCs.Custom:GetChildren() do
		DoNpcAdd(NPC)
	end
	workspace.NPCs.Custom.ChildAdded:Connect(DoNpcAdd)
end)
for _, NPC in CollectionService:GetTagged('NPC') do
	DoNpcAdd(NPC)
end
CollectionService:GetInstanceAddedSignal('NPC'):Connect(DoNpcAdd)

local function Vector2MousePosition()
	return Vector2.new(Mouse.X, Mouse.Y)
end

local UpdateKit = Instance.new('BindableEvent')
local function TrackCharacter(Character)
	if Character == LocalPlayer.Character then
		Character.ChildAdded:Connect(function(Child)
			if Child.Name == "ServerGunModel" then
				InjectCustomConfig()
			end
		end)
		return
	end
	table.insert(CharList, Character)
	Character.AncestryChanged:Once(function()
		table.remove(CharList, table.find(CharList,Character))
	end)
	
	Character.ChildAdded:Connect(function(dsc)
		if dsc.Name ~= "Photon Accelerator" and dsc.Name ~= "Skyfall T.A.G." and dsc.Name ~= 'RPG-18' then
			return
		end
		if Settings.PlayerNotifications_NotifDangerItems then
			Notif:Notify(dsc.Name.." WAS EQUIPPED BY: "..Character.Name, 4, "success")
			PlaySound(SoundList.Notif_Error1)
		end
	end)
	
	local function CheckForKit()
		local Operator = 0
		local Commander = 0
		local BladeDancer = 0
		
		for _, Stuff in Character:WaitForChild('CurrentGear'):GetChildren() do
			if Stuff.Name:find('Operator') then
				Operator+=1
			end
			if Stuff.Name:find('Commander') then
				Commander+=1
			end
			if Stuff.Name:find('Blade') then
				BladeDancer+=1
			end
		end
		
		if Operator >= 3 then
			Notif:Notify('!!Operator!! '..Character.Name, 4, "success")
			PlaySound(SoundList.Notif_Error1)
		end
		if Commander >= 3 then
			Notif:Notify('!!Commander!! '..Character.Name, 4, "success")
			PlaySound(SoundList.Notif_Error1)
		end
		if BladeDancer >= 3 then
			Notif:Notify('!!Blade dancer!! '..Character.Name, 4, "success")
			PlaySound(SoundList.Notif_Error1)
		end
	end
	Character:WaitForChild('CurrentGear').ChildAdded:Connect(CheckForKit)
	UpdateKit.Event:Connect(CheckForKit)
	CheckForKit()
end

local function PlayerAdded(Player, Executed)
	table.insert(PlayersInServer,Player)
	
	if not Settings.PlayerNotifications_PlayerJoins then
		return
	end
	
	local function IsInGroup(Plr, Id)
		local Success, Response = pcall(Plr.IsInGroup, Plr, Id)
		if Success then 
			return Response 
		end
		return false
	end

	local function GetRoleInGroup(Plr, Id)
		local Success, Response = pcall(Plr.GetRoleInGroup, Plr, Id)
		if Success then
			return Response
		end
		return false
	end

	local GroupStates = { 
		["CrimAdminGroup"] = IsInGroup(Player, 10911475),
		["Blackout"] = IsInGroup(Player, 6568965),
	}

	if GroupStates.CrimAdminGroup or GroupStates.Blackout then
		local Role = GetRoleInGroup(Player, 6568965)

		if Role ~= "Member" or GroupStates.CrimAdminGroup and Settings.PlayerNotifications_AdminJoins then
			--LocalPlayer:Kick("[LackSkill Hub] - Detected an Admin/Contributor within the server!")
			Notif:Notify(Player.Name.." Is a Admin/Contributor, please be careful!", 4, "success")
			PlaySound(SoundList.Notif_Error1)
		elseif Settings.PlayerNotifications_PlayerJoins and not Executed then
			Notif:Notify(Player.Name.." Joined, be careful!", 4, "success")
			PlaySound(SoundList.Notif_Success1)
		end

	end
end

local function PlayerRemoved(Player)
	local PlayerInServer = table.find(PlayersInServer, Player)
	if PlayerInServer then
		table.remove(PlayersInServer, PlayerInServer)
	end
end

PlayerService.PlayerAdded:Connect(PlayerAdded)
PlayerService.PlayerRemoving:Connect(PlayerAdded)
for _, Player in PlayerService:GetPlayers() do
	PlayerAdded(Player,true)
end
for _, Characters in workspace.Chars:GetChildren() do
	TrackCharacter(Characters)
end
workspace.Chars.ChildAdded:Connect(TrackCharacter)

local function HightlightOBJ(OBJ,timeT)
	local HL = Instance.new("Highlight")
	HL.FillTransparency = 0.75
	HL.Parent = OBJ
	game:GetService("Debris"):AddItem(HL, timeT)
end

local function ItemAdded(Item,Method)

	if Settings.NotifItems_Enabled == true then
		local ItemStat = ItemStats[Item.Name]
		local Suc, Err = pcall(function()
			if ItemStat and (Settings.NotifItems_NotifItems[ItemStat.Type] == true)
				or ItemStat.Contraband == true and
				(Settings.NotifItems_NotifItems["Contraband"] == true) then
				Notif:Notify("Item ".. Item.Name.. " Dropped", 10, "success")
				PlaySound(SoundList.Notif_Success1)
				HightlightOBJ(Item.Parent.Parent,10)
			end
		end)

		if not Suc then
			print("lol "..Item.Name)
		end
	end

end

local LootTables = {}
local function LootStuff()
	local function SetUpLootTables(_LootTable)
		table.insert(LootTables, _LootTable)

		_LootTable.ChildAdded:Connect(function(Item)
			ItemAdded(Item)
		end)

		for __,Item in(_LootTable:GetChildren()) do
			ItemAdded(Item)
		end
	end
	for _, PlrDeathBLootTable in pairs(workspace.Debris.Loot:GetDescendants()) do
		if PlrDeathBLootTable.Name == "LootTable" then
			SetUpLootTables(PlrDeathBLootTable)
		end
	end
	workspace.Debris.Loot.ChildAdded:Connect(function(LootBag)
		local LoooottableeOMG = LootBag:WaitForChild("LootTable", 5)
		if not LoooottableeOMG then return end
		table.insert(LootTables, LoooottableeOMG)
		SetUpLootTables(LoooottableeOMG)
	end)
end
LootStuff()

local ProxPrompts = {}

function II_C()
	if Settings.QoL_InstaInteract then
		for _,HPrompt in pairs(ProxPrompts) do
			HPrompt.HoldDuration = 0
		end
	else
		for _,HPrompt in pairs(ProxPrompts) do
			HPrompt.HoldDuration = HPrompt:GetAttribute("_Original_HoldTime")
		end
	end
end

local function ProximityPromptStuff()
	--[[
	local function CollectLootFromLootTable(LootTable)
		local ItemsInLootTable = LootTable:GetChildren()
		local CurrentItemIndex = 1


		for _, Item in pairs(ItemsInLootTable) do
			local ItemStat = ItemStats[Item.Name]

			if ItemStat and (Options.AutoLootFilter[ItemStat.Type] == true) or ItemStat.Contraband == true and (Options.AutoLootFilter[ItemStat.Contraband] == true) then
				PickUpItem(LootTable,Item,true)
				task.wait(0.5)
			end

		end


		if Settings.AutoLootFilter["Cash"] == true then
			task.wait(0.5)
			PickUpItem(LootTable,"Cash", nil)
		end

		if Options.AutoLootFilter["Valuables"] == true then
			task.wait(0.5)
			PickUpItem(LootTable,"Valuables",nil)
		end

	end
	--]]
	local function PromptSetUp(ProxPrompt)
		table.insert(ProxPrompts, ProxPrompt)
		ProxPrompt:SetAttribute("_Original_HoldTime", ProxPrompt.HoldDuration)
		II_C()
		ProxPrompt.Triggered:Connect(function()

			if ProxPrompt.Name == "LockMinigame" then
				local ToLockPick = ProxPrompt.Parent.Parent.Parent

				if ProxPrompt:GetAttribute("Unlocked") then
					task.wait(0.5)
					OpenLoot(ToLockPick)
				end

				if Settings.QoL_AutoLockpick == true then
					task.wait(Settings.QoL_LockpickWait + 0.1)
					LockPick(ToLockPick,true)

					if Settings.QoL_OpenLootOnLockpick == true then
						OpenLoot(ToLockPick)
					end

				end

			elseif ProxPrompt.Name == "OpenLootTable" then

				local PromptLootTable = ProxPrompt.Parent:FindFirstChild("LootTable")

				if false then--AutoLootToggle
					task.wait(0.6)
					--CollectLootFromLootTable(PromptLootTable)
				end

			end

		end)

	end
	game.ProximityPromptService.PromptShown:Connect(PromptSetUp)
end

ProximityPromptStuff()

local oldNamecall

local function CreateTracer(Origin: Vector3, Goto: Vector3)
	local Tracer = Instance.new("Part")
	Tracer.Material = Enum.Material.ForceField
	Tracer.Transparency = 0.85
	Tracer.Color = BulletTracerColor
	Tracer.Parent = workspace.Debris
	Tracer.Anchored = true
	Tracer.CanCollide = false
	Tracer.Size = Vector3.new(0.1, 0.1, (Goto - Origin).Magnitude + 1)
	Tracer.CFrame = CFrame.lookAt((Origin + Goto) / 2, Goto)
	task.delay(5, function()
		Tracer:Destroy()
	end)
end

oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
	local Method = getnamecallmethod()

	local Arguments = {...}
	local self = Arguments[1]

	local chance = CalculateChance(Settings.Silent_AimHitChance)

	if self == workspace and not checkcaller() and Method == "Raycast" then
		if ValidateArguments(Arguments, ExpectedArguments.Raycast) and Arguments[4]["FilterDescendantsInstances"][1] == LocalPlayer.Character and Arguments[4]["FilterDescendantsInstances"][2] == workspace.Debris then
			local A_Origin = Arguments[2]
			local HitPart = GetClosestPlayer()

			local function F_CastRay(origin: Vector3, direction: Vector3)
				local raycastParams = RaycastParams.new()
				raycastParams.FilterType = Enum.RaycastFilterType.Exclude
				raycastParams.FilterDescendantsInstances = {workspace.CurrentCamera, LocalPlayer.Character} -- Ignore the camera

				local raycastResult = workspace:Raycast(origin, direction, raycastParams)

				return raycastResult.Position
			end

			if chance == true and Settings.Silent_Toggle == true then
				if HitPart then
					if false then--Settings.Silent_InstaHit
						local pos = HitPart.CFrame + HitPart.CFrame.LookVector * -2
						local CfTVec = Vector3.new(pos.X, pos.Y, pos.Z)
						Arguments[2] = CfTVec
						A_Origin = CfTVec
					end
					Arguments[3] = GetDirection(A_Origin, HitPart.Position)
					return oldNamecall(unpack(Arguments))
				else
					return oldNamecall(...)
				end
			end

			if Settings.ShowBulletTracers == true then
				local pos = F_CastRay(A_Origin, Arguments[3])
				CreateTracer(A_Origin, pos)
			end

		else
			return oldNamecall(...)
		end
	else
		return oldNamecall(...)
	end

	return oldNamecall(...)
end))

local Tabs = {
	[1] = function() --CombatTab
		local CombatSection = Init:NewTab("Combat")
		local Sections = {
			[1] = function() --KillAuraSetup
				CombatSection:NewSection("Kill aura")

				--local Label1 = CombatSection:NewLabel("xv label", "left")--"left", "center", "right"

				local Killaura_GeralToggle = CombatSection:NewToggle("Toggle", Settings.KillAura_Toggle, function(value)
					Settings.KillAura_Toggle = value
				end):AddKeybind()

				local Slider1 = CombatSection:NewSlider("Range", "", true, "/", {min = 5, max = 20, default = Settings.KillAura_Range}, function(value)
					Settings.KillAura_Range = value
				end)

				local Selector1 = CombatSection:NewSelector("Target Part",Settings.KillAura_TargetPart, {"Head", "Torso", "Random"}, function(value)
					Settings.KillAura_TargetPart = value
				end)

				local Killaura_PlayerToggle = CombatSection:NewToggle("Target Players", Settings.KillAura_Players, function(value)
					Settings.KillAura_Players = value
				end)--:AddKeybind()

				local Killaura_NPCToggle = CombatSection:NewToggle("Target NPCs", Settings.KillAura_NPCs, function(value)
					Settings.KillAura_NPCs = value
				end)--:AddKeybind()

				Toggles['KillAura_Toggle'] = Killaura_GeralToggle
				Sliders['KillAura_Range'] = Slider1
				Selectors['KillAura_TargetPart'] = Selector1
				Toggles['KillAura_Players'] = Killaura_PlayerToggle
				Toggles['KillAura_NPCs'] = Killaura_NPCToggle
			end,
			[2] = function() --GunModsSetup
				CombatSection:NewSection("Gun mods")

				local NoRecoil = CombatSection:NewToggle("No recoil", Settings.GunMod_NoRecoil, function(value)
					Settings.GunMod_NoRecoil = value
				end)--:AddKeybind()

				local GamepadRecoil = CombatSection:NewToggle("Gamepad recoil", Settings.GunMod_GamepadRecoil, function(value)
					Settings.GunMod_GamepadRecoil = value
				end)--:AddKeybind()

				local NoSpread = CombatSection:NewToggle("No spread", Settings.GunMod_NoSpread, function(value)
					Settings.GunMod_NoSpread = value
				end)--:AddKeybind()

				local RapidFire = CombatSection:NewToggle("Rapid fire", Settings.GunMod_RapidFire, function(value)
					Settings.GunMod_RapidFire = value
				end)--:AddKeybind()

				Toggles['GunMod_NoRecoil'] = NoRecoil
				Toggles['GunMod_GamepadRecoil'] = GamepadRecoil
				Toggles['GunMod_NoSpread'] = NoSpread
				Toggles['GunMod_RapidFire'] = RapidFire
			end,
			[3] = function() --SilentAimSetup
				CombatSection:NewSection("Silent aim")

				local SilentAim_Toggle = CombatSection:NewToggle("Toggle", Settings.Silent_Toggle, function(value)
					Settings.Silent_Toggle = value
				end):AddKeybind()

				local SlientAim_FOV = CombatSection:NewSlider("Silent FOV", "", true, "/", {min = 0, max = 2000, default = Settings.Silent_AimFov}, function(value)
					Settings.Silent_AimFov = value
				end)

				local SlientAim_HitChance = CombatSection:NewSlider("Hit chance", "", true, "/", {min = 1, max = 100, default = Settings.Silent_AimHitChance}, function(value)
					Settings.Silent_AimHitChance = value
				end)
				
				--[[
				local SilentAim_VisibleCheck = CombatSection:NewToggle("Insta hit", Settings.Silent_Aim.InstaHit, function(value)
					Settings.Silent_Aim.InstaHit = value
				end)--:AddKeybind()
				--]]

				local SilentAim_VisibleCheck = CombatSection:NewToggle("Visible check", Settings.Silent_VisibleCheck, function(value)
					Settings.Silent_VisibleCheck = value
				end)--:AddKeybind()
				
				local Silent_IgnoreFriends = CombatSection:NewToggle("Ignore friends", Settings.Silent_VisibleCheck, function(value)
					Settings.Silent_IgnoreFriends = value
				end)--:AddKeybind()
				
				local Silent_IgnoreNPCs = CombatSection:NewToggle("Ignore NPCs", Settings.Silent_VisibleCheck, function(value)
					Settings.Silent_IgnoreNPCs = value
				end)--:AddKeybind()
				
				local Silent_ShowFOV = CombatSection:NewToggle("Show FOV", Settings.Silent_VisibleCheck, function(value)
					Settings.Silent_ShowFOV = value
				end)--:AddKeybind()
				
				local Silent_ShowSilentTarget = CombatSection:NewToggle("Show silent target", Settings.Silent_VisibleCheck, function(value)
					Settings.Silent_ShowSilentTarget = value
				end)--:AddKeybind()
				
				Toggles['Silent_Toggle'] = SilentAim_Toggle
				Toggles['Silent_IgnoreNPCs'] = Silent_IgnoreNPCs
				Toggles['Silent_IgnoreFriends'] = Silent_IgnoreFriends
				Toggles['Silent_ShowSilentTarget'] = Silent_ShowSilentTarget
				Toggles['Silent_ShowFOV'] = Silent_ShowFOV
				Sliders['Silent_AimFov'] = SlientAim_FOV
				Sliders['Silent_AimHitChance'] = SlientAim_HitChance
				Toggles['Silent_VisibleCheck'] = SilentAim_VisibleCheck
			end,
		}
		HandleSections(Sections)
	end,
	[2] = function() --MovementTab
		local Movement = Init:NewTab("Movement")
		local Sections = {
			[1] = function() --Player
				Movement:NewSection("Geral")
				local InfiniteStamina = Movement:NewToggle("Infinite stamina", Settings.Movement_InfiniteStamina, function(value)
					Settings.Movement_InfiniteStamina = value
				end):AddKeybind()
				
				Toggles['Movement_InfiniteStamina'] = InfiniteStamina
			end,
		}
		HandleSections(Sections)
	end,
	[3] = function() --QualityOfLiveTab
		local QoL = Init:NewTab("QoL")
		local Sections = {
			[1] = function() --LockPickingSetup
				QoL:NewSection("Lock Picking")

				--local Label1 = CombatSection:NewLabel("xv label", "left")--"left", "center", "right"

				local AutoLockPick = QoL:NewToggle("Auto lockpick", Settings.QoL_AutoLockpick, function(value)
					Settings.QoL_AutoLockpick = value
				end)--:AddKeybind()

				local LockRNG = QoL:NewSlider("Lootpick wait", "", true, "/", {min = 0.1, max = 5.0, default = Settings.QoL_LockpickWait}, function(value)
					Settings.QoL_LockpickWait = value
				end)

				local OpenLootOnLockpick = QoL:NewToggle("Open loot on lockpick", Settings.QoL_OpenLootOnLockpick, function(value)
					Settings.QoL_OpenLootOnLockpick = value
				end)--:AddKeybind()
				
				Toggles['QoL_AutoLockpick'] = AutoLockPick
				Sliders['QoL_LockpickWait'] = LockRNG
				Toggles['QoL_OpenLootOnLockpick'] = OpenLootOnLockpick
			end,
			[2] = function() --Notification
				QoL:NewSection("Notitications")
				QoL:NewLabel("Loot notifier", "center")--"left", "center", "right"

				local NotifItemsToggle = QoL:NewToggle("Enabled", Settings.NotifItems_Enabled, function(value)
					Settings.NotifItems_Enabled = value
				end)--:AddKeybind()

				local Selector1 = QoL:NewMultiSelector("Loot class to notify",Settings.NotifItems_NotifItems, LootTypes)
				Selector1:SetFunction(function(value, Set)
					local ItemInTable = table.find(Settings.NotifItems_NotifItems,value)

					if Set == true then
						if not ItemInTable then
							table.insert(Settings.NotifItems_NotifItems, value)
						end

						Selector1:UpdateCurrentSelected(Settings.NotifItems_NotifItems)
						return ItemInTable
					elseif Set == false then
						if ItemInTable then
							table.remove(Settings.NotifItems_NotifItems, ItemInTable)
						end

						Selector1:UpdateCurrentSelected(Settings.NotifItems_NotifItems)
						return ItemInTable
					end

					if ItemInTable then
						table.remove(Settings.NotifItems_NotifItems, ItemInTable)
					else
						table.insert(Settings.NotifItems_NotifItems, value)
					end

					Selector1:UpdateCurrentSelected(Settings.NotifItems_NotifItems)
					return ItemInTable
				end)

				QoL:NewLabel("Player notifications", "center")--"left", "center", "right"
				local PlayerNotifsToggle = QoL:NewToggle("Enabled", Settings.PlayerNotifications_Enabled, function(value)
					Settings.PlayerNotifications_Enabled = value
				end)--:AddKeybind()

				local PlayerJoinNotifToggle = QoL:NewToggle("Player joins", Settings.PlayerNotifications_PlayerJoins, function(value)
					Settings.PlayerNotifications_PlayerJoins = value
				end)--:AddKeybind()

				local AdminJoinNotifToggle = QoL:NewToggle("Admin joins", Settings.PlayerNotifications_AdminJoins, function(value)
					Settings.PlayerNotifications_AdminJoins = value
				end)--:AddKeybind()

				local KitNotifsToggle = QoL:NewToggle("Notify kits", Settings.PlayerNotifications_NotifyKits, function(value)
					UpdateKit:Fire()
					Settings.PlayerNotifications_NotifyKits = value
				end)--:AddKeybind()

				local Selector2 = QoL:NewMultiSelector("Kits to notify",Settings.PlayerNotifications_Kits, Kits)
				Selector2:SetFunction(function(value, Set)
					local ItemInTable = table.find(Settings.PlayerNotifications_Kits,value)

					if Set == true then
						if not ItemInTable then
							table.insert(Settings.PlayerNotifications_Kits, value)
						end

						Selector2:UpdateCurrentSelected(Settings.PlayerNotifications_Kits)
						return ItemInTable
					elseif Set == false then
						if ItemInTable then
							table.remove(Settings.PlayerNotifications_Kits, ItemInTable)
						end

						Selector2:UpdateCurrentSelected(Settings.PlayerNotifications_Kits)
						return ItemInTable
					end
					
					if ItemInTable then
						table.remove(Settings.PlayerNotifications_Kits, ItemInTable)
					else
						table.insert(Settings.PlayerNotifications_Kits, value)
					end
					
					Selector2:UpdateCurrentSelected(Settings.PlayerNotifications_Kits)
					return ItemInTable
				end)
				
				Toggles['NotifItems_Enabled'] = NotifItemsToggle
				MultiSelectors['NotifItems_NotifItems'] = Selector1
				Toggles['PlayerNotifications_Enabled'] = PlayerNotifsToggle
				Toggles['PlayerNotifications_PlayerJoins'] = PlayerJoinNotifToggle
				Toggles['PlayerNotifications_AdminJoins'] = AdminJoinNotifToggle
				Toggles['PlayerNotifications_NotifyKits'] = KitNotifsToggle
				MultiSelectors['PlayerNotifications_Kits'] = Selector2
			end,
			[3] = function() --Other
				QoL:NewSection("Other")
				local InstaHD = QoL:NewToggle("Insta interact", Settings.QoL_InstaInteract, function(value)
					II_C()
					Settings.QoL_InstaInteract = value
				end)--:AddKeybind()
				
				Toggles['QoL_InstaInteract'] = InstaHD
			end,
		}
		HandleSections(Sections)
	end,
	[4] = function() --EspTab
		local ESP = Init:NewTab("ESP")
		local Sections = {
		}
		HandleSections(Sections)
	end,
	[5] = function() --CustomizationTab
		local Customization = Init:NewTab("Customization")
		local Sections = {
		}
		HandleSections(Sections)
	end,
	[6] = function() --ConfigurationTab
		local Configuration = Init:NewTab("Configuration")
		local Sections = {
			[1] = function() --General
				local ConfigSaveName = 'Nothing'
				Configuration:NewSection("Geral")
				local Keybind1 = Configuration:NewKeybind("Toggle UI bind", Settings.DefaultUIToggleBind, function(key)
					Init:UpdateKeybind(Enum.KeyCode[key])
				end)

				Configuration:NewLabel("", "left")--"left", "center", "right"

				local Textbox1 = Configuration:NewTextbox("Config name", "", " ", "all", "medium", true, false, function(value)
					ConfigSaveName = value
				end)

				local Selector1 = Configuration:NewSelector("Configs",SelectedConfig, ConfigNames, function(value)
					SelectedConfig = value
				end)

				local SaveButton = Configuration:NewButton("Save config", function()
					local EncodedConfig = HttpService:JSONEncode(Settings)
					Configs[ConfigSaveName] = EncodedConfig
					
					if not table.find(ConfigNames, ConfigSaveName) then
						Notif:Notify('Saved new config: '..ConfigSaveName, 4, "success")
						Selector1:AddOption(ConfigSaveName)
						table.insert(ConfigNames,ConfigSaveName)
					else
						Notif:Notify(('Overwrote config: '..ConfigSaveName), 4, "success")
					end
					PlaySound(SoundList.Notif_Success1)

					print("Saved xd", ConfigSaveName)
				end)

				local LoadButton = Configuration:NewButton("Load config", function()
					local Config = Configs[SelectedConfig]
					if not Config then
						Notif:Notify('Config not found', 4, "error")
						PlaySound(SoundList.Notif_Error1)
						return
					end
					Config = HttpService:JSONDecode(Config)
					for ConfigName, Value in Config do
						local IsToggle = Toggles[ConfigName]
						local IsSlider = Sliders[ConfigName]
						local IsSelector = Selectors[ConfigName]
						local IsMultiSelector = MultiSelectors[ConfigName]
						Settings[ConfigName] = Value
						
						if IsToggle then
							IsToggle:Set(Value)
						elseif IsSlider then
							IsSlider:Set(Value)
						elseif IsSelector then
							IsSelector:Hello(Value)
						elseif IsMultiSelector then
							IsMultiSelector:Set(Value)
						end
					end
					PlaySound(SoundList.Notif_Success1)
					Notif:Notify('Loaded config: '..ConfigSaveName, 4, "success")
					print("Loaded xd", Config)
				end)
				
				local DeleteButton = Configuration:NewButton("Delete config", function()
					local Config = Configs[SelectedConfig]
					if not Config then
						Notif:Notify('Config not found', 4, "error")
						PlaySound(SoundList.Notif_Error1)
						return
					end
					PlaySound(SoundList.Notif_Success1)
					Configs[SelectedConfig] = nil
					Selector1:RemoveOption(SelectedConfig)
					Notif:Notify('Deleted config: '..ConfigSaveName, 4, "success")
				end)
			end,
		}
		HandleSections(Sections)
	end,
}

for TabName, Tab in Tabs do
	task.spawn(Tab)
end
local FinishedLoading = Notif:Notify("Loaded UI", 4, "success")
for _, Buttons:TextButton in Gui:GetDescendants() do
	if Buttons:IsA('TextButton') or Buttons:IsA('ImageButton') then
		Buttons.MouseButton1Click:Connect(function()
			PlaySound(SoundList.Click1)
		end)
		
		Buttons.MouseEnter:Connect(function()
			PlaySound(SoundList.Hover1)
		end)
	end
end

Get_G()
RunService.RenderStepped:Connect(function()
	local Functions = {
		['Killaura'] = function()
			if Settings.KillAura_Toggle then
				if Settings.KillAura_Players then
					for i,char in CharList do
						pcall(function()
							if char and char.Parent and char.PrimaryPart and (LocalPlayer.Character.PrimaryPart.Position - char.PrimaryPart.Position).Magnitude < Settings.KillAura_Range  and char:FindFirstChildWhichIsA('Humanoid') and char:FindFirstChildWhichIsA('Humanoid').Health > 0 then
								local HitPart = Settings.KillAura_TargetPart
								local Part = char:FindFirstChild(HitPart)
								Swing()
								HitEvent:FireServer(Part, Part.Position)
							end
						end)
					end
				end

				if Settings.KillAura_NPCs then
					for i,npc in NPCList do
						pcall(function()
							if npc and npc.Parent and npc.PrimaryPart and (LocalPlayer.Character.PrimaryPart.Position - npc.PrimaryPart.Position).Magnitude < Settings.KillAura_Range and npc:FindFirstChildWhichIsA('Humanoid') and npc:FindFirstChildWhichIsA('Humanoid').Health > 0 then
								local HitPart = Settings.KillAura_TargetPart
								local Part = npc:FindFirstChild(HitPart)
								Swing()
								HitEvent:FireServer(Part, Part.Position)
							end
						end)
					end
				end
			end
		end,
		['SilentStuff'] = function()
			if Settings.Silent_ShowSilentTarget == true then-- Silent target highlight
				local HitPart = GetClosestPlayer()
				if HitPart then
					local Char = HitPart.Parent
					SilentTargetHightLight.Parent = Char
				else 
					SilentTargetHightLight.Parent = nil
				end
			else
				SilentTargetHightLight.Parent = nil
			end
			
			if Settings.Silent_ShowFOV then--Silent Ball
				Drawing_FOVCircle.Visible = true
				Drawing_FOVCircle.Radius = Settings.Silent_AimFov
				Drawing_FOVCircle.Position = Vector2MousePosition() + Vector2.new(0, 36)
			else
				Drawing_FOVCircle.Visible = false
			end
		end,
		['MovementStuff'] = function()
			if Settings.Movement_InfiniteStamina == true then
				PlayerGui:SetAttribute("Stamina", 100)
			end
		end,
		['GunModStuff'] = function()
			if Settings.GunMod_GamepadRecoil == true and ClientG then
				PlatformHandler.Enabled = false
				ClientG.CurrentInputType = "Gamepad"
			else
				PlatformHandler.Enabled = true
			end
		end,
	}
	for _, Features in Functions do
		task.spawn(Features)
	end
end)

-- // FUNCTION DOCS: 
--[[
    MAIN COMPONENT DOCS:

    -- // local library = loadstring(game:HttpGet(link: url))()
    -- // library.title = text: string
    -- // local Window = library:Init()

    -- [library.title contains rich text]

    -- / library:Remove()
    -- destroys the library

    -- / library:Text("new")
    -- sets the lbrary's text to something new

    - / library:UpdateKeybind(Enum.KeyCode.RightAlt)
    -- sets the lbrary's keybind to switch visibility to something new

    __________________________

    -- // local notificationLibrary = library:InitNotifications()
    -- // local Notification = notificationLibrary:Notify(text: string, time: number, type: string (information, notification, alert, error, success))

    -- [Notify contains rich text]

    -- / 3rd argument is a function, used like this:
    
    Notif:Notify("Function notification", 7, function()
        print("done")
    end)

    -- / Welcome:Text("new text")
    -- sets the notifications text to something differet [ADDS A +0.4 ONTO YOUR TIMER]

    __________________________

    -- // local Wm = library:Watermark(text: string)

    -- [Watermark contains rich text]

    -- / Wm:Hide()
    -- hides the watermark from eye view

    -- / Wm:Show()
    -- makes the watermark visible at the top of your screen

    -- / Wm:Text("new")
    -- sets the watermark's text to something new

    -- / Wm:Remove()
    -- destroys the watermark

    __________________________

    -- // local CombatSection = Init:NewTab(text: string)

    -- [tab title contains rich text]

    -- / CombatSection:Open()
    -- opens the tab you want

    -- / CombatSection:Remove()
    -- destroys the tab

    -- / CombatSection:Hide()
    -- hides the tab from eye view

    -- / CombatSection:Show()
    -- makes the tab visible on the selection table

    -- / CombatSection:Text("new")
    -- sets the tab's text to something new

    __________________________

    -- [label contains rich text]

    -- / Label1:Text("new")
    -- sets the label's text to something new

    -- / Label1:Remove()
    -- destroys the label

    -- / Label1:Hide()
    -- hides the label from eye view

    -- / Label1:Show()
    -- makes the tab visible on the page that is used

    -- / Label1:Align("le")
    -- aligns the label to a new point in text X

    __________________________

    -- [Button contains rich text]

    -- / Button1:AddButton("text", function() end)
    -- adds a new button inside of the frame [CAN ONLY GO UP TO 4 BUTTONS AT A TIME]

    -- / Button1:Fire()
    -- executes the script within the button

    -- / Button1:Text("new")
    -- sets the button's text to something new

    -- / Button1:Hide()
    -- hides the button from eye view

    -- / Button1:Show()
    -- makes the button visible

    -- / Button1:Remove()
    -- destroys the button

    __________________________

    -- [Sections contain rich text]

    -- / Section1:Text("new")
    -- sets the section's text to something new

    -- / Section1:Hide()
    -- hides the section from eye view

    -- / Section1:Show()
    -- makes the section visible

    -- / Section1:Remove()
    -- destroys the section

    __________________________

    -- [Toggles contain rich text]

    -- / Toggle1:Text("new")
    -- sets the toggle's text to something new

    -- / Toggle1:Hide()
    -- hides the toggle from eye view

    -- / Toggle1:Show()
    -- makes the toggle visible

    -- / Toggle1:Remove()
    -- destroys the toggle

    -- / Toggle1:Change()
    -- changes the toggles state to the opposite

    -- / Toggle1:Set(true)
    -- sets the toggle to true even if it is true

    -- / Toggle1:AddKeybind(Enum.KeyCode.P, false, function() end) -- false / true is used for just changing the toggles state
    -- adds a keybind to the toggle

    -- / Toggle1:SetFunction(function() end)
    -- sets the toggles function

    __________________________

    -- [Keybinds contain rich text]

    -- / Keybind1:Text("new")
    -- sets the keybind's text to something new

    -- / Keybind1:Hide()
    -- hides the keybind from eye view

    -- / Keybind1:Show()
    -- makes the keybind visible

    -- / Keybind1:Remove()
    -- destroys the keybind

    -- / Keybind1:SetKey(Enum.KeyCode.P)
    -- sets the keybinds new key

    -- / Keybind1:Fire()
    -- fires the keybind function

    -- / Keybind1:SetFunction(function() end)
    -- sets the new keybind function

    __________________________

    -- [Textboxes contain rich text]

    -- / Textbox1:Input("new")
    -- sets the text box's input to something new

    -- / Textbox1:Place("new")
    -- sets the text box's placeholder to something new

    -- / Textbox1:Fire()
    -- fires the textbox function

    -- / Textbox1:SetFunction(function() end)
    -- sets the text boxes new function

    -- / Textbox1:Text("new")
    -- sets the textbox's text to something new

    -- / Textbox1:Hide()
    -- hides the textbox from eye view

    -- / Textbox1:Show()
    -- makes the textbox visible

    -- / Textbox1:Remove()
    -- destroys the textbox

    __________________________

    -- [Selectors contain rich text]

    -- / Selector1:SetFunction(function() end)
    -- sets the selector new function

    -- / Selector1:Text("new")
    -- sets the selector's text to something new

    -- / Selector1:Hide()
    -- hides the selector from eye view

    -- / Selector1:Show()
    -- makes the selector visible

    -- / Selector1:Remove()
    -- destroys the selector

    __________________________

    -- [Sliders contain rich text]

    -- / Slider1:Value(1)
    -- sets the slider new value

    -- / Slider1:SetFunction(function() end)
    -- sets the slider new function

    -- / Slider1:Text("new")
    -- sets the slider's text to something new

    -- / Slider1:Hide()
    -- hides the slider from eye view

    -- / Slider1:Show()
    -- makes the slider visible

    -- / Slider1:Remove()
    -- destroys the slider

    ---------------------------------------------------------------------------------------------------------

    MISC SEMI USELESS DOCS:

    -- / library.rank = ""
    -- returns the rank you choose (default = "private")

    -- / library.fps
    -- returns FPS you're getting in game

    -- / library.version
    -- returns the version of the library

    -- / library.title = ""
    -- returns the title of the library

    -- / library:GetDay("word") -- word, short, month, year
    -- returns the os day

    -- / library:GetTime("24h") -- 24h, 12h, minute, half, second, full, ISO, zone
    -- returns the os time

    -- / library:GetMonth("word") -- word, short, digit
    -- returns the os month

    -- / library:GetWeek("year_S") -- year_S, day, year_M
    -- returns the os week

    -- / library:GetYear("digits") -- digits, full
    -- returns the os year

    -- / library:GetUsername()
    -- returns the localplayers username

    -- / library:GetUserId()
    -- returns the localplayers userid

    -- / library:GetPlaceId()
    -- returns the games place id

    -- / library:GetJobId()
    -- returns the games job id

    -- / library:CheckIfLoaded()
    -- returns true if you're fully loaded

    -- / library:Rejoin()
    -- rejoins the same server as you was in

    -- / library:Copy("stuff")
    -- copies the inputed string

    -- / library:UnlockFps(500) -- only works with synapse
    -- sets the max fps to something you choose
    
    -- / library:PromptDiscord("invite")
    -- invites you to a discord
]]
