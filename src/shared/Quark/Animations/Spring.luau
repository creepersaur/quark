local RunService = game:GetService "RunService"

local Reactive = require(script.Parent.Parent.Reactive)
local ValueMath = require(script.Parent.ValueMath)

local SpringModule = {
	Created = {},
}

local Spring = {}
Spring.__index = Spring

function SpringModule.new(start: any, target: any, elasticity: number?, stiffness: number?)
	local self = setmetatable({
		Start = start or 0,
		Value = Reactive.State(nil),
		Alpha = Reactive.State(0),
		Velocity = Reactive.State(ValueMath.Multiply((start or 0), 0)),
		Target = target or 1,
		Elasticity = elasticity or 0.1,
		Stiffness = stiffness or 0.7,
		Connections = {},
		PlayConnection = nil,
		AssignedProperties = {},
        _is_spring = true
	}, Spring)

	return self
end

function Spring:Play()
    self:Pause()
	local start = self.Start
	if typeof(start) == "table" and start._is_state then
		start = start()
	end
	if self.Value() == nil then
		self.Value(start)
	end
	self.PlayConnection = self:BindToRenderStep()
	table.insert(SpringModule.Created, self.PlayConnection)

	return self
end

function Spring:Restart()
	self.Value(nil)
	return self:Play()
end

function Spring:Pause()
	if self.PlayConnection then
		self.PlayConnection:Disconnect()
	end

	return self
end

function Spring:Cancel()
	self:Pause()
	for _, v in self.Connections do
		v(self.Value(self.Start))
	end

	return self
end

function Spring:DisconnectAll()
	for _, v: Reactive.Signal in self.Connections do
		v.Disconnect()
	end

	return self
end

function Spring:SetValue(value)
	self.Value(value)

	return self
end

function Spring:Update(dt)
	local target = self.Target
	if typeof(target) == "table" and target._is_state then
		target = target()
	end

	self.Velocity(
		ValueMath.Add(
			self.Velocity(),
			ValueMath.Multiply(ValueMath.Add(target, ValueMath.Multiply(self.Value(), -1)), self.Elasticity * dt * 60)
		)
	)
	self.Velocity(ValueMath.Multiply(self.Velocity(), self.Stiffness))
	self.Value(ValueMath.Add(self.Value(), self.Velocity()))

	return self
end

function Spring:BindToRenderStep()
	return RunService.RenderStepped:Connect(function(dt: number)
		self:Update(dt)
	end)
end

function Spring:BindToUpdate(func: (value: any) -> ())
	local connect_signal = Reactive.Signal(self.Value, func)
	table.insert(self.Connections, connect_signal)
	table.insert(SpringModule.Created, connect_signal)
	return self
end

function Spring:BindAndPlay(func: (value: any) -> ())
	self:Play()
	self:BindToUpdate(func)

	return self
end

function Spring:PlayAsProperty(Object: any, Property: string)
	self:Play()
	self:BindToUpdate(function(value)
		Object[Property] = value
	end)

	return self
end

return SpringModule
