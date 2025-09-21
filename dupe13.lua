loadstring([[
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

-- Folder na wizualne kopie
local SPAWN_FOLDER = Workspace:FindFirstChild("BrainRotCopies")
if not SPAWN_FOLDER then
    SPAWN_FOLDER = Instance.new("Folder", Workspace)
    SPAWN_FOLDER.Name = "BrainRotCopies"
end

-- Licznik kopii
local copyIndex = 0

-- Funkcja Dupe
local function Dupe()
    local character = player.Character
    if not character then return end
    local hand = character:FindFirstChild("RightHand") or character:FindFirstChild("Hand") or character:FindFirstChildWhichIsA("Part")
    if not hand then return end
    copyIndex = copyIndex + 1
    local part = Instance.new("Part")
    part.Size = Vector3.new(2,2,2)
    part.Position = hand.Position + Vector3.new(2,0,0)
    part.Color = Color3.fromRGB(200,50,50)
    part.Anchored = false
    part.Material = Enum.Material.Neon
    part.Name = "BrainRotCopy"..copyIndex
    part.Parent = SPAWN_FOLDER
    print("BrainRot skopiowany lokalnie!")
end

-- Funkcja Lag Game (lokalny wizualny lag)
local function LagGame()
    for i=1,15 do
        workspace.Gravity = 0
        wait(0.05)
        workspace.Gravity = 196.2
    end
    print("Game 'lagged' locally!")
end

-- === Ikona 🌶 po zamknięciu powitania ===
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "DupeIconGUI"

local iconBtn = Instance.new("TextButton", screenGui)
iconBtn.Size = UDim2.new(0,50,0,50)
iconBtn.Position = UDim2.new(0,10,0.5,-25)
iconBtn.Text = "🌶"
iconBtn.Font = Enum.Font.GothamBold
iconBtn.TextScaled = true
iconBtn.BackgroundColor3 = Color3.fromRGB(50,200,100)
iconBtn.TextColor3 = Color3.fromRGB(255,255,255)
local iconCorner = Instance.new("UICorner", iconBtn)
iconCorner.CornerRadius = UDim.new(0,15)
iconBtn.Visible = false

-- === Pierwsze powitanie ===
local welcomeGUI = Instance.new("ScreenGui", player.PlayerGui)
welcomeGUI.Name = "WelcomeGUI"

local frame = Instance.new("Frame", welcomeGUI)
frame.Size = UDim2.new(0,420,0,180)
frame.Position = UDim2.new(0.5,-210,0.3,0)
frame.BackgroundColor3 = Color3.fromRGB(50,200,100)
frame.BorderSizePixel = 0
local frameCorner = Instance.new("UICorner", frame)
frameCorner.CornerRadius = UDim.new(0,25)

local gradient = Instance.new("UIGradient", frame)
gradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(50,200,100)),ColorSequenceKeypoint.new(1, Color3.fromRGB(80,255,150))}

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0.4,0)
title.Position = UDim2.new(0,0,0,10)
title.BackgroundTransparency = 1
title.Text = "Hey!"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

local info = Instance.new("TextLabel", frame)
info.Size = UDim2.new(1,-20,0.4,0)
info.Position = UDim2.new(0,10,0.45,0)
info.BackgroundTransparency = 1
info.Text = "Welcome to SCRIPT HUB Dupe v1.1"
info.TextColor3 = Color3.fromRGB(245,245,245)
info.Font = Enum.Font.GothamBold
info.TextScaled = true
info.TextWrapped = true

local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0,40,0,40)
closeBtn.Position = UDim2.new(1,-50,0,10)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.BackgroundColor3 = Color3.fromRGB(200,0,0)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextScaled = true
local btnCorner = Instance.new("UICorner", closeBtn)
btnCorner.CornerRadius = UDim.new(0,12)
local uistroke = Instance.new("UIStroke", closeBtn)
uistroke.Color = Color3.fromRGB(255,80,80)
uistroke.Thickness = 2
uistroke.Transparency = 0.4

closeBtn.MouseEnter:Connect(function() closeBtn.BackgroundColor3 = Color3.fromRGB(255,50,50) uistroke.Transparency = 0 end)
closeBtn.MouseLeave:Connect(function() closeBtn.BackgroundColor3 = Color3.fromRGB(200,0,0) uistroke.Transparency = 0.4 end)
closeBtn.MouseButton1Click:Connect(function()
    welcomeGUI:Destroy()
    iconBtn.Visible = true
end)

-- === GUI po kliknięciu ikony 🌶 ===
local function OpenDupeMenu()
    local dupeGUI = Instance.new("ScreenGui", player.PlayerGui)
    dupeGUI.Name = "DupeMenu"

    local frame2 = Instance.new("Frame", dupeGUI)
    frame2.Size = UDim2.new(0,400,0,150)
    frame2.Position = UDim2.new(0.5,-200,0.3,0)
    frame2.BackgroundColor3 = Color3.fromRGB(50,200,100)
    local frameCorner2 = Instance.new("UICorner", frame2)
    frameCorner2.CornerRadius = UDim.new(0,25)

    local gradient2 = Instance.new("UIGradient", frame2)
    gradient2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(50,200,100)),ColorSequenceKeypoint.new(1, Color3.fromRGB(80,255,150))}

    local title2 = Instance.new("TextLabel", frame2)
    title2.Size = UDim2.new(1,0,0.4,0)
    title2.Position = UDim2.new(0,0,0,10)
    title2.BackgroundTransparency = 1
    title2.Text = "SCRIPT HUB Dupe v1.1"
    title2.TextColor3 = Color3.fromRGB(255,255,255)
    title2.Font = Enum.Font.GothamBold
    title2.TextScaled = true

    local lagBtn = Instance.new("TextButton", frame2)
    lagBtn.Size = UDim2.new(0.4,0,0.25,0)
    lagBtn.Position = UDim2.new(0.05,0,0.55,0)
    lagBtn.Text = "Lag Game"
    lagBtn.Font = Enum.Font.GothamBold
    lagBtn.TextScaled = true
    lagBtn.BackgroundColor3 = Color3.fromRGB(70,160,220)
    local lagCorner = Instance.new("UICorner", lagBtn)
    lagCorner.CornerRadius = UDim.new(0,10)
    lagBtn.MouseButton1Click:Connect(LagGame)

    local dupeBtn = Instance.new("TextButton", frame2)
    dupeBtn.Size = UDim2.new(0.4,0,0.25,0)
    dupeBtn.Position = UDim2.new(0.55,0,0.55,0)
    dupeBtn.Text = "Dupe"
    dupeBtn.Font = Enum.Font.GothamBold
    dupeBtn.TextScaled = true
    dupeBtn.BackgroundColor3 = Color3.fromRGB(70,160,220)
    local dupeCorner = Instance.new("UICorner", dupeBtn)
    dupeCorner.CornerRadius = UDim.new(0,10)
    dupeBtn.MouseButton1Click:Connect(Dupe)

    local closeBtn2 = Instance.new("TextButton", frame2)
    closeBtn2.Size = UDim2.new(0,35,0,35)
    closeBtn2.Position = UDim2.new(1,-40,0,5)
    closeBtn2.Text = "✕"
    closeBtn2.TextColor3 = Color3.fromRGB(255,255,255)
    closeBtn2.BackgroundColor3 = Color3.fromRGB(200,0,0)
    closeBtn2.Font = Enum.Font.GothamBold
    closeBtn2.TextScaled = true
    local btnCorner2 = Instance.new("UICorner", closeBtn2)
    btnCorner2.CornerRadius = UDim.new(0,10)
    closeBtn2.MouseButton1Click:Connect(function()
        dupeGUI:Destroy()
    end)
end

iconBtn.MouseButton1
