loadstring([[
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

-- === Folder lokalnego ekwipunku ===
local eqFolder = player:FindFirstChild("VisualEq")
if not eqFolder then
    eqFolder = Instance.new("Folder")
    eqFolder.Name = "VisualEq"
    eqFolder.Parent = player
end

-- === GUI ekwipunku ===
local screenGui = Instance.new("ScreenGui", player.PlayerGui)
screenGui.Name = "DupeInventoryGUI"

local invFrame = Instance.new("Frame", screenGui)
invFrame.Size = UDim2.new(0,300,0,400)
invFrame.Position = UDim2.new(1,-310,0.5,-200)
invFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
invFrame.Visible = false
local corner = Instance.new("UICorner", invFrame)
corner.CornerRadius = UDim.new(0,15)

local scroll = Instance.new("ScrollingFrame", invFrame)
scroll.Size = UDim2.new(1,-10,1,-10)
scroll.Position = UDim2.new(0,5,0,5)
scroll.BackgroundTransparency = 1
scroll.CanvasSize = UDim2.new(0,0,0,0)
scroll.ScrollBarThickness = 8

local function AddToInventory(item)
    local itemBtn = Instance.new("TextButton", scroll)
    itemBtn.Size = UDim2.new(1,-10,0,50)
    itemBtn.Position = UDim2.new(0,5,0,#scroll:GetChildren()*55)
    itemBtn.Text = item.Name
    itemBtn.Font = Enum.Font.GothamBold
    itemBtn.TextScaled = true
    itemBtn.BackgroundColor3 = Color3.fromRGB(80,180,220)
    local corner = Instance.new("UICorner", itemBtn)
    corner.CornerRadius = UDim.new(0,10)

    scroll.CanvasSize = UDim2.new(0,0,0,#scroll:GetChildren()*55)
end

-- === Funkcja Dupe ===
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
    clone.Name = item.Name
    clone.Parent = eqFolder
    AddToInventory(clone)
    print("Dodano wizualną kopię "..item.Name.." do lokalnego ekwipunku!")
end

-- === Funkcja Lag Game ===
local function LagGame()
    for i=1,15 do
        workspace.Gravity = 0
        wait(0.05)
        workspace.Gravity = 196.2
    end
    print("Game 'lagged' locally!")
end

-- === Funkcja Kill Me ===
local function KillMe()
    local char = player.Character
    if char then
        char:BreakJoints()
    end
end

-- === Ikona 🌶 ===
local iconBtn = Instance.new("TextButton", player.PlayerGui)
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

-- === GUI Powitania ===
local welcomeGUI = Instance.new("ScreenGui", player.PlayerGui)
welcomeGUI.Name = "WelcomeGUI"

local frame = Instance.new("Frame", welcomeGUI)
frame.Size = UDim2.new(0,420,0,180)
frame.Position = UDim2.new(0.5,-210,0.3,0)
frame.BackgroundColor3 = Color3.fromRGB(50,200,100)
local frameCorner = Instance.new("UICorner", frame)
frameCorner.CornerRadius = UDim.new(0,25)

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

-- === GUI Menu ===
local function OpenMenu()
    local menuGUI = Instance.new("ScreenGui", player.PlayerGui)
    menuGUI.Name = "DupeMenu"

    local frame2 = Instance.new("Frame", menuGUI)
    frame2.Size = UDim2.new(0,300,0,180)
    frame2.Position = UDim2.new(0.5,-150,0.3,0)
    frame2.BackgroundColor3 = Color3.fromRGB(50,200,100)
    local frameCorner2 = Instance.new("UICorner", frame2)
    frameCorner2.CornerRadius = UDim.new(0,20)

    local dupeBtn = Instance.new("TextButton", frame2)
    dupeBtn.Size = UDim2.new(0.4,0,0.25,0)
    dupeBtn.Position = UDim2.new(0.05,0,0.5,0)
    dupeBtn.Text = "Dupe"
    dupeBtn.Font = Enum.Font.GothamBold
    dupeBtn.TextScaled = true
    dupeBtn.BackgroundColor3 = Color3.fromRGB(70,160,220)
    local dupeCorner = Instance.new("UICorner", dupeBtn)
    dupeCorner.CornerRadius = UDim.new(0,10)
    dupeBtn.MouseButton1Click:Connect(Dupe)

    local lagBtn = Instance.new("TextButton", frame2)
    lagBtn.Size = UDim2.new(0.4,0,0.25,0)
    lagBtn.Position = UDim2.new(0.55,0,0.5,0)
    lagBtn.Text = "Lag Game"
    lagBtn.Font = Enum.Font.GothamBold
    lagBtn.TextScaled = true
    lagBtn.BackgroundColor3 = Color3.fromRGB(70,160,220)
    local lagCorner = Instance.new("UICorner", lagBtn)
    lagCorner.CornerRadius = UDim.new(0,10)
    lagBtn.MouseButton1Click:Connect(LagGame)

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
end

iconBtn.MouseButton1Click:Connect(OpenMenu)
]])()
