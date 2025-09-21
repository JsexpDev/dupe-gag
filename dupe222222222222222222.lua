loadstring([[
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- Tworzymy ScreenGui na pewno
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ScriptHubDupeGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Funkcja tworzenia GUI komunikatu
local function ShowMessage(text, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 320, 0, 130)
    frame.Position = UDim2.new(0.5, -160, 0.4, -65)
    frame.AnchorPoint = Vector2.new(0.5,0.5)
    frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui

    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0,14)

    local stroke = Instance.new("UIStroke", frame)
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(0,255,120)

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1, -20, 0, 80)
    label.Position = UDim2.new(0, 10, 0, 20)
    label.Text = text
    label.TextColor3 = Color3.fromRGB(0,255,120)
    label.Font = Enum.Font.Code
    label.TextScaled = true
    label.BackgroundTransparency = 1

    local closeBtn = Instance.new("TextButton", frame)
    closeBtn.Size = UDim2.new(0,30,0,30)
    closeBtn.Position = UDim2.new(1,-35,0,5)
    closeBtn.Text = "X"
    closeBtn.Font = Enum.Font.Code
    closeBtn.TextScaled = true
    closeBtn.BackgroundColor3 = Color3.fromRGB(20,0,0)
    closeBtn.TextColor3 = Color3.fromRGB(255,60,60)
    local cCorner = Instance.new("UICorner", closeBtn)
    cCorner.CornerRadius = UDim.new(0,6)

    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    frame.Position = UDim2.new(0.5, -160, 0.45, -65)
    TweenService:Create(frame, tweenInfo, {Position = UDim2.new(0.5, -160, 0.4, -65)}):Play()

    closeBtn.MouseButton1Click:Connect(function()
        local tween = TweenService:Create(frame, tweenInfo, {Position = UDim2.new(0.5,-160,0.45,-65)})
        tween:Play()
        tween.Completed:Connect(function()
            frame:Destroy()
            if callback then callback() end
        end)
    end)
end

-- Funkcja kopiowania narzędzia
spawn(function()
    local toolCopied = false
    while not toolCopied do
        local char = player.Character
        if char then
            local tool = char:FindFirstChildOfClass("Tool")
            if tool then
                local backpack = player:FindFirstChild("Backpack") or player:WaitForChild("Backpack")
                local clone = tool:Clone()
                clone.Parent = backpack
                print("Tool dupe successful: "..clone.Name)
                toolCopied = true
            end
        end
        RunService.Heartbeat:Wait()
    end
end)

-- Wyświetlamy komunikaty po kolei
ShowMessage("Hey! Hello to Script Hub Dupe!", function()
    task.wait(0.2)
    ShowMessage("Dupe Starting!", function() end)
end)
]])()