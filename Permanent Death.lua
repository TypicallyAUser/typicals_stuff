--[[

					This reanimation was created by
					
							 TypicalUsername
		   
	Removal of some loadstrings could cause issues with the reanimation.
	
				I DO NOT USE LOGGERS WITHIN THE LOADSTRINGS!
				
							 shut up gary
	
	  Please credit me if you wish to use this inside of your scripts!

]]--

--// Fix for duplicated hats \\--

loadstring(game:HttpGet("https://raw.githubusercontent.com/TypicallyAUser/TypicalsConvertingLibrary/main/renameallhatclones"))()

--// Main Variables \\--

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/TypicallyAUser/TypicalsConvertingLibrary/main/Main"))()
Library.Net()
local Player = game.Players.LocalPlayer
local Character = Player.Character
Character.Archivable = true
Animations = true

--// Cloning \\--

local Dummy = Character:Clone()
Dummy.Parent = workspace
Character.Parent = Dummy
Character.Animate:Remove()
Dummy.Name = "Typical's Reanimation"
Dummy.Head.face.Transparency = 1
for i,v in pairs(Dummy:GetChildren()) do
	if v:IsA("BasePart") then
		v.Transparency = 1
	elseif v:IsA("Accessory") then
		v.Handle.Transparency = 1
	end
end

--// Permanent Death \\--

Library.Notification("Permanent Death","Loading.")

Player.Character = nil

Player.Character = Dummy

wait(game.Players.RespawnTime + .5)

Character.Humanoid:ChangeState(15)

Library.Notification("Permanent Death","Player health set to 0.")

--// Functions \\--

function Noclip()
	for i,v in pairs(Dummy:GetDescendants()) do
		if v:IsA("BasePart") then
			v.CanCollide = false
		end
	end
	for i,v in pairs(Dummy:GetChildren()) do
		if v:IsA("Accessory") then
			if not v.Handle:FindFirstChildOfClass("SpecialMesh") then
				Library.RemoveMesh(Character[v.Name].Handle)
			end
		end
	end
    if game.Workspace:FindFirstChild(Character.Name) then
    	Dummy:Remove()
    	return
    	
	end
end

Noclip = game.RunService.Stepped:Connect(Noclip)

Dummy.Parent.ChildRemoved:connect(function(Obj)
	if Obj == Dummy then
		Library.Notification("Permanent Death","Your reanimation rig has been removed from workspace.")
	end
end)

function Netless()
    for _, v in pairs(Character:GetChildren()) do
        if v:IsA("BasePart") or v:IsA("MeshPart") and v.Name ~= "HumanoidRootPart" then
            v.Velocity = Vector3.new(-25.05, 0, 0)
        elseif v:IsA("Accessory") then
        	v.Handle.Velocity = Vector3.new(-30.15, 0, -30.15)
        end
    end
end
Netless = game.RunService.Heartbeat:Connect(Netless)

--// Align \\--

local Limbs = {}
table.insert(Limbs, Character['Right Arm'])
table.insert(Limbs, Character['Left Arm'])
table.insert(Limbs, Character['Right Leg'])
table.insert(Limbs, Character['Left Leg'])
table.insert(Limbs, Character['Torso'])
table.insert(Limbs, Character['HumanoidRootPart'])
table.insert(Limbs, Character['Head'])
function yes(part0,part1) 
	game.RunService.Heartbeat:Connect(function()
		part0.CFrame = part1.CFrame
	end)
end
for i,v in pairs(Limbs) do
	yes(v, Dummy[v.Name])
end

for i,v in pairs(Character:GetChildren()) do
	if v:IsA("Accessory") then
		yes(v.Handle,Dummy[v.Name].Handle,Vector3.new(0,0,0),Vector3.new(0,0,0))
	end
end

Character.ChildAdded:Connect(function(Instance_)
	if Instance_:IsA("Accessory") then
		wait()
		local HatClone = Instance_:Clone()
		HatClone.Parent = Dummy
		local hatattach = HatClone.Handle:FindFirstChildOfClass("Attachment")
		local partattach
		for i,v in pairs(Dummy:GetChildren()) do
			if v:IsA("BasePart") then
				for i,v in pairs(v:GetChildren()) do
					if v.Name == hatattach.Name then
						partattach = v
						break
					end
				end
				if partattach then break end
			end
		end
		local FakeAccessoryWeld = Instance.new("Weld",HatClone.Handle)
		FakeAccessoryWeld.Name = "AccessoryWeld"
		FakeAccessoryWeld.Part0 = HatClone.Handle
		FakeAccessoryWeld.Part1 = partattach.Parent
		FakeAccessoryWeld.C0 = hatattach.CFrame
		FakeAccessoryWeld.C1 = partattach.CFrame
		yes(Instance_.Handle,HatClone.Handle,Vector3.new(0,0,0),Vector3.new(0,0,0))
		Instance_.Handle.Transparency = 1
	end
end)

local fakerespawnevent = Instance.new("BindableEvent")
fakerespawnevent.Event:Connect(function()
	game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
	Character.Humanoid:Remove()
	Library.Notification("Permanent Death", "Please wait.\nWe are force resetting your character.")
end)
game:GetService("StarterGui"):SetCore("ResetButtonCallback", fakerespawnevent)

if Animations then loadstring(game:HttpGet("https://raw.githubusercontent.com/TypicallyAUser/TypicalsConvertingLibrary/main/Animations"))().R6(Dummy.Animate) end
workspace.Camera.CameraSubject = Dummy.Humanoid
Library.Notification("Permanent Death","You are now reanimated.\nYou may now run your scripts.")