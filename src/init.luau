local Script = script

type String = string

local RemoteEvents: Folder = Script:FindFirstChild("RemoteEvents")
if not RemoteEvents then
	RemoteEvents = Instance.new("Folder", Script)
	RemoteEvents.Name = "RemoteEvents"
end

local RemoteFunctions: Folder = Script:FindFirstChild("RemoteEvents")
if not RemoteFunctions then
	RemoteFunctions = Instance.new("Folder", Script)
	RemoteFunctions.Name = "RemoteFunctions"
end

local BindableEvents: {[String]: BindableEvent} = {}
local BindableFunctions: {[String]: BindableFunction} = {}

local Module = {
	RemoteEvent = function(Name: String)
		local Event = RemoteEvents:FindFirstChild(Name)

		if not Event then
			Event = Instance.new("RemoteEvent")
			Event.Parent = RemoteEvents
			Event.Name = Name
		end

		return Event
	end,

	RemoteFunction = function(Name: String)
		local Event = RemoteFunctions:FindFirstChild(Name)

		if not Event then
			Event = Instance.new("RemoteFunction")
			Event.Parent = RemoteFunctions
			Event.Name = Name
		end

		return Event
	end,

	BindableEvent = function(Name: String)
		local Event = BindableEvents[Name]

		if Event then return Event end

		Event = Instance.new("BindableEvent")
		BindableEvents[Name] = Event

		return Event
	end,

	BindableFunction = function(Name: String)
		local Event = BindableFunctions[Name]

		if Event then return Event end

		Event = Instance.new("BindableFunction")
		BindableFunctions[Name] = Event

		return Event
	end,
}

return Module
