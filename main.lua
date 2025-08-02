-- 📦 Cấu hình
local SELL_PRICE_PER_FRUIT = 5
local SELL_THRESHOLD = 200

-- 🧠 Dịch vụ
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- 🧍 Lấy LocalPlayer an toàn
local player = Players.LocalPlayer
while not player or not player:IsDescendantOf(game) do
    RunService.RenderStepped:Wait()
    player = Players.LocalPlayer
end

-- 🖥️ Tạo GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoSellUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0, 20, 0, 20)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Text = "Auto Sell"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 24
title.Parent = mainFrame

-- 🔘 Nút: Tự động bán hết
local sellAllToggle = Instance.new("TextButton")
sellAllToggle.Text = "🔁 Tự động bán hết"
sellAllToggle.Size = UDim2.new(1, -20, 0, 40)
sellAllToggle.Position = UDim2.new(0, 10, 0, 50)
sellAllToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
sellAllToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
sellAllToggle.Font = Enum.Font.SourceSans
sellAllToggle.TextSize = 18
sellAllToggle.Parent = mainFrame

-- 🔘 Nút: Bán khi kho > 200
local sellFullToggle = Instance.new("TextButton")
sellFullToggle.Text = "📦 Bán khi kho > 200"
sellFullToggle.Size = UDim2.new(1, -20, 0, 40)
sellFullToggle.Position = UDim2.new(0, 10, 0, 100)
sellFullToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
sellFullToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
sellFullToggle.Font = Enum.Font.SourceSans
sellFullToggle.TextSize = 18
sellFullToggle.Parent = mainFrame

-- 🔄 Trạng thái
local autoSellAll = false
local autoSellWhenFull = false

sellAllToggle.MouseButton1Click:Connect(function()
    autoSellAll = not autoSellAll
    sellAllToggle.BackgroundColor3 = autoSellAll and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
end)

sellFullToggle.MouseButton1Click:Connect(function()
    autoSellWhenFull = not autoSellWhenFull
    sellFullToggle.BackgroundColor3 = autoSellWhenFull and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
end)

-- 📊 Hàm kiểm tra kho
local function getFruitInventory()
    return player:FindFirstChild("FruitInventory")
end

local function getTotalFruitCount()
    local inventory = getFruitInventory()
    if not inventory then return 0 end

    local total = 0
    for _, fruit in pairs(inventory:GetChildren()) do
        if fruit:IsA("IntValue") then
            total += fruit.Value
        end
    end
    return total
end

local function isInventoryOverLimit()
    return getTotalFruitCount() > SELL_THRESHOLD
end

-- 💰 Hàm bán trái cây
local function sellFruits()
    local inventory = getFruitInventory()
    if not inventory then return end

    local totalSold = 0
    for _, fruit in pairs(inventory:GetChildren()) do
        if fruit:IsA("IntValue") and fruit.Value > 0 then
            totalSold += fruit.Value
            fruit.Value = 0
        end
    end

    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats and leaderstats:FindFirstChild("Coins") then
        leaderstats.Coins.Value += totalSold * SELL_PRICE_PER_FRUIT
    end

    print("Đã bán " .. totalSold .. " trái cây. Nhận " .. (totalSold * SELL_PRICE_PER_FRUIT) .. " Coins.")
end

-- 🔁 Kiểm tra liên tục
RunService.RenderStepped:Connect(function()
    if autoSellAll then
        sellFruits()
    elseif autoSellWhenFull and isInventoryOverLimit() then
        sellFruits()
    end
end)
