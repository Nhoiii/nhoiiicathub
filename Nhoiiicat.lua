repeat task.wait() until game.Players.LocalPlayer.Character

local player = game.Players.LocalPlayer
local char = player.Character
local hrp = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")

local flying = false
local speed = 70
local bv
local bg

-- GUI
local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0,160,0,90)
frame.Position = UDim2.new(0,40,0,200)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1,0,0,30)
title.Text = "DELTA FLY"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)

local button = Instance.new("TextButton")
button.Parent = frame
button.Size = UDim2.new(0.8,0,0,35)
button.Position = UDim2.new(0.1,0,0.5,0)
button.Text = "FLY : OFF"

-- Fly Functions

function startFly()

    flying = true

    bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(9e9,9e9,9e9)
    bv.Velocity = Vector3.new(0,0,0)
    bv.Parent = hrp

    bg = Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
    bg.CFrame = hrp.CFrame
    bg.Parent = hrp

    hum.PlatformStand = true

    game:GetService("RunService").RenderStepped:Connect(function()

        if flying then

            local cam = workspace.CurrentCamera
            local move = Vector3.new()

            if hum.MoveDirection.Magnitude > 0 then
                move = cam.CFrame.LookVector * speed
            end

            bv.Velocity = move
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

button.MouseButton1Click:Connect(function()

    if flying then
        stopFly()
        button.Text = "FLY : OFF"
    else
        startFly()
        button.Text = "FLY : ON"
    end

end)
