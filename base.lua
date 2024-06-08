local lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt")()

local win = lib:Window("Niger",Color3.fromRGB(44, 120, 224), Enum.KeyCode.RightControl)

local tab = win:Tab("Exploits")


local Noclip = nil
local Clip = nil

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
