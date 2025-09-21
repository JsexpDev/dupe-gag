loadstring([[
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Funkcja do natychmiastowego GUI
local function ShowMessage(text, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0,300,0,120)
    frame.Position = UDim2.new(0.5,-150,0.3,-60)
    frame.AnchorPoint = Vector2.new(0.5,0.5)
    frame.BackgroundColor3 = Color3.fromRGB(10,15,10)
    frame.BorderSizePixel = 0
    frame.Parent = playerGui

    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0,12)

    local stroke = Instance.new("UIStroke", frame)
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(0,255,100)

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1,0,0,70)
    label.Position = UDim2.new(0,0,0,20)
    label.Text = text
    label.TextColor3 = Color3.fromRGB(0,255,120)
    label.Font = Enum.Font.Code
    label.TextScaled = true
    label.BackgroundTransparency = 1

    local closeBtn = Instance.new("TextButton", frame)
    closeBtn.Size = UDim2.new(0,28,0,28)
    closeBtn.Position = UDim2.new(1,-33,0,5)
    closeBtn.Text = "X"
    closeBtn.Font = Enum.Font.Code
    closeBtn.TextScaled = true
    closeBtn.BackgroundColor3 = Color3.fromRGB(20,0,0)
    closeBtn.TextColor3 = Color3.fromRGB(255,60,60)
    local cCorner = Instance.new("UICorner", closeBtn)
    cCorner.CornerRadius = UDim.new(0,6)

    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(frame, tweenInfo, {Position = UDim2.new(0.5,-150,0.3,-60)}):Play()

    closeBtn.MouseButton1Click:Connect(function()
        local tween = TweenService:Create(frame, tweenInfo, {Position = UDim2.new(0.5,-150,0.35,-60)})
        tween:Play()
        tween.Completed:Connect(function()
            frame:Destroy()
            if callback then callback() end
        end)
    end)
end

-- Funkcja kopiowania narzędzia w tle
local function DupeTool()
    -- aktywnie czekamy na Character
    local char = player.Character
    while not char do
        player.CharacterAdded:Wait()
        char = player.Character
    end

    local backpack = player:WaitForChild("Backpack")
    local tool
    local t0 = tick()
    repeat
        tool = char:FindFirstChildOfClass("Tool")
        RunService.Heartbeat:Wait()
    until tool or tick()-t0 > 10 -- max 10 sekund czekania

    if tool then
        local clone = tool:Clone()
        clone.Parent = backpack
        print("Tool dupe successful: "..clone.Name)
    else
        warn("Nie znaleziono narzędzia w ręce.")
    end
end

-- Uruchamiamy GUI i dupe
ShowMessage("Hey! Hello to Script Hub Dupe!", function()
    task.wait(0.2)
    ShowMessage("Dupe Starting!", function() end)
    DupeTool()
end)
]])()
