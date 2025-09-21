loadstring([[
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer

-- Folder na wizualne kopie w PlayerGui
local eqFolder = player:FindFirstChild("VisualEq")
if not eqFolder then
    eqFolder = Instance.new("Folder")
    eqFolder.Name = "VisualEq"
    eqFolder.Parent = player
end

-- Funkcja Dupe
local function Dupe()
    local char = player.Character
    if not char then return end
    local hand = char:FindFirstChild("RightHand") or char:FindFirstChildWhichIsA("Part")
    if not hand then return end
    local item = hand:FindFirstChildWhichIsA("Model") or hand:FindFirstChildWhichIsA("MeshPart") or hand
    if not item then
        warn("Nie trzymasz przedmiotu!")
        return
    end
    
    -- Klonujemy wizualnie
    local clone = item:Clone()
    clone.Name = item.Name.."_VisualCopy"
    clone.Parent = eqFolder
    clone:SetPrimaryPartCFrame(item.CFrame)
    
    -- Zakotwiczamy i ustawiamy kolory jak oryginał
    for _,p in pairs(clone:GetDescendants()) do
        if p:IsA("BasePart") then
            p.Anchored = true
            p.CanCollide = false
        end
    end
    
    print("Wizualna kopia "..item.Name.." dodana do ekwipunku!")
end

-- Funkcja Lag Game
local function LagGame()
    for i=1,15 do
        workspace.Gravity = 0
        wait(0.05)
        workspace.Gravity = 196.2
    end
    print("Game 'lagged' locally!")
end

-- Przykładowe GUI
local screenGui = Instance.new("ScreenGui", player.PlayerGui)
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0,300,0,150)
frame.Position = UDim2.new(0.5,-150,0.3,0)
frame.BackgroundColor3 = Color3.fromRGB(50,200,100)
local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0,20)

local lagBtn = Instance.new("TextButton", frame)
lagBtn.Size = UDim2.new(0.4,0,0.25,0)
lagBtn.Position = UDim2.new(0.05,0,0.55,0)
lagBtn.Text = "Lag Game"
lagBtn.Font = Enum.Font.GothamBold
lagBtn.TextScaled = true
lagBtn.BackgroundColor3 = Color3.fromRGB(70,160,220)
local lagCorner = Instance.new("UICorner", lagBtn)
lagCorner.CornerRadius = UDim.new(0,10)
lagBtn.MouseButton1Click:Connect(LagGame)

local dupeBtn = Instance.new("TextButton", frame)
dupeBtn.Size = UDim2.new(0.4,0,0.25,0)
dupeBtn.Position = UDim2.new(0.55,0,0.55,0)
dupeBtn.Text = "Dupe"
dupeBtn.Font = Enum.Font.GothamBold
dupeBtn.TextScaled = true
dupeBtn.BackgroundColor3 = Color3.fromRGB(70,160,220)
local dupeCorner = Instance.new("UICorner", dupeBtn)
dupeCorner.CornerRadius = UDim.new(0,10)
dupeBtn.MouseButton1Click:Connect(Dupe)
]])()
