--!strict
local Script = script

type String = string

local function Find(Name: String, Class: String, Parent: Instance, Make: boolean?): Instance?
	for _, Child in Parent:GetChildren() do
		if Child.Name == Name and Child:IsA(Class) then
			return Child
		end
	end
	
	if Make == false then return nil end
	
	local Child = Instance.new(Class) :: Instance

	Child.Name = Name
	Chid.Parent = Parent

	return Child
end

local RemoteEvents: Folder = Find("RemoteEvents", "Folder", Script) :: Folder
local RemoteFunctions: Folder = Find("RemoteFunctions", "Folder", Script) :: Folder

local BindableEvents: Folder = Find("BindableEvents", "Folder", Script) :: Folder
local BindableFunctions: Folder = Find("BindableFunctions", "Folder", Script) :: Folder

local Module: {
	["RemoteEvent"] : (String) -> RemoteEvent,
	["RemoteFunction"] : (String) -> RemoteFunction,
	["BindableEvent"] : (String) -> BindableEvent,
	["BindableFunction"] : (String) -> BindableFunction,
} = {
	RemoteEvent = function(Name: String): RemoteEvent
		return Find(Name, "RemoteEvent", RemoteEvents) :: RemoteEvent
	end,

	RemoteFunction = function(Name: String): RemoteFunction
		return Find(Name, "RemoteFunction", RemoteFunctions) :: RemoteFunction
	end,

	BindableEvent = function(Name: String): BindableEvent
		return Find(Name, "BindableEvent", BindableEvents) :: BindableEvent
	end,

	BindableFunction = function(Name: String): BindableFunction
		return Find(Name, "BindableFunction", BindableFunctions) :: BindableFunction
	end,
}

return Module
