--!strict
local Script = script

type String = string

local function Find(Name: String, Class: String, Parent: Instance?, Make: boolean?): Instance?
	if Parent then
		for _, Child in Parent:GetChildren() do
			if Child.Name == Name and Child:IsA(Class) then
				return Child
			end
		end
	end
	
	if Make == false then return nil end
	
	local Child = Instance.new(Class) :: Instance

	Child.Name = Name
	Child.Parent = Parent

	return Child
end

local RemoteEvents: Folder = Find("RemoteEvents", "Folder", Script) :: Folder
local RemoteFunctions: Folder = Find("RemoteFunctions", "Folder", Script) :: Folder

local BindableEvents: {[String]: BindableEvent} = {}
local BindableFunctions: {[String]: BindableFunction} = {}

local Module: {
	RemoteEvent : (String) -> RemoteEvent,
	RemoteFunction : (String) -> RemoteFunction,
	BindableEvent : (String) -> BindableEvent,
	BindableFunction : (String) -> BindableFunction,
} = {
	RemoteEvent = function(Name: String): RemoteEvent
		return Find(Name, "RemoteEvent", RemoteEvents) :: RemoteEvent
	end,

	RemoteFunction = function(Name: String): RemoteFunction
		return Find(Name, "RemoteFunction", RemoteFunctions) :: RemoteFunction
	end,

	BindableEvent = function(Name: String): BindableEvent
		if not BindableEvents[Name] then
			BindableEvents[Name] = Find(Name, "BindableEvent") :: BindableEvent
		end
		return BindableEvents[Name]
	end,

	BindableFunction = function(Name: String): BindableFunction
		if not BindableFunctions[Name] then
			BindableFunctions[Name] = Find(Name, "BindableFunction") :: BindableFunction
		end
		return BindableFunctions[Name]
	end,
}

return Module
