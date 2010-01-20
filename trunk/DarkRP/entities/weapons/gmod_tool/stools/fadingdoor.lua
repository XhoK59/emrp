TOOL.Category = "Conna's Tools"
TOOL.Name = "#Fading Door Tool"
TOOL.Command = nil
TOOL.ConfigName = ""

// Tables

local FadingDoor = {}

// ConVars

TOOL.ClientConVar["Key"] = "5"
TOOL.ClientConVar["Toggle"] = "0"
TOOL.ClientConVar["Inversed"] = "0"

// Message

function TOOL:Message(Text)
	if SERVER then
		self:GetOwner():SendLua("GAMEMODE:AddNotify('"..Text.."', NOTIFY_GENERIC, 10)")
		self:GetOwner():SendLua("surface.PlaySound('ambient/water/drip"..math.random(1, 4)..".wav')")
	end
end

// Client

if (CLIENT) then
	language.Add("Tool_fadingdoor_name", "Fading Door Tool")
	language.Add("Tool_fadingdoor_desc", "Creates doors which can fade to allow access")
	language.Add("Tool_fadingdoor_0", "Click on an entity to make it a Fading Door")
	
	language.Add("Undone_fadingdoor", "Undone Fading Door")
end

// Fading door

local function SetFadingDoor(Player, Entity, Data)
	// Remove previous
	
	if (Entity.FadingDoor) then
		FadingDoor.Deactivate(Entity)
		
		numpad.Remove(Entity.FadingDoor.Down)
		numpad.Remove(Entity.FadingDoor.Up)
	end
	
	// Set new variables
	
	Entity.FadingDoor = {}
	Entity.FadingDoor.Active = false
	Entity.FadingDoor.Inverse = Data.Inverse
	Entity.FadingDoor.Toggle = Data.Toggle
	
	// Inversed
	
	if (Data.Inverse) then FadingDoor.Activate(Entity) end
	
	// Wire
	
	if (Wire_CreateOutputs) then
		Entity.Outputs = Wire_CreateOutputs(Entity, {"Active"})
	end
	
	local Number = 0
	
	if (Entity.FadingDoor.Active) then Number = 1 end
	
	if (Wire_TriggerOutput) then
		Wire_TriggerOutput(Entity, "Active", Number)
	end
	
	// Keys
	
	Entity.FadingDoor.Down = numpad.OnDown(Player, Data.Key, "FadingDoor.Pressed", Entity, true)
	Entity.FadingDoor.Up   = numpad.OnUp(Player, Data.Key, "FadingDoor.Pressed", Entity, false)
	
	// Store entity modifier
	
	duplicator.StoreEntityModifier(Entity, "FadingDoor", Data)

	return true
end

duplicator.RegisterEntityModifier("FadingDoor", SetFadingDoor)

// Left click

function TOOL:LeftClick(Trace)
	if Trace.Entity then
		if !Trace.Entity:IsValid() or Trace.Entity:IsPlayer() or Trace.HitWorld or Trace.Entity:IsNPC() then
			return false
		end
	end
	
	if(CLIENT) then
		return true
	end

	if(!SERVER) then return false end
	
	// Locals
	
	local Player = self:GetOwner()
	
	local Entity = Trace.Entity
	
	// Keys

	local Key = self:GetClientNumber("Key")
	local Toggle = self:GetClientNumber("Toggle")
	local Inverse = self:GetClientNumber("Inversed")
	
	// Remove previous
	
	SetFadingDoor(Player, Entity, {Key = Key, Toggle = (Toggle == 1), Inverse = (Inverse == 1)})
	
	// Undo
	
	local function Function(Undo, Entity)
		if (Entity.FadingDoor) then
			FadingDoor.Deactivate(Entity)
			
			numpad.Remove(Entity.FadingDoor.Down)
			numpad.Remove(Entity.FadingDoor.Up)
		end
	end
	
	undo.Create("fadingdoor")
		undo.AddFunction(Function, Entity)
		undo.SetPlayer(Player)
	undo.Finish()
	
	// Message
	
	self:Message("Fading Door has been created!!")
	
	return true
end

// Activate

function FadingDoor.Activate(Entity)
	if (Entity.FadingDoor.Active) then return end
	
	Entity.FadingDoor.Material = Entity:GetMaterial()
	
	Entity:SetMaterial("sprites/heatwave")
	Entity:DrawShadow(false)
	Entity:SetNotSolid(true)
	Entity:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	
	Entity.FadingDoor.Active = true
	
	// Wire
	
	if (Wire_TriggerOutput) then Wire_TriggerOutput(Entity, "Active", 1) end
end

// Deactivate

function FadingDoor.Deactivate(Entity)
	local Material = Entity.FadingDoor.Material or ""
	
	Entity:SetMaterial(Material)
	Entity:DrawShadow(true)
	Entity:SetNotSolid(false)
	Entity:SetCollisionGroup(COLLISION_GROUP_NONE)
	
	Entity.FadingDoor.Active = false
	
	// Wire
	
	if (Wire_TriggerOutput) then Wire_TriggerOutput(Entity, "Active", 0) end
end

// Pressed key

function TOOL.Pressed(Player, Entity, Key, IDX)
	if !Entity:IsValid() then return end
	
	if (Entity.FadingDoor.Toggle) then
		if (Key) then
			if (Entity.FadingDoor.Active) then
				FadingDoor.Deactivate(Entity)
			else
				FadingDoor.Activate(Entity)
			end
		end
	else
		if (Key) then
			FadingDoor.Activate(Entity)
		else
			FadingDoor.Deactivate(Entity)
		end
	end
end

// Server

if (SERVER) then
	numpad.Register("FadingDoor.Pressed", TOOL.Pressed)
end

// Build CPanel

function TOOL.BuildCPanel(Panel)
	Panel:AddControl("Header", {Text = "#Tool_fadingdoor_name", Description	= "#Tool_fadingdoor_desc"})
	
	Panel:AddControl("CheckBox", {Label = "Inversed (Start Activated)", Command = "fadingdoor_Inversed"})
	
	Panel:AddControl("CheckBox", {Label = "Toggle", Command = "fadingdoor_Toggle"})
	
	Panel:AddControl("Numpad", {Label = "Button", ButtonSize = "22", Command = "fadingdoor_Key"})
end