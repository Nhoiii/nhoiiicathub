repeat task.wait() until game.Players.LocalPlayer.Character

local player = game.Players.LocalPlayer
local char = player.Character
local hum = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")

local flying = false
local speed = 60
local upHold = false
local downHold = false

local bv
local bg

-- GUI
local gui = Instance.new("ScreenGui",game.CoreGui)

local frame = Instance.new("Frame",gui)
frame.Size = UDim2.new(0,220,0,200)
frame.Position = UDim2.new(0,50,0,200)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel",frame)
title.Size = UDim2.new(1,0,0,35)
title.Text = "FLY HUB"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.TextScaled = true

-- Fly Button
local fly = Instance.new("TextButton",frame)
fly.Size = UDim2.new(0.8,0,0,35)
fly.Position = UDim2.new(0.1,0,0.25,0)
fly.Text = "Fly : OFF"

-- Speed Box
local speedBox = Instance.new("TextBox",frame)
speedBox.Size = UDim2.new(0.8,0,0,30)
speedBox.Position = UDim2.new(0.1,0,0.5,0)
speedBox.Text = "60"

-- Up
local up = Instance.new("TextButton",frame)
up.Size = UDim2.new(0.35,0,0,30)
up.Position = UDim2.new(0.1,0,0.75,0)
up.Text = "UP"

-- Down
local down = Instance.new("TextButton",frame)
down.Size = UDim2.new(0.35,0,0,30)
down.Position = UDim2.new(0.55,0,0.75,0)
down.Text = "DOWN"

speedBox.FocusLost:Connect(function()
	local num = tonumber(speedBox.Text)
	if num then
		speed = math.clamp(num,20,200)
	end
	speedBox.Text = tostring(speed)
end)

function startFly()

	flying = true

	bv = Instance.new("BodyVelocity")
	bv.MaxForce = Vector3.new(9e9,9e9,9e9)
	bv.Parent = hrp

	bg = Instance.new("BodyGyro")
	bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
	bg.Parent = hrp

	hum.PlatformStand = true

	game:GetService("RunService").RenderStepped:Connect(function()

		if flying then

			local cam = workspace.CurrentCamera
			local move = hum.MoveDirection

			local vertical = 0

			if upHold then
				vertical = speed
			elseif downHold then
				vertical = -speed
			end

			bv.Velocity =
				cam.CFrame.LookVector * move.Magnitude * speed +
				Vector3.new(0,vertical,0)

			bg.CFrame = cam.CFrame

		end

	end)

end

function stopFly()

	flying = false
	hum.PlatformStand = false

	if bv then bv:Destroy() end
	if bg then bg:Destroy() end

end

fly.MouseButton1Click:Connect(function()

	if flying then
		stopFly()
		fly.Text = "Fly : OFF"
	else
		startFly()
		fly.Text = "Fly : ON"
	end

end)

-- Hold UP
up.MouseButton1Down:Connect(function()
	upHold = true
end)

up.MouseButton1Up:Connect(function()
	upHold = false
end)

-- Hold DOWN
down.MouseButton1Down:Connect(function()
	downHold = true
end)

down.MouseButton1Up:Connect(function()
	downHold = false
end)
