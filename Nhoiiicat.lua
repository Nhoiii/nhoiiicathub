--// NhoiiiCat Hub 
--// Made for Blox Fruits

repeat wait() until game:IsLoaded()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- UI LIB
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

local Window = Library:MakeWindow({
	Name = "NhoiiiCat Hub | Blox Fruits",
	HidePremium = false,
	SaveConfig = false,
	ConfigFolder = "NhoiiiCatHub"
})

-- Variables
_G.AutoFarm = false
_G.AutoLevel = false
_G.FruitSniper = false

---------------------------------------------------
-- MAIN TAB
---------------------------------------------------

local MainTab = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

MainTab:AddToggle({
	Name = "Auto Farm",
	Default = false,
	Callback = function(v)
		_G.AutoFarm = v
	end
})

MainTab:AddToggle({
	Name = "Auto Level",
	Default = false,
	Callback = function(v)
		_G.AutoLevel = v
	end
})

---------------------------------------------------
-- FRUIT TAB
---------------------------------------------------

local FruitTab = Window:MakeTab({
	Name = "Fruit",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

FruitTab:AddToggle({
	Name = "Fruit Sniper",
	Default = false,
	Callback = function(v)
		_G.FruitSniper = v
	end
})

---------------------------------------------------
-- TELEPORT TAB
---------------------------------------------------

local TeleportTab = Window:MakeTab({
	Name = "Teleport",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Islands = {
	["Starter Island"] = CFrame.new(100,10,100),
	["Jungle"] = CFrame.new(-1600,20,150),
	["Desert"] = CFrame.new(1100,10,4300),
	["Snow Island"] = CFrame.new(1300,20,-1200),
	["Marine"] = CFrame.new(-2500,20,2000),
	["Sky Island"] = CFrame.new(-5000,400,3000)
}

for name,cf in pairs(Islands) do
	TeleportTab:AddButton({
		Name = name,
		Callback = function()
			local char = LocalPlayer.Character
			if char and char:FindFirstChild("HumanoidRootPart") then
				char.HumanoidRootPart.CFrame = cf
			end
		end
	})
end

---------------------------------------------------
-- AUTO FARM
---------------------------------------------------

spawn(function()
	while wait(0.5) do
		if _G.AutoFarm then
			for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
				if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
					
					repeat wait()

						local hrp = LocalPlayer.Character.HumanoidRootPart
						hrp.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0,3)

						game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0))
						game:GetService("VirtualUser"):Button1Up(Vector2.new(0,0))

					until v.Humanoid.Health <= 0 or not _G.AutoFarm
				end
			end
		end
	end
end)

---------------------------------------------------
-- AUTO LEVEL
---------------------------------------------------

spawn(function()
	while wait(5) do
		if _G.AutoLevel then
			local quest = game:GetService("ReplicatedStorage").Remotes.CommF_
			pcall(function()
				quest:InvokeServer("StartQuest","BanditQuest1",1)
			end)
		end
	end
end)

---------------------------------------------------
-- FRUIT SNIPER
---------------------------------------------------

spawn(function()
	while wait(2) do
		if _G.FruitSniper then
			for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
				if string.find(v.Name,"Fruit") then
					LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
				end
			end
		end
	end
end)

---------------------------------------------------

Library:Init()
