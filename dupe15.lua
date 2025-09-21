loadstring([[
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "WelcomeGUI"
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Tło główne z gradientem
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,420,0,180)
frame.Position = UDim2.new(0.5,-210,0.3,0)
frame.BackgroundColor3 = Color3.fromRGB(50,200,100)
frame.BorderSizePixel = 0
frame.Parent = screenGui
local frameCorner = Instance.new("UICorner", frame)
frameCorner.CornerRadius = UDim.new(0,25)

local gradient = Instance.new("UIGradient", frame)
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(50,200,100)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(80,255,150))
}

-- Tekst "Hey!"
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0.4,0)
title.Position = UDim2.new(0,0,0,10)
title.BackgroundTransparency = 1
title.Text = "Hey!"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.TextStrokeTransparency = 0.2
title.Parent = frame

-- Tekst informacyjny
local info = Instance.new("TextLabel")
info.Size = UDim2.new(1,-20,0.4,0)
info.Position = UDim2.new(0,10,0.45,0)
info.BackgroundTransparency = 1
info.Text = "Welcome to SCRIPT HUB Dupe v1.1"
info.TextColor3 = Color3.fromRGB(245,245,245)
info.Font = Enum.Font.GothamBold
info.TextScaled = true
info.TextWrapped = true
info.Parent = frame

-- Elegancki przycisk zamknięcia
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0,40,0,40)
closeBtn.Position = UDim2.new(1,-50,0,10)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.BackgroundColor3 = Color3.fromRGB(200,0,0)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextScaled = true
closeBtn.Parent = frame
local btnCorner = Instance.new("UICorner", closeBtn)
btnCorner.CornerRadius = UDim.new(0,12)

-- Glow efekt przycisku
local uistroke = Instance.new("UIStroke", closeBtn)
uistroke.Color = Color3.fromRGB(255,80,80)
uistroke.Thickness = 2
uistroke.Transparency = 0.4

-- Hover efekt
closeBtn.MouseEnter:Connect(function()
    closeBtn.BackgroundColor3 = Color3.fromRGB(255,50,50)
    uistroke.Transparency = 0
end)
closeBtn.MouseLeave:Connect(function()
    closeBtn.BackgroundColor3 = Color3.fromRGB(200,0,0)
    uistroke.Transparency = 0.4
end)

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)
]])()
