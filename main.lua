while true do
    for _, fruit in pairs(workspace.Fruits:GetChildren()) do
        if fruit:IsA("Tool") and fruit:FindFirstChild("Handle") then
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, fruit.Handle, 0)
            wait(0.1)
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, fruit.Handle, 1)
        end
    end
    wait(1)
