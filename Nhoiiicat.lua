-- Simple Roblox Key System

local correctKey = "NHOOIICAT-123"

local gui = Instance.new("ScreenGui", game.CoreGui)

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,300,0,150)
frame.Position = UDim2.new(0.5,-150,0.5,-75)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,40)
title.Text = "Enter Key"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1

local box = Instance.new("TextBox", frame)
box.Size = UDim2.new(0.8,0,0,35)
box.Position = UDim2.new(0.1,0,0.4,0)
box.PlaceholderText = "Enter Key Here"
box.Text = ""

local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(0.6,0,0,35)
button.Position = UDim2.new(0.2,0,0.7,0)
button.Text = "Submit"

button.MouseButton1Click:Connect(function()

    if box.Text == correctKey then
        
        frame:Destroy()

        -- load script after key correct
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()

    else
        box.Text = ""
        box.PlaceholderText = "Wrong Key"
    end

end)
