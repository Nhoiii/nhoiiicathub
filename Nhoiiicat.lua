

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

--// Anti AFK
local VirtualUser = game:GetService("VirtualUser")
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

--// Rejoin if kicked
local TeleportService = game:GetService("TeleportService")
local PlaceId = game.PlaceId

local function Rejoin()
    TeleportService:Teleport(PlaceId, LocalPlayer)
end

--// Auto Farm Example
local AutoFarm = false

spawn(function()
    while task.wait(0.2) do
        if AutoFarm then
            for i,v in pairs(workspace.Enemies:GetChildren()) do
                if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
                    repeat task.wait()
                        HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0,5)
                        v.Humanoid:TakeDamage(5)
                    until v.Humanoid.Health <= 0 or not AutoFarm
                end
            end
        end
    end
end)

--// Simple GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0,200,0,100)
Frame.Position = UDim2.new(0,50,0,50)
Frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
Frame.Parent = ScreenGui

local Button = Instance.new("TextButton")
Button.Size = UDim2.new(1,0,0,40)
Button.Position = UDim2.new(0,0,0,30)
Button.Text = "Auto Farm: OFF"
Button.Parent = Frame

Button.MouseButton1Click:Connect(function()
    AutoFarm = not AutoFarm
    if AutoFarm then
        Button.Text = "Auto Farm: ON"
    else
        Button.Text = "Auto Farm: OFF"
    end
end)

print("Script Loaded Successfully")
