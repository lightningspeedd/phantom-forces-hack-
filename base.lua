local lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt")()

local win = lib:Window("Niger",Color3.fromRGB(44, 120, 224), Enum.KeyCode.RightControl)

local tab = win:Tab("Exploits")


local Noclip = nil
local Clip = nil


local function aimbot()
	local Camera = workspace.CurrentCamera
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local UserInputService = game:GetService("UserInputService")
	local TweenService = game:GetService("TweenService")
	local LocalPlayer = Players.LocalPlayer
	local Holding = false

	_G.AimbotEnabled = true
	_G.TeamCheck = false -- If set to true then the script would only lock your aim at enemy team members.
	_G.AimPart = "Head" -- Where the aimbot script would lock at.
	_G.Sensitivity = 0 -- How many seconds it takes for the aimbot script to officially lock onto the target's aimpart.

	_G.CircleSides = 64 -- How many sides the FOV circle would have.
	_G.CircleColor = Color3.fromRGB(255, 255, 255) -- (RGB) Color that the FOV circle would appear as.
	_G.CircleTransparency = 0.7 -- Transparency of the circle.
	_G.CircleRadius = 80 -- The radius of the circle / FOV.
	_G.CircleFilled = false -- Determines whether or not the circle is filled.
	_G.CircleVisible = true -- Determines whether or not the circle is visible.
	_G.CircleThickness = 0 -- The thickness of the circle.

	local FOVCircle = Drawing.new("Circle")
	FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
	FOVCircle.Radius = _G.CircleRadius
	FOVCircle.Filled = _G.CircleFilled
	FOVCircle.Color = _G.CircleColor
	FOVCircle.Visible = _G.CircleVisible
	FOVCircle.Radius = _G.CircleRadius
	FOVCircle.Transparency = _G.CircleTransparency
	FOVCircle.NumSides = _G.CircleSides
	FOVCircle.Thickness = _G.CircleThickness

	local function GetClosestPlayer()
		local MaximumDistance = _G.CircleRadius
		local Target = nil

		for _, v in next, Players:GetPlayers() do
			if v.Name ~= LocalPlayer.Name then
				if _G.TeamCheck == true then
					if v.Team ~= LocalPlayer.Team then
						if v.Character ~= nil then
							if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
								if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
									local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
									local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude

									if VectorDistance < MaximumDistance then
										Target = v
									end
								end
							end
						end
					end
				else
					if v.Character ~= nil then
						if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
							if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
								local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
								local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude

								if VectorDistance < MaximumDistance then
									Target = v
								end
							end
						end
					end
				end
			end
		end

		return Target
	end

	UserInputService.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton2 then
			Holding = true
		end
	end)

	UserInputService.InputEnded:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton2 then
			Holding = false
		end
	end)

	RunService.RenderStepped:Connect(function()
		FOVCircle.Position = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
		FOVCircle.Radius = _G.CircleRadius
		FOVCircle.Filled = _G.CircleFilled
		FOVCircle.Color = _G.CircleColor
		FOVCircle.Visible = _G.CircleVisible
		FOVCircle.Radius = _G.CircleRadius
		FOVCircle.Transparency = _G.CircleTransparency
		FOVCircle.NumSides = _G.CircleSides
		FOVCircle.Thickness = _G.CircleThickness

		if Holding == true and _G.AimbotEnabled == true then
			TweenService:Create(Camera, TweenInfo.new(_G.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, GetClosestPlayer().Character[_G.AimPart].Position)}):Play()
		end
	end)
end

function noclip()
	Clip = false
	local function Nocl()
		if Clip == false and game.Players.LocalPlayer.Character ~= nil then
			for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
				if v:IsA('BasePart') and v.CanCollide and v.Name ~= floatName then
					v.CanCollide = false
				end
			end
		end
		wait(0.21) -- basic optimization
	end
	Noclip = game:GetService('RunService').Stepped:Connect(Nocl)
end

function clip()
	if Noclip then Noclip:Disconnect() end
	Clip = true
end

noclip() -- to toggle noclip() and clip()

tab:Button("Button", function()
lib:Notification("Notification", "Hello!", "Hi!")
end)
tab:Button("NoClip", function()
noclip()
end)
tab:Button("Aimbot", function()
aimbot()
end)

tab:Toggle("Toggle",false, function(t)
print(t)
end)
tab:Slider("Health",0,1000,100, function(t)
    local player = game.Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:FindFirstChildOfClass("Humanoid")

    humanoid.Health = t
end)
tab:Slider("WalkSpeed",0,1000,16, function(t)
    local player = game.Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:FindFirstChildOfClass("Humanoid")

    humanoid.WalkSpeed = t
end)

tab:Slider("JumpPower",0,1000,16, function(t)
    local player = game.Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:FindFirstChildOfClass("Humanoid")

    humanoid.JumpPower = t
end)

tab:Dropdown("Dropdown",{"Option 1","Option 2","Option 3","Option 4","Option 5"}, function(t)
print(t)
end)

tab:Colorpicker("Colorpicker",Color3.fromRGB(255,0,0), function(t)
print(t)
end)

tab:Textbox("Textbox",true, function(t)
print(t)
end)

tab:Bind("Bind",Enum.KeyCode.RightShift, function()
print("Pressed!")
end)

tab:Label("Label")

local changeclr = win:Tab("Change UI Color")

changeclr:Colorpicker("Change UI Color",Color3.fromRGB(44, 120, 224), function(t)
lib:ChangePresetColor(Color3.fromRGB(t.R * 255, t.G * 255, t.B * 255))
end)
