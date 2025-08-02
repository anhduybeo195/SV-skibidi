repeat task.wait() until game:IsLoaded() and game:GetService("Players") and game:GetService("Players").LocalPlayer and game:GetService("Players").LocalPlayer.Character

local scripts = {
    [126884695634066] = "7a953911595e67e8494c3d3446b8be5b", 
    [126509999114328] = "c67687e7d7ae30e2e9fd5658f34e8292",
}
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "SVskibidi"
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local api = loadstring(game:HttpGet("https://sdkapi-public.luarmor.net/library.lua"))()
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/untitled.lua"))()

isLoad = false
local keyFilePath = "Duy.txt"
local colors = {
    background = Color3.fromRGB(20, 20, 25),
    header = Color3.fromRGB(15, 15, 20),
    primary = Color3.fromRGB(40, 40, 50),
    accent = Color3.fromRGB(255, 255, 255),
    text = Color3.fromRGB(240, 240, 240),
    error = Color3.fromRGB(255, 85, 85),
    success = Color3.fromRGB(85, 255, 85),
    discord = Color3.fromRGB(88, 101, 242)
}

local function showNotification(text, color)
    color = color or colors.text
    local screenGui = gui:FindFirstChild("NotificationGui") or Instance.new("ScreenGui")
    screenGui.Name = "NotificationGui"
    screenGui.Parent = gui
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local notification = Instance.new("Frame")
    notification.Name = "Notification"
    notification.BackgroundColor3 = colors.background
    notification.BackgroundTransparency = 0.2
    notification.BorderSizePixel = 0
    notification.Size = UDim2.new(0.25, 0, 0.06, 0)
    notification.Position = UDim2.new(0.85, 0, 0.85, 0)
    notification.AnchorPoint = Vector2.new(0.5, 0.5)
    notification.Parent = screenGui

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8)
    uiCorner.Parent = notification

    local glow = Instance.new("ImageLabel")
    glow.Name = "Glow"
    glow.Image = "rbxassetid://5028857084"
    glow.ImageColor3 = color
    glow.ImageTransparency = 0.8
    glow.ScaleType = Enum.ScaleType.Slice
    glow.SliceCenter = Rect.new(24, 24, 24, 24)
    glow.Size = UDim2.new(1, 20, 1, 20)
    glow.Position = UDim2.new(0, -10, 0, -10)
    glow.BackgroundTransparency = 1
    glow.Parent = notification
    glow.ZIndex = -1

    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "Text"
    textLabel.Text = text
    textLabel.TextColor3 = color
    textLabel.TextSize = 14
    textLabel.BackgroundTransparency = 1
    textLabel.Size = UDim2.new(0.9, 0, 0.8, 0)
    textLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
    textLabel.Font = Enum.Font.GothamMedium
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.Parent = notification

    notification.BackgroundTransparency = 1
    textLabel.TextTransparency = 1

    local appearTween = TweenService:Create(notification, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.2})
    local textAppearTween = TweenService:Create(textLabel, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0})
    appearTween:Play()
    textAppearTween:Play()

    wait(3)

    local disappearTween = TweenService:Create(notification, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1})
    local textDisappearTween = TweenService:Create(textLabel, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1})
    disappearTween:Play()
    textDisappearTween:Play()

    disappearTween.Completed:Connect(function()
        notification:Destroy()
        if #screenGui:GetChildren() == 0 then
            screenGui:Destroy()
        end
    end)
end


if not isLoad then
    local function makeDraggable(frame, dragHandle)
        local dragging = false
        local dragStartPos, frameStartPos
        dragHandle.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStartPos = input.Position
                frameStartPos = frame.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local delta = input.Position - dragStartPos
                frame.Position = UDim2.new(frameStartPos.X.Scale, frameStartPos.X.Offset + delta.X, frameStartPos.Y.Scale, frameStartPos.Y.Offset + delta.Y)
            end
        end)
    end

    local function createButtonEffect(button)
        local originalColor = button.BackgroundColor3
        button.MouseEnter:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(math.min(originalColor.R * 255 + 15, 255), math.min(originalColor.G * 255 + 15, 255), math.min(originalColor.B * 255 + 15, 255))}):Play()
        end)
        button.MouseLeave:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = originalColor}):Play()
        end)
    end



    local glow = Instance.new("ImageLabel")
    glow.Name = "Glow"
    glow.Image = "rbxassetid://5028857084"
    glow.ImageColor3 = colors.accent
    glow.ImageTransparency = 0.9
    glow.ScaleType = Enum.ScaleType.Slice
    glow.SliceCenter = Rect.new(24, 24, 24, 24)
    glow.Size = UDim2.new(1, 20, 1, 20)
    glow.Position = UDim2.new(0, -10, 0, -10)
    glow.BackgroundTransparency = 1
    glow.Parent = keyFrame
    glow.ZIndex = -1

    local keyTitleBar = Instance.new("Frame")
    keyTitleBar.Name = "TitleBar"
    keyTitleBar.Size = UDim2.new(1, 0, 0, 40)
    keyTitleBar.BackgroundColor3 = colors.header
    keyTitleBar.BorderSizePixel = 0
    keyTitleBar.Parent = keyFrame

    local keyTitleCorner = Instance.new("UICorner")
    keyTitleCorner.CornerRadius = UDim.new(0, 12)
    keyTitleCorner.Parent = keyTitleBar


    local keyCloseButton = Instance.new("ImageButton")
    keyCloseButton.Name = "CloseButton"
    keyCloseButton.Size = UDim2.new(0, 24, 0, 24)
    keyCloseButton.Position = UDim2.new(1, -32, 0.5, -12)
    keyCloseButton.BackgroundTransparency = 1
    keyCloseButton.Image = "rbxassetid://3926305904"
    keyCloseButton.ImageColor3 = colors.text
    keyCloseButton.ImageRectOffset = Vector2.new(284, 4)
    keyCloseButton.ImageRectSize = Vector2.new(24, 24)
    keyCloseButton.Parent = keyTitleBar

    local inputFrame = Instance.new("Frame")
    inputFrame.Name = "InputFrame"
    inputFrame.Size = UDim2.new(1, -40, 0, 50)
    inputFrame.Position = UDim2.new(0, 20, 0, 60)
    inputFrame.BackgroundColor3 = colors.primary
    inputFrame.BorderSizePixel = 0
    inputFrame.Parent = keyFrame

    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 8)
    inputCorner.Parent = inputFrame

    local discordCorner = Instance.new("UICorner")
    discordCorner.CornerRadius = UDim.new(0, 8)
    discordCorner.Parent = discordButton

    createButtonEffect(submitButton)
    createButtonEffect(discordButton)

    keyCloseButton.MouseButton1Click:Connect(function()
        local tween = TweenService:Create(keyFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)})
        tween:Play()
        tween.Completed:Wait()
        gui:Destroy()
    end)

    makeDraggable(keyFrame, keyTitleBar)

    keyFrame.BackgroundTransparency = 1
    keyFrame.Size = UDim2.new(0, 0, 0, 0)
    keyFrame.Parent = gui

    local openTween = TweenService:Create(keyFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0.2,
        Size = UDim2.new(0, 400, 0, 220),
        Position = UDim2.new(0.5, 0, 0.5, -110)
    })
    openTween:Play()
end
