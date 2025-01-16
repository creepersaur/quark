local RunService = game:GetService "RunService"

local Types = require(script.Parent.Parent.Types)
local Reactive = require(script.Parent.Parent.Reactive)
local ValueMath = require(script.Parent.ValueMath)

local TweenModule = {
	Created = {},
}

local Tween = {}
Tween.__index = Tween

function TweenModule.new<T>(
	start: Types.CanBeState<T>,
	target: Types.CanBeState<T>,
	Info: TweenInfo,
	fixedStart: boolean?
): Types.Tween<T>
	local self = setmetatable({
		Start = start or 0,
		Value = Reactive.State(nil),
		Target = target or 1,
		Timer = 0,
		Info = Info or TweenInfo.new(1),
		Repeated = 0,
		Completed = false,
		Reversed = false,
		FixedStart = fixedStart or false,
		Connections = {},
		PlayConnection = nil,
		_is_tween = true,
	}, Tween)

	return self
end

function Tween:Play()
	self:Pause()
	local start = self.Start
	if typeof(start) == "table" and start._is_state then
		start = start()
	end
	if self.Value() == nil then
		self.Value(start)
	end
	self.PlayConnection = self:BindToRenderStep()
	table.insert(TweenModule.Created, self.Connections)
	table.insert(TweenModule.Created, self.PlayConnection)

	return self
end

function Tween:Restart()
	self.Value(nil)
	return self:Play()
end

function Tween:Pause()
	if self.PlayConnection then
		self.PlayConnection:Disconnect()
	end

	return self
end

function Tween:Cancel()
	self:Pause()
	for _, v in self.Connections do
		v(self.Value(self.Start))
	end

	return self
end

function Tween:DisconnectAll()
	for _, v: Types.Signal in self.Connections do
		if v then
			v:Disconnect()
		end
	end

	return self
end

function Tween:SetValue(value)
	self.Value(value)

	return self
end

function Tween:GetEasedAlpha(alpha: number, easingStyle: Enum.EasingStyle): number
	if easingStyle == Enum.EasingStyle.Sine then
		return math.sin((alpha * math.pi) / 2)

	elseif easingStyle == Enum.EasingStyle.Quad then
		return alpha * alpha

	elseif easingStyle == Enum.EasingStyle.Cubic then
		return alpha * alpha * alpha

	elseif easingStyle == Enum.EasingStyle.Quart then
		return alpha ^ 4

	elseif easingStyle == Enum.EasingStyle.Quint then
		return alpha ^ 5

	elseif easingStyle == Enum.EasingStyle.Exponential then
		return if alpha == 0 then 0 else 2^(10 * (alpha - 1))

	elseif easingStyle == Enum.EasingStyle.Circular then
		return 1 - math.sqrt(1 - alpha^2)

	elseif easingStyle == Enum.EasingStyle.Back then
		local c1, c3 = 1.70158, 2.70158
		return c3 * alpha^3 - c1 * alpha^2

	elseif easingStyle == Enum.EasingStyle.Elastic then
		if alpha == 0 then return 0 end
		if alpha == 1 then return 1 end
		local c4 = (2 * math.pi) / 3
		return -2^(10 * (alpha - 1)) * math.sin((alpha * 10 - 10.75) * c4)

	elseif easingStyle == Enum.EasingStyle.Bounce then
		local function bounceOut(x)
			if x < 1 / 2.75 then
				return 7.5625 * x * x
			elseif x < 2 / 2.75 then
				return 7.5625 * (x - 1.5 / 2.75) * (x - 1.5 / 2.75) + 0.75
			elseif x < 2.5 / 2.75 then
				return 7.5625 * (x - 2.25 / 2.75) * (x - 2.25 / 2.75) + 0.9375
			else
				return 7.5625 * (x - 2.625 / 2.75) * (x - 2.625 / 2.75) + 0.984375
			end
		end
		return 1 - bounceOut(1 - alpha)
	end

	-- Default to Linear if unknown
	return alpha
end

function Tween:GetEasedDirection(alpha: number): number
	local easingDirection = self.Info.EasingDirection
	local easingStyle = self.Info.EasingStyle

	if self.Reversed then
		alpha = 1 - alpha
	end

	if easingDirection == Enum.EasingDirection.In then
		return self:GetEasedAlpha(alpha, easingStyle)
	elseif easingDirection == Enum.EasingDirection.Out then
		return 1 - self:GetEasedAlpha(1 - alpha, easingStyle)
	elseif easingDirection == Enum.EasingDirection.InOut then
		if alpha < 0.5 then
			return self:GetEasedAlpha(2 * alpha, easingStyle) / 2
		else
			return 1 - self:GetEasedAlpha(2 * (1 - alpha), easingStyle) / 2
		end
	end

	-- Default to In if unknown direction
	return self:GetEasedAlpha(alpha, easingStyle)
end

function Tween:Update(dt)
	local delayTime = self.Reversed and 0 or self.Info.DelayTime
	if self.Completed then
		return self
	end

	if self.Timer >= self.Info.Time + delayTime then
		local repCount = self.Info.RepeatCount
		if self.Info.Reverses then
			self.Reversed = not self.Reversed
		end

		self.Repeated += self.Info.Reverses and 0.5 or 1

		if math.floor(self.Repeated) >= repCount + 1 and repCount >= 0 then
			self.Completed = true
			return self
		else
			self.Completed = false
			self.Timer = 0
		end
	end

	delayTime = self.Reversed and 0 or self.Info.DelayTime
	self.Timer = math.min(self.Timer + dt * 1.001, self.Info.Time + delayTime)

	if self.Timer < delayTime then
		return self
	end

	local start = self.Start
	if typeof(start) == "table" and start._is_state then
		start = start()
	end

	local target = self.Target
	if typeof(target) == "table" and target._is_state then
		target = target()
	end

	-- Update Value
	local alpha = (self.Timer - delayTime) / self.Info.Time
	local easedAlpha = self:GetEasedDirection(alpha)
	local x = ValueMath.Multiply(start, -1)
	local y = ValueMath.Add(target, x)
	local z = ValueMath.Multiply(y, easedAlpha)
	local currentValue = ValueMath.Add(start, z)

	-- Fix Color3
	if typeof(currentValue) == "Color3" then
		local color = currentValue
		currentValue = Color3.new(math.clamp(color.R, 0, 1), math.clamp(color.G, 0, 1), math.clamp(color.B, 0, 1))
	end

	self.Value(currentValue)

	return self
end

function Tween:BindToRenderStep()
	local x = RunService.RenderStepped:Connect(function(dt: number)
		self:Update(dt)
	end)

	table.insert(TweenModule.Created, x)
	return x
end

function Tween:BindToUpdate(func: (value: any) -> ())
	local connect_signal = self.Value.connect(func)
	table.insert(self.Connections, connect_signal)
	table.insert(TweenModule.Created, connect_signal)

	if typeof(self.Target) == "table" and self.Target._is_state then
		local target_signal = self.Target.connect(function()
			if not self.FixedStart then
				self.Start = table.clone(self.Value)
			end
			self.Completed = false
			self.Timer = 0
		end)
		table.insert(self.Connections, target_signal)
		table.insert(TweenModule.Created, target_signal)
	end

	return self
end

function Tween:BindAndPlay(func: (value: any) -> ())
	self:Play()
	self:BindToUpdate(func)

	return self
end

function Tween:BindToProperty(Object: any, Property: string)
	self:BindToUpdate(function(value)
		Object[Property] = value
	end)

	return self
end

return TweenModule
