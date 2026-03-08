-- FLING HUB

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local power = 90000

-- GUI
local gui = Instance.new("ScreenGui",game.CoreGui)

local frame = Instance.new("Frame",gui)
frame.Size = UDim2.new(0,250,0,180)
frame.Position = UDim2.new(0.4,0,0.4,0)
frame.BackgroundColor3 = Color3.fromRGB(60,60,60)
frame.Active = true
frame.Draggable = true
frame.BorderSizePixel = 3
frame.BorderColor3 = Color3.new(0,0,0)

local function button(text,y)
	local b = Instance.new("TextButton",frame)
	b.Size = UDim2.new(1,-20,0,30)
	b.Position = UDim2.new(0,10,0,y)
	b.Text = text
	b.BackgroundColor3 = Color3.fromRGB(120,120,120)
	b.BorderSizePixel = 2
	b.BorderColor3 = Color3.new(0,0,0)
	return b
end

local super = button("SUPER FLING",10)
local flingall = button("FLING ALL",50)
local flingname = button("FLING PLAYER",90)

local box = Instance.new("TextBox",frame)
box.Size = UDim2.new(1,-20,0,25)
box.Position = UDim2.new(0,10,0,130)
box.PlaceholderText = "Player Name"
box.Text = ""
box.BorderSizePixel = 2
box.BorderColor3 = Color3.new(0,0,0)

-- fling function
local function fling(target)

	if not target.Character then return end
	
	local thrp = target.Character:FindFirstChild("HumanoidRootPart")
	if not thrp then return end
	
	local bv = Instance.new("BodyVelocity")
	bv.MaxForce = Vector3.new(9e9,9e9,9e9)
	bv.Velocity = Vector3.new(power,power,power)
	bv.Parent = hrp
	
	hrp.CFrame = thrp.CFrame
	
	wait(0.3)
	
	bv:Destroy()

end

-- SUPER FLING (touch)
super.MouseButton1Click:Connect(function()

	local bav = Instance.new("BodyAngularVelocity",hrp)
	bav.MaxTorque = Vector3.new(9e9,9e9,9e9)
	bav.AngularVelocity = Vector3.new(power,power,power)

end)

-- FLING ALL
flingall.MouseButton1Click:Connect(function()

	for _,p in pairs(game.Players:GetPlayers()) do
		if p ~= player then
			fling(p)
			wait(0.3)
		end
	end

end)

-- FLING NAME
flingname.MouseButton1Click:Connect(function()

	for _,p in pairs(game.Players:GetPlayers()) do
		
		if string.lower(p.Name):find(string.lower(box.Text)) then
			
			fling(p)
			
		end
		
	end

end)
