loadstring([[
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "WelcomeGUI"
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Tło
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,400,0,150)
frame.Position = UDim2.new(0.5,-200,0.3,0)
frame.BackgroundColor3 = Color3.fromRGB(50,200,100) -- kolor Grow a Garden
frame.BorderSizePixel = 0
frame.Parent = screenGui
local frameCorner = Instance.new("UICorner", frame)
frameCorner.CornerRadius = UDim.new(0,20)

-- Tekst powitalny
local label = Instance.new("TextLabel")
label.Size = UDim2.new(1,0,1,0)
label.BackgroundTransparency = 1
label.Text = "Hey! Welcome to SCRIPT HUB Dupe v1.1"
label.TextColor3 = Color3.fromRGB(255,255,255)
label.Font = Enum.Font.GothamBold
label.TextScaled = true
label.TextWrapped = true
label.Parent = frame

-- Przycisk zamknięcia
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0,30,0,30)
closeBtn.Position = UDim2.new(1,-35,0,5)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.BackgroundColor3 = Color3.fromRGB(200,0,0)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextScaled = true
closeBtn.Parent = frame
local btnCorner = Instance.new("UICorner", closeBtn)
btnCorner.CornerRadius = UDim.new(0,5)

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)
]])()