local RunService = game:GetService "RunService"

local Types = require(script.Parent.Parent.Types)
local Reactive = require(script.Parent.Parent.Reactive)
local ValueMath = require(script.Parent.ValueMath)

local SpringModule = {
	Created = {},
}

local Spring = {}
Spring.__index = Spring

function SpringModule.new<T>(
	start: Types.CanBeState<T>,
	target: Types.CanBeState<T>,
	elasticity: number?,
	stiffness: number?
): Types.Spring<T>
	local self = setmetatable({
		Start = start or 0,
		Value = Reactive.State(start or 0),
		Alpha = Reactive.State(0),
		Velocity = Reactive.State(ValueMath.Multiply((start or 0), 0)),
		Target = target or 1,
		Elasticity = elasticity or 0.1,
		Stiffness = stiffness or 0.7,
		Connections = {},
		PlayConnection = nil,
		_is_spring = true,
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
	for _, v: Types.Signal in self.Connections do
		v:Disconnect()
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

	local elasticity = self.Elasticity
	if typeof(elasticity) == "table" and elasticity._is_state then
		elasticity = elasticity()
	end
	local stiffness = self.Stiffness
	if typeof(stiffness) == "table" and stiffness._is_state then
		stiffness = stiffness()
	end

	local SpeedMultiplier = 22

	-- Update velocity based on spring force
	self.Velocity(
		ValueMath.Add(
			self.Velocity(),
			ValueMath.Multiply(
				ValueMath.Add(target, ValueMath.Multiply(self.Value(), -1)),
				elasticity * 3 * dt * SpeedMultiplier
			)
		)
	)

	-- Apply stiffness damping (frame-rate-independent)
	self.Velocity(ValueMath.Multiply(self.Velocity(), math.pow(stiffness, dt * SpeedMultiplier)))

	-- Update the spring value based on velocity
	self.Value(ValueMath.Add(self.Value(), ValueMath.Multiply(self.Velocity(), dt * SpeedMultiplier)))

	if typeof(self.Value()) == "Color3" then
		local color = self.Value()
		self.Value(Color3.new(math.clamp(color.R, 0, 1), math.clamp(color.G, 0, 1), math.clamp(color.B, 0, 1)))
	end

	return self
end

function Spring:BindToRenderStep()
	local x = RunService.RenderStepped:Connect(function(dt: number)
		self:Update(dt)
	end)

	table.insert(SpringModule.Created, x)
	return x
end

function Spring:BindToUpdate(func: (value: any) -> ())
	local connect_signal = Reactive.Signal(self.Value, func)
	table.insert(self.Connections, connect_signal)
	table.insert(SpringModule.Created, connect_signal)

	return connect_signal
end

function Spring:BindAndPlay(func: (value: any) -> ())
	self:Play()

	return self:BindToUpdate(func)
end

function Spring:BindToProperty(Object: any, Property: string)
	return self:BindToUpdate(function(value)
		Object[Property] = value
	end)
end

return SpringModule
