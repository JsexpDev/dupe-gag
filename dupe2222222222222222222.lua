loadstring([[
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Tworzymy ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ScriptHubDupeGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Funkcja tworzenia GUI komunikatu
local function ShowMessage(text, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 320, 0, 130)
    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
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
    frame.Position = UDim2.new(0.5, 0, 0.55, 0)
    TweenService:Create(frame, tweenInfo, {Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()

    closeBtn.MouseButton1Click:Connect(function()
        local tween = TweenService:Create(frame, tweenInfo, {Position = UDim2.new(0.5,0,0.55,0)})
        tween:Play()
        tween.Completed:Connect(function()
            frame:Destroy()
            if callback then callback() end
        end)
    end)
end

-- Funkcja do paska postępu
local function ShowProgress(callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 400, 0, 60)
    frame.Position = UDim2.new(0.5,0,0.5,0)
    frame.AnchorPoint = Vector2.new(0.5,0.5)
    frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui

    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0,12)

    local stroke = Instance.new("UIStroke", frame)
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(0,255,120)

    local progressBar = Instance.new("Frame", frame)
    progressBar.Size = UDim2.new(0,0,1,0)
    progressBar.Position = UDim2.new(0,0,0,0)
    progressBar.BackgroundColor3 = Color3.fromRGB(0,255,120)
    local barCorner = Instance.new("UICorner", progressBar)
    barCorner.CornerRadius = UDim.new(0,12)

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1,0,1,0)
    label.Position = UDim2.new(0,0,0,0)
    label.Text = "Dupe 0%"
    label.TextColor3 = Color3.fromRGB(0,0,0)
    label.Font = Enum.Font.Code
    label.TextScaled = true
    label.BackgroundTransparency = 1

    -- Animacja postępu
    spawn(function()
        for i=0,100 do
            progressBar.Size = UDim2.new(i/100,0,1,0)
            label.Text = "Dupe "..i.."%"
            task.wait(0.03)
        end
        frame:Destroy()
        if callback then callback() end
    end)
end

-- Uruchamiamy komunikaty i pasek postępu
ShowMessage("Hey! Hello to Script Hub Dupe!", function()
    task.wait(0.2)
    ShowMessage("Dupe Starting!", function()
        task.wait(0.2)
        ShowProgress()
    end)
end)
]])()
