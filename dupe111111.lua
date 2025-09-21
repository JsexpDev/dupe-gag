-- Poprawiona, bardziej odporna wersja GUI (wygląd mroczny / VSCode style)
-- Uwaga: NIE zmieniono mechaniki (Dupe, LagGame, KillMe) — tylko poprawki uruchamiania i obsługi GUI.

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

-- bezpieczne pobranie gracza (czekamy jeśli jeszcze nie istnieje)
local player = Players.LocalPlayer or Players.PlayerAdded:Wait()
local playerGui = player:WaitForChild("PlayerGui", 5) -- czekaj na PlayerGui

-- jeśli PlayerGui z jakiegoś powodu nie istnieje -> przerwij
if not playerGui then
    warn("PlayerGui nie znaleziono. Skrypt GUI nie został załadowany.")
    return
end

-- === ScreenGui ===
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ScriptHubGUI"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 100
screenGui.Parent = playerGui

-- === Główny frame (mroczny styl) ===
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,400,0,200)
frame.Position = UDim2.new(0.5,-200,0.5,-100)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5,0.5)
frame.Parent = screenGui
local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0,20)

local label = Instance.new("TextLabel", frame)
label.Size = UDim2.new(1,-40,1,-40)
label.Position = UDim2.new(0,20,0,20)
label.Text = "🌱 Hey! Welcome to SCRIPT HUB Dupe v1.1 🌱"
label.TextColor3 = Color3.fromRGB(200,200,200)
label.Font = Enum.Font.Code
label.TextScaled = true
label.BackgroundTransparency = 1

local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0,40,0,40)
closeBtn.Position = UDim2.new(1,-45,0,5)
closeBtn.Text = "❌"
closeBtn.Font = Enum.Font.Code
closeBtn.TextScaled = true
closeBtn.BackgroundColor3 = Color3.fromRGB(60,20,20)
closeBtn.TextColor3 = Color3.fromRGB(220,80,80)
local corner2 = Instance.new("UICorner", closeBtn)
corner2.CornerRadius = UDim.new(0,10)

-- === Ikona (mały przycisk) ===
local iconBtn = Instance.new("TextButton")
iconBtn.Size = UDim2.new(0,50,0,50)
iconBtn.Position = UDim2.new(0,10,0.5,-25)
iconBtn.Text = "🌶"
iconBtn.Font = Enum.Font.Code
iconBtn.TextScaled = true
iconBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
iconBtn.TextColor3 = Color3.fromRGB(200,200,200)
local iconCorner = Instance.new("UICorner", iconBtn)
iconCorner.CornerRadius = UDim.new(0,15)
iconBtn.Visible = false
iconBtn.Parent = screenGui

-- === Menu główne ===
local mainMenu = Instance.new("Frame", screenGui)
mainMenu.Size = UDim2.new(0,250,0,200)
mainMenu.Position = UDim2.new(0,70,0.5,-100)
mainMenu.BackgroundColor3 = Color3.fromRGB(20,20,25)
mainMenu.BorderSizePixel = 0
mainMenu.Visible = false
local menuCorner = Instance.new("UICorner", mainMenu)
menuCorner.CornerRadius = UDim.new(0,20)

-- Przycisk Dupe
local dupeBtn = Instance.new("TextButton", mainMenu)
dupeBtn.Size = UDim2.new(0.9,0,0,50)
dupeBtn.Position = UDim2.new(0.05,0,0.1,0)
dupeBtn.Text = "✨ Dupe"
dupeBtn.Font = Enum.Font.Code
dupeBtn.TextScaled = true
dupeBtn.BackgroundColor3 = Color3.fromRGB(40,120,160)
dupeBtn.TextColor3 = Color3.fromRGB(220,220,220)
local corner3 = Instance.new("UICorner", dupeBtn)
corner3.CornerRadius = UDim.new(0,10)

-- Przycisk Lag Game
local lagBtn = Instance.new("TextButton", mainMenu)
lagBtn.Size = UDim2.new(0.9,0,0,50)
lagBtn.Position = UDim2.new(0.05,0,0.4,0)
lagBtn.Text = "⚡ Lag Game"
lagBtn.Font = Enum.Font.Code
lagBtn.TextScaled = true
lagBtn.BackgroundColor3 = Color3.fromRGB(160,120,40)
lagBtn.TextColor3 = Color3.fromRGB(230,230,230)
local corner4 = Instance.new("UICorner", lagBtn)
corner4.CornerRadius = UDim.new(0,10)

-- Przycisk Kill Me
local killBtn = Instance.new("TextButton", mainMenu)
killBtn.Size = UDim2.new(0.9,0,0,50)
killBtn.Position = UDim2.new(0.05,0,0.7,0)
killBtn.Text = "💀 Kill Me"
killBtn.Font = Enum.Font.Code
killBtn.TextScaled = true
killBtn.BackgroundColor3 = Color3.fromRGB(140,40,40)
killBtn.TextColor3 = Color3.fromRGB(230,230,230)
local corner5 = Instance.new("UICorner", killBtn)
corner5.CornerRadius = UDim.new(0,10)

-- === Ekwipunek GUI ===
local invFrame = Instance.new("Frame", screenGui)
invFrame.Size = UDim2.new(0,200,0,300)
invFrame.Position = UDim2.new(1,-210,0.5,-150)
invFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
invFrame.BorderSizePixel = 0
invFrame.Visible = false
local invCorner = Instance.new("UICorner", invFrame)
invCorner.CornerRadius = UDim.new(0,15)

local scroll = Instance.new("ScrollingFrame", invFrame)
scroll.Size = UDim2.new(1,-10,1,-10)
scroll.Position = UDim2.new(0,5,0,5)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 6
scroll.CanvasSize = UDim2.new(0,0,0,0)

-- użyjemy UIListLayout żeby poprawnie układać przyciski i obliczać CanvasSize
local uiList = Instance.new("UIListLayout", scroll)
uiList.SortOrder = Enum.SortOrder.LayoutOrder
uiList.Padding = UDim.new(0,8)

-- automatyczna aktualizacja CanvasSize
local function updateCanvas()
    scroll.CanvasSize = UDim2.new(0,0,0,uiList.AbsoluteContentSize.Y + 8)
end
uiList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvas)

-- === Funkcje ===
local function AddToInventory(item)
    local itemBtn = Instance.new("TextButton")
    itemBtn.Size = UDim2.new(1,0,0,40)
    itemBtn.LayoutOrder = #scroll:GetChildren() + 1 -- nie krytyczne, UIListLayout nadpisze
    itemBtn.Text = tostring(item.Name or "Item")
    itemBtn.Font = Enum.Font.Code
    itemBtn.TextScaled = true
    itemBtn.BackgroundColor3 = Color3.fromRGB(35,100,60)
    itemBtn.TextColor3 = Color3.fromRGB(220,220,220)
    local corner = Instance.new("UICorner", itemBtn)
    corner.CornerRadius = UDim.new(0,8)
    itemBtn.Parent = scroll
    -- Canvas zaktualizuje się automatycznie przez listener
end

-- === Mechanika (bez zmian logicznych) ===
local function Dupe()
    local char = player.Character
    if not char then return end
    local tool = char:FindFirstChildOfClass("Tool")
    if not tool then
        warn("Nie masz przedmiotu w ręce!")
        return
    end
    local clone = Instance.new("Tool")
    clone.Name = tool.Name
    clone.Parent = player.Backpack
    AddToInventory(clone)
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
    mainMenu.Visible = not mainMenu.Visible
end)

dupeBtn.MouseButton1Click:Connect(function()
    Dupe()
    invFrame.Visible = true
end)

lagBtn.MouseButton1Click:Connect(LagGame)
killBtn.MouseButton1Click:Connect(KillMe)

-- koniec skryptu