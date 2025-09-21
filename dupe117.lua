local Players = game:GetService("Players")
local player = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

-- === GUI ===
local screenGui = Instance.new("ScreenGui", player.PlayerGui)
screenGui.Name = "ScriptHubGUI"

-- Ikona 🌶
local iconBtn = Instance.new("TextButton")
iconBtn.Size = UDim2.new(0,50,0,50)
iconBtn.Position = UDim2.new(0,10,0.5,-25)
iconBtn.Text = "🌶"
iconBtn.Font = Enum.Font.GothamBold
iconBtn.TextScaled = true
iconBtn.BackgroundColor3 = Color3.fromRGB(255,100,100)
iconBtn.TextColor3 = Color3.fromRGB(255,255,255)
local iconCorner = Instance.new("UICorner", iconBtn)
iconCorner.CornerRadius = UDim.new(0,15)
iconBtn.Parent = screenGui

-- Menu główne
local mainMenu = Instance.new("Frame", screenGui)
mainMenu.Size = UDim2.new(0,280,0,220)
mainMenu.Position = UDim2.new(0,70,0.5,-110)
mainMenu.BackgroundColor3 = Color3.fromRGB(40,40,55)
mainMenu.Visible = false
local menuCorner = Instance.new("UICorner", mainMenu)
menuCorner.CornerRadius = UDim.new(0,20)

local uiStroke = Instance.new("UIStroke", mainMenu)
uiStroke.Thickness = 2
uiStroke.Color = Color3.fromRGB(255,255,255)

local title = Instance.new("TextLabel", mainMenu)
title.Size = UDim2.new(1,0,0,50)
title.Position = UDim2.new(0,0,0,0)
title.Text = "✨ Dupe Hub ✨"
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255,255,255)

-- Przycisk Dupe
local dupeBtn = Instance.new("TextButton", mainMenu)
dupeBtn.Size = UDim2.new(0.9,0,0,60)
dupeBtn.Position = UDim2.new(0.05,0,0.3,0)
dupeBtn.Text = "🔁 Dupe"
dupeBtn.Font = Enum.Font.GothamBold
dupeBtn.TextScaled = true
dupeBtn.BackgroundColor3 = Color3.fromRGB(100,180,250)
local corner3 = Instance.new("UICorner", dupeBtn)
corner3.CornerRadius = UDim.new(0,15)

-- Przycisk Kill Me
local killBtn = Instance.new("TextButton", mainMenu)
killBtn.Size = UDim2.new(0.9,0,0,60)
killBtn.Position = UDim2.new(0.05,0,0.65,0)
killBtn.Text = "💀 Kill Me"
killBtn.Font = Enum.Font.GothamBold
killBtn.TextScaled = true
killBtn.BackgroundColor3 = Color3.fromRGB(220,80,80)
local corner4 = Instance.new("UICorner", killBtn)
corner4.CornerRadius = UDim.new(0,15)

-- === Logika ===
local canDupe = true

local function Dupe()
	if not canDupe then
		warn("Dupe na cooldownie!")
		return
	end
	canDupe = false

	-- Mega lag 30 sekund
	print("Lagging game for 30s...")
	local t = tick()
	while tick() - t < 30 do
		for i = 1,10000 do
			math.random()
		end
		task.wait()
	end
	print("Lag finished!")

	-- Cooldown 5 minut
	dupeBtn.Text = "⏳ Cooldown..."
	dupeBtn.BackgroundColor3 = Color3.fromRGB(120,120,120)
	task.delay(300, function()
		canDupe = true
		dupeBtn.Text = "🔁 Dupe"
		dupeBtn.BackgroundColor3 = Color3.fromRGB(100,180,250)
	end)
end

local function KillMe()
	local char = player.Character
	if char then
		char:BreakJoints()
	end
end

-- === Połączenia ===
iconBtn.MouseButton1Click:Connect(function()
	mainMenu.Visible = not mainMenu.Visible
end)

dupeBtn.MouseButton1Click:Connect(Dupe)
killBtn.MouseButton1Click:Connect(KillMe)
