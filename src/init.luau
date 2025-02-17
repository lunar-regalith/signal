--!strict
local Script = script

type String = string

local function Folder(Name: String): Folder
	local F: Instance? = Script:FindFirstChild(Name)
	
	if F then if F:IsA("Folder") then return F end end

	local function Lambda(Name: String): Folder
		local T = Instance.new("Folder", Script)
		T.Name = Name
		return T
	end

	return Lambda(Name)
end

local function Find(Parent: Folder, Name: String, Type: "RemoteEvent" | "RemoteFunction" | "BindableEvent" | "BindableFunction"): Instance
	local Children = Parent:GetChildren()

	for _, Child in Children do
		if Child.Name == Name and Child:IsA(Type) then
			return Child
		end
	end

	local Return = Instance.new(Type, Parent)
	Return.Name = Name

	return Return
end

local RemoteEvents: Folder = Folder("RemoteEvents")
local RemoteFunctions: Folder = Folder("RemoteFunctions")

local BindableEvents: Folder = Folder("BindableEvents")
local BindableFunctions: Folder = Folder("BindableFunctions")

local Module: {
	["RemoteEvent"] : (String) -> RemoteEvent,
	["RemoteFunction"] : (String) -> RemoteFunction,
	["BindableEvent"] : (String) -> BindableEvent,
	["BindableFunction"] : (String) -> BindableFunction,
} = {
	RemoteEvent = function(Name: String): RemoteEvent
		return Find(RemoteEvents, Name, "RemoteEvent") :: RemoteEvent
	end,
	
	RemoteFunction = function(Name: String): RemoteFunction
		return Find(RemoteFunctions, Name, "RemoteFunction") :: RemoteFunction
	end,
	
	BindableEvent = function(Name: String): BindableEvent
		return Find(BindableEvents, Name, "BindableEvent") :: BindableEvent
	end,
	
	BindableFunction = function(Name: String): BindableFunction
		return Find(BindableFunctions, Name, "BindableFunction") :: BindableFunction
	end,
}

return Module