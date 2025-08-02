-- MainHub.lua
local GuiService = game:GetService("GuiService")

-- Giao diện chính
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SVSkibidiUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Name = "MainFrame"
Frame.Size = UDim2.new(0, 350, 0, 200)
Frame.Position = UDim2.new(0.5, -175, 0.5, -100)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "🎮 SV-skibidi Hub"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Parent = Frame

-- Nút tính năng
local Button = Instance.new("TextButton")
Button.Size = UDim2.new(0.8, 0, 0, 40)
Button.Position = UDim2.new(0.1, 0, 0.5, 0)
Button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
Button.Text = "🛒 Auto Sell Trái Cây"
Button.TextColor3 = Color3.new(1, 1, 1)
Button.Font = Enum.Font.GothamSemibold
Button.TextSize = 16
Button.Parent = Frame

-- Tính năng: Auto Sell
local autoSellRunning = false
Button.MouseButton1Click:Connect(function()
    autoSellRunning = not autoSellRunning
    Button.Text = autoSellRunning and "🛑 Dừng Auto Sell" or "🛒 Auto Sell Trái Cây"

    while autoSellRunning do
        task.wait(2)
        local args = {
            [1] = "SellAllFruits"
        }
        game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
    end
end)
