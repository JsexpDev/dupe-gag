loadstring([[
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- === Folder na wizualny ekwipunek ===
local eqFolder = player:FindFirstChild("VisualEq")
if not eqFolder then
    eqFolder = Instance.new("Folder")
    eqFolder.Name = "VisualEq"
    eqFolder.Parent = player
end

-- === Funkcje ===
local function Dupe()
    local char = player.Character
    if not char then return end
    local hand = char:FindFirstChild("RightHand") or char:FindFirstChildWhichIsA("Part")
    if not hand then return end
    local item = hand:FindFirstChildWhichIsA("Model") or hand
    if not item then
        warn("Nie trzymasz przedmiotu!")
        return
    end
    local clone = item:Clone()
    clone.Name = item.Name.."_VisualCopy"
    clone.Parent = eqFolder
    if clone:IsA("Model") and clone.PrimaryPart then
        clone:SetPrimaryPartCFrame(item.CFrame)
        for _,p in pairs(clone:GetDescendants()) do
            if p:IsA("BasePart") then
                p.Anchored = true
                p.CanCollide = false
            end
        end
    elseif clone:IsA("BasePart") then
        clone.Anchored = true
        clone.CanCollide = false
        clone.CFrame = item.CFrame + Vector3.new(2,0,0)
    end
    print("Wizualna kopia "..item.Name.." dodana do lokalnego ekwipunku!")
end

local function LagGame()
    for i=1,15 do
        workspace.Gravity = 0
        wait(0.05)
        workspace.Gravity = 196.2
    end
    print("Game 'lagged' locally!")
end

local function KillMe()
    local char = player.Character
    if char then
        char:BreakJoints()
    end
end

-- === GUI Powitania ===
local welcomeGUI = Instance.new("ScreenGui", player.PlayerGui)
welcomeGUI.Name = "WelcomeGUI"

local frame = Instance.new("Frame", welcomeGUI)
frame.Size = UDim2.new(0,420,0,180)
frame.Position = UDim2.new(0.5,-210,0.3,0)
frame.BackgroundColor3 = Color3.fromRGB(50,200,100)
local frameCorner = Instance.new("UICorner", frame)
frameCorner.CornerRadius = UDim.new(0,25)
local gradient = Instance.new("UIGradient", frame)
gradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(50,200,100)), ColorSequenceKeypoint.new(1, Color3.fromRGB(80,255,150))}

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

closeBtn.MouseButton1Click:Connect(function()
    welcomeGUI:Destroy()
    iconBtn.Visible = true
end)

-- === Ikona 🌶 ===
local screenGui = Instance.new("ScreenGui", player.PlayerGui)
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

-- === GUI Dupe Menu ===
local function OpenDupeMenu()
    local dupeGUI = Instance.new("ScreenGui", player.PlayerGui)
    dupeGUI.Name = "DupeMenu"

    local frame2 = Instance.new("Frame", dupeGUI)
    frame2.Size = UDim2.new(0,400,0,180)
    frame2.Position = UDim2.new(0.5,-200,0.3,0)
    frame2.BackgroundColor3 = Color3.fromRGB(50,200,100)
    local frameCorner2 = Instance.new("UICorner", frame2)
    frameCorner2.CornerRadius = UDim.new(0,25)
    local gradient2 = Instance.new("UIGradient", frame2)
    gradient2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(50,200,100)),ColorSequenceKeypoint.new(1, Color3.fromRGB(80,255,150))}

    local title2 = Instance.new("TextLabel", frame2)
    title2.Size = UDim2.new(1,0,0.3,0)
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

    local killBtn = Instance.new("TextButton", frame2)
    killBtn.Size = UDim2.new(0.9,0,0.15,0)
    killBtn.Position = UDim2.new(0.05,0,0.3,0)
    killBtn.Text = "Kill Me"
    killBtn.Font = Enum.Font.GothamBold
    killBtn.TextScaled = true
    killBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
    local killCorner = Instance.new("UICorner", killBtn)
    killCorner.CornerRadius = UDim.new(0,12)
    killBtn.MouseButton1Click:Connect(KillMe)

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

iconBtn.MouseButton1Click:Connect(OpenDupeMenu)
]])()
