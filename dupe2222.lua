-- Usuwamy stare GUI jeśli istnieje
local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local oldGui = playerGui:FindFirstChild("ScriptHubGUI")
if oldGui then
    oldGui:Destroy()
end

-- Tworzymy nowe GUI
local Workspace = game:GetService("Workspace")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ScriptHubGUI"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 100
screenGui.Parent = playerGui

-- === Główne okno ===
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,420,0,220)
frame.Position = UDim2.new(0.5,-210,0.5,-110)
frame.BackgroundColor3 = Color3.fromRGB(15,15,20) -- bardzo ciemny
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5,0.5)
frame.Parent = screenGui

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0,18)

local stroke = Instance.new("UIStroke", frame)
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(0,150,255) -- neon niebieski

-- Tytuł
local label = Instance.new("TextLabel", frame)
label.Size = UDim2.new(1,0,0,60)
label.Text = "SCRIPT HUB v2"
label.TextColor3 = Color3.fromRGB(230,230,230)
label.Font = Enum.Font.GothamBold
label.TextScaled = true
label.BackgroundTransparency = 1

-- Zamknij
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0,35,0,35)
closeBtn.Position = UDim2.new(1,-40,0,5)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextScaled = true
closeBtn.BackgroundColor3 = Color3.fromRGB(50,0,0)
closeBtn.TextColor3 = Color3.fromRGB(200,80,80)
local cCorner = Instance.new("UICorner", closeBtn)
cCorner.CornerRadius = UDim.new(0,8)

-- Ikona menu
local iconBtn = Instance.new("TextButton")
iconBtn.Size = UDim2.new(0,45,0,45)
iconBtn.Position = UDim2.new(0,15,0.5,-22)
iconBtn.Text = "≡"
iconBtn.Font = Enum.Font.GothamBold
iconBtn.TextScaled = true
iconBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
iconBtn.TextColor3 = Color3.fromRGB(200,200,200)
local iCorner = Instance.new("UICorner", iconBtn)
iCorner.CornerRadius = UDim.new(0,10)
iconBtn.Visible = false
iconBtn.Parent = screenGui

-- Panel przycisków
local buttonHolder = Instance.new("Frame", frame)
buttonHolder.Size = UDim2.new(1,-40,1,-70)
buttonHolder.Position = UDim2.new(0,20,0,60)
buttonHolder.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", buttonHolder)
layout.Padding = UDim.new(0,15)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Top

-- Funkcja do robienia przycisków
local function createButton(text, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.8,0,0,45)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.fromRGB(240,240,240)

    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0,10)

    -- efekt hover
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = color:Lerp(Color3.fromRGB(255,255,255),0.2)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = color
    end)

    btn.Parent = buttonHolder
    return btn
end

-- === Przyciski ===
local dupeBtn = createButton("Dupe Tool", Color3.fromRGB(0,120,200))
local lagBtn = createButton("Lag Game", Color3.fromRGB(200,160,40))
local killBtn = createButton("Self Destruct", Color3.fromRGB(180,50,50))

-- === Funkcje ===
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

local function LagGame()
    for i=1,10 do
        Workspace.Gravity = 0
        task.wait(0.05)
        Workspace.Gravity = 196.2
    end
end

local function KillMe()
    local char = player.Character
    if char then
        char:BreakJoints()
    end
end

-- === Połączenia ===
closeBtn.MouseButton1Click:Connect(function()
    frame.Visible = false
    iconBtn.Visible = true
end)

iconBtn.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
    iconBtn.Visible = not frame.Visible
end)

dupeBtn.MouseButton1Click:Connect(Dupe)
lagBtn.MouseButton1Click:Connect(LagGame)
killBtn.MouseButton1Click:Connect(KillMe)
