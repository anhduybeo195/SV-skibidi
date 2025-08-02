--------------------------------------------------------------------
-- CONFIG – chỉnh 3 giá trị này là xong
--------------------------------------------------------------------
local REMOTE_PATH     = "ReplicatedStorage.Sell_Inventory" -- đường dẫn RemoteEvent bán
local REMOTE_ARGS     = {}                                 -- {arg1, arg2, ...} nếu server cần
local ITEM_CONTAINERS = {"Backpack", "Character"}          -- nơi chứa trái cây
--------------------------------------------------------------------

local plr         = game:GetService("Players").LocalPlayer
local runService  = game:GetService("RunService")
local remote      = REMOTE_PATH:split(".")
for i = 1, #remote-1 do
    remote = game:GetService(remote[i]) or plr[remote[i]] or remote[i]
end
remote = remote[#remote]

--------------------------------------------------------------------
-- UI toggle
--------------------------------------------------------------------
local ui = Instance.new("ScreenGui", plr.PlayerGui)
ui.Name, ui.ResetOnSpawn = "AutoSellAll_GUI", false

local btn = Instance.new("TextButton", ui)
btn.Size = UDim2.fromOffset(160, 40)
btn.Position = UDim2.new(0.5, -80, 0.5, -20)
btn.Text = "🔁 Auto Sell: OFF"
btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
btn.TextColor3, btn.Font, btn.TextSize = Color3.new(1,1,1), Enum.Font.GothamBold, 16
btn.Active, btn.Draggable = true, true

local selling = false
btn.MouseButton1Click:Connect(function()
    selling = not selling
    btn.Text = selling and "✅ Auto Sell: ON" or "🔁 Auto Sell: OFF"
    btn.BackgroundColor3 = selling and Color3.fromRGB(0,170,0) or Color3.fromRGB(60,60,60)
end)

--------------------------------------------------------------------
-- Core loop
--------------------------------------------------------------------
local function destroyLocalItems()
    for _, containerName in ipairs(ITEM_CONTAINERS) do
        local container = plr:FindFirstChild(containerName)
        if container then
            for _, it in ipairs(container:GetChildren()) do
                if it:IsA("Tool") then
                    it:Destroy()
                end
            end
        end
    end
end

local function sell()
    -- 1) Thử gọi RemoteEvent
    if typeof(remote) == "Instance" and remote:IsA("RemoteEvent") then
        remote:FireServer(table.unpack(REMOTE_ARGS))
    end
    -- 2) Xoá local để chắc chắn trống kho
    destroyLocalItems()
end

runService.Heartbeat:Connect(function()
    if selling then
        sell()
    end
end)
