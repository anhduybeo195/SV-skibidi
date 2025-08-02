-- Tải thư viện Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()

local Window = Rayfield:CreateWindow({
   Name = "🌱 Grow Garden Hub",
   LoadingTitle = "Grow Script đang khởi động...",
   LoadingSubtitle = "by Anh Duy",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "GrowGarden",
      FileName = "config"
   },
   Discord = {
      Enabled = false
   },
   KeySystem = false
})

-- Tạo tab "Auto"
local AutoTab = Window:CreateTab("🌾 AutoFarm", 4483362458)

-- Nút bật/tắt AutoFarm
AutoTab:CreateToggle({
   Name = "Auto Thu Hoạch Trái Cây",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().AutoFarm = Value
      while getgenv().AutoFarm do
         for _, fruit in pairs(workspace.Fruits:GetChildren()) do
            if fruit:IsA("Tool") and fruit:FindFirstChild("Handle") then
               firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, fruit.Handle, 0)
               wait(0.2)
               firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, fruit.Handle, 1)
            end
         end
         wait(1)
      end
   end
})

-- Nút bán trái cây thủ công
AutoTab:CreateButton({
   Name = "💰 Bán trái cây ngay",
   Callback = function()
      game:GetService("ReplicatedStorage").Remotes.SellFruits:FireServer()
   end
})
