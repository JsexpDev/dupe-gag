loadstring([[
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Usuń stare GUI
local oldGui = playerGui:FindFirstChild("ScriptHubGUI")
if oldGui then oldGui:Destroy() end

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ScriptHubGUI"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 100
screenGui.Parent = playerGui

-- Panel główny (ukryty)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,280,0,160)
frame.Position = UDim2.new(0.5,-140,0.5,-80)
frame.BackgroundColor3 = Color3.fromRGB(10,15,10)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5,0.5)
frame.Visible = false
frame.Parent = screenGui

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0,12)

local stroke = Instance.new("UIStroke", frame)
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(0,255,100)

-- Gradient
local gradient = Instance.new("UIGradient", frame)
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20,40,20)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(5,10,5))
}
gradient.Rotation = 45

-- Tytuł
local label = Instance.new("TextLabel", frame)
label.Size = UDim2.new(1,0,0,40)
label.Text = "SCRIPT HUB v3"
label.TextColor3 = Color3.fromRGB(0,255,120)
label.Font = Enum.Font.Code
label.TextScaled = true
label.BackgroundTransparency = 1

-- Zamknij
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

-- Ikona menu (widoczna od startu)
local iconBtn = Instance.new("TextButton")
iconBtn.Size = UDim2.new(0,50,0,50)
iconBtn.Position = UDim2.new(0,15,1,-65)
iconBtn.Text = "≡"
iconBtn.Font = Enum.Font.Code
iconBtn.TextScaled = true
iconBtn.BackgroundColor3 = Color3.fromRGB(15,15,15)
iconBtn.TextColor3 = Color3.fromRGB(0,255,100)
local iCorner = Instance.new("UICorner", iconBtn)
iCorner.CornerRadius = UDim.new(0,12)
iconBtn.Parent = screenGui

-- Panel przycisków
local buttonHolder = Instance.new("Frame", frame)
buttonHolder.Size = UDim2.new(1,-40,1,-50)
buttonHolder.Position = UDim2.new(0,20,0,45)
buttonHolder.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", buttonHolder)
layout.Padding = UDim.new(0,12)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Top

-- Funkcja do tworzenia przycisków
local function createButton(text, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.85,0,0,38)
    btn.Text = text
    btn.Font = Enum.Font.Code
    btn.TextScaled = true
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.fromRGB(230,230,230)
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0,8)

    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = color:Lerp(Color3.fromRGB(0,255,0),0.25)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = color
    end)

    btn.MouseButton1Click:Connect(callback)
    btn.Parent = buttonHolder
end

-- Funkcje mechaniczne
local function Dupe()
    local char = player.Character
    if not char then return end
    local tool = char:FindFirstChildOfClass("Tool")
    if not tool then
        warn("Nie masz narzędzia w ręce!")
        return
    end
    local clone = Instance.new("Tool")
    clone.Name = tool.Name
    clone.Parent = player.Backpack
end

local function KillMe()
    local char = player.Character
    if char then
        char:BreakJoints()
    end
end

-- Dodajemy przyciski
createButton("Dupe Tool", Color3.fromRGB(0,100,180), Dupe)
createButton("Self Destruct", Color3.fromRGB(150,40,40), KillMe)

-- Animacja otwierania / zamykania
local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
iconBtn.MouseButton1Click:Connect(function()
    frame.Visible = true
    iconBtn.Visible = false
    frame.Position = UDim2.new(0.5,-140,0.6,-80)
    TweenService:Create(frame, tweenInfo, {Position = UDim2.new(0.5,-140,0.5,-80)}):Play()
end)

closeBtn.MouseButton1Click:Connect(function()
    local tween = TweenService:Create(frame, tweenInfo, {Position = UDim2.new(0.5,-140,0.6,-80)})
    tween:Play()
    tween.Completed:Connect(function()
        frame.Visible = false
        iconBtn.Visible = true
    end)
end)
]])()