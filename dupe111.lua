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
invFrame.Size = UDim2.new(0,250,0,400)
invFrame.Position = UDim2.new(1,-260,0.5,-200)
invFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
invFrame.Visible = false
local corner = Instance.new("UICorner", invFrame)
corner.CornerRadius = UDim.new(0,15)

local scroll = Instance.new("ScrollingFrame", invFrame)
scroll.Size = UDim2.new(1,-10,1,-10)
scroll.Position = UDim2.new(0,5,0,5)
scroll.CanvasSize = UDim2.new(0,0,0,0)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 8

-- Funkcja dodania przedmiotu do GUI ekwipunku
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

    -- Miniatura 3D przedmiotu
    local viewport = Instance.new("ViewportFrame", itemBtn)
    viewport.Size = UDim2.new(0,50,0,50)
    viewport.Position = UDim2.new(1,-55,0,0)
    viewport.BackgroundTransparency = 1
    local clone = item:Clone()
    if clone:IsA("Model") then
        clone.Parent = viewport
        -- ustawienie PrimaryPart
        if not clone.PrimaryPart then
            clone.PrimaryPart = clone:FindFirstChildWhichIsA("BasePart")
        end
        if clone.PrimaryPart then
            local cam = Instance.new("Camera")
            cam.Parent = viewport
            viewport.CurrentCamera = cam
            cam.CFrame = clone.PrimaryPart.CFrame + Vector3.new(2,2,2)
        end
    elseif clone:IsA("BasePart") then
        clone.Parent = viewport
        local cam = Instance.new("Camera")
        cam.Parent = viewport
        viewport.CurrentCamera = cam
        cam.CFrame = clone.CFrame + Vector3.new(2,2,2)
    end

    -- Aktualizacja scrolla
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

    -- Tworzymy wizualną kopię w eqFolder
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
iconBtn.MouseButton1Click:Connect(function()
    invFrame.Visible = not invFrame.Visible
end)
]])()
