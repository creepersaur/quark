local RunService = game:GetService "RunService"

local Types = require(script.Parent.Parent.Types)
local Reactive = require(script.Parent.Parent.Reactive)

local LoopModule = {
	Created = {},
}

local Loop = {}
Loop.__index = Loop

function LoopModule.new(): Types.Loop
	local self = setmetatable({
		Connections = {},
		Value = Reactive.State(0),
		PlayConnection = nil,
		_is_loop = true,
	}, Loop)

	return self
end

function Loop:Play()
	self:Pause()
	self.PlayConnection = self:BindToRenderStep()
	table.insert(LoopModule.Created, self.PlayConnection)

	return self
end

function Loop:Restart()
	self.Value(nil)
	return self:Play()
end

function Loop:Pause()
	if self.PlayConnection then
		self.PlayConnection:Disconnect()
	end

	return self
end

function Loop:Cancel()
	self:Pause()
	for _, v in self.Connections do
		v(self.Value(self.Start))
	end

	return self
end

function Loop:DisconnectAll<T>()
	for _, v: Types.Signal<T> in self.Connections do
		v:Disconnect()
	end

	return self
end

function Loop:Update(dt)
	self.Value(dt)

	return self
end

function Loop:BindToRenderStep()
	local x = RunService.RenderStepped:Connect(function(dt: number)
		self:Update(dt)
	end)

	table.insert(LoopModule.Created, x)
	return x
end

function Loop:BindToUpdate(func: (dt: number) -> ())
	local connect_signal = Reactive.Signal(self.Value, func)
	table.insert(self.Connections, connect_signal)
	table.insert(LoopModule.Created, connect_signal)

	return connect_signal
end

function Loop:BindAndPlay(func: (dt: number) -> ())
	self:Play()

	return self:BindToUpdate(func)
end

function Loop:BindToProperty(Object: any, Property: string)
	return self:BindToUpdate(function(value)
		Object[Property] = value
	end)
end

return LoopModule
