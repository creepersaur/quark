local function lerp(start, finish, alpha: number, clamp: boolean?)
	-- Clamp alpha between 0 and 1
	if clamp then
		alpha = math.clamp(alpha, 0, 1)
	end

	-- Handle different data types
	local startType = typeof(start)
	local finishType = typeof(finish)

	-- Check if types match
	if startType ~= finishType then
		error(string.format("Cannot lerp between different types: %s and %s", startType, finishType))
	end

	-- Lerp based on type
	if startType == "number" then
		return start + (finish - start) * alpha
	elseif startType == "boolean" then
		return alpha < 0.5 and start or finish
	elseif startType == "Color3" then
		return start:Lerp(finish, alpha)
	elseif startType == "ColorSequenceKeypoint" then
		return ColorSequenceKeypoint.new(lerp(start.Time, finish.Time, alpha), start.Value:Lerp(finish.Value, alpha))
	elseif startType == "DateTime" then
		return DateTime.fromUnixTimestamp(lerp(start.UnixTimestamp, finish.UnixTimestamp, alpha))
	elseif startType == "NumberRange" then
		return NumberRange.new(lerp(start.Min, finish.Min, alpha), lerp(start.Max, finish.Max, alpha))
	elseif startType == "NumberSequenceKeypoint" then
		return NumberSequenceKeypoint.new(
			lerp(start.Time, finish.Time, alpha),
			lerp(start.Value, finish.Value, alpha),
			lerp(start.Envelope, finish.Envelope, alpha)
		)
	elseif startType == "PhysicalProperties" then
		return PhysicalProperties.new(
			lerp(start.Density, finish.Density, alpha),
			lerp(start.Friction, finish.Friction, alpha),
			lerp(start.Elasticity, finish.Elasticity, alpha),
			lerp(start.FrictionWeight, finish.FrictionWeight, alpha),
			lerp(start.ElasticityWeight, finish.ElasticityWeight, alpha)
		)
	elseif startType == "Ray" then
		return Ray.new(start.Origin:Lerp(finish.Origin, alpha), start.Direction:Lerp(finish.Direction, alpha))
	elseif startType == "Rect" then
		return Rect.new(
			lerp(start.Min.X, finish.Min.X, alpha),
			lerp(start.Min.Y, finish.Min.Y, alpha),
			lerp(start.Max.X, finish.Max.X, alpha),
			lerp(start.Max.Y, finish.Max.Y, alpha)
		)
	elseif startType == "Region3" then
		local position = start.CFrame.Position:Lerp(finish.CFrame.Position, alpha)
		local size = start.Size:Lerp(finish.Size, alpha)
		return Region3.new(position - size / 2, position + size / 2)
	elseif startType == "Region3int16" then
		return Region3int16.new(
			Vector3int16.new(
				lerp(start.Min.X, finish.Min.X, alpha),
				lerp(start.Min.Y, finish.Min.Y, alpha),
				lerp(start.Min.Z, finish.Min.Z, alpha)
			),
			Vector3int16.new(
				lerp(start.Max.X, finish.Max.X, alpha),
				lerp(start.Max.Y, finish.Max.Y, alpha),
				lerp(start.Max.Z, finish.Max.Z, alpha)
			)
		)
	elseif startType == "UDim" then
		return UDim.new(lerp(start.Scale, finish.Scale, alpha), math.round(lerp(start.Offset, finish.Offset, alpha)))
	elseif startType == "UDim2" then
		return start:Lerp(finish, alpha)
	elseif startType == "Vector2" then
		return start:Lerp(finish, alpha)
	elseif startType == "Vector2int16" then
		return Vector2int16.new(math.round(lerp(start.X, finish.X, alpha)), math.round(lerp(start.Y, finish.Y, alpha)))
	elseif startType == "Vector3" then
		return start:Lerp(finish, alpha)
	elseif startType == "Vector3int16" then
		return Vector3int16.new(
			math.round(lerp(start.X, finish.X, alpha)),
			math.round(lerp(start.Y, finish.Y, alpha)),
			math.round(lerp(start.Z, finish.Z, alpha))
		)
	elseif startType == "CFrame" then
		return start:Lerp(finish, alpha)
	else
		error(string.format("Unsupported type for lerp: %s", startType))
	end
end

-- Multiply function
local function multiply(a, b)
	local aType = typeof(a)
	local bType = typeof(b)

	if aType == "number" and bType == "number" then
		return a * b
	elseif aType == "number" and bType == "Color3" then
		return Color3.new(b.R * a, b.G * a, b.B * a)
	elseif aType == "Color3" and bType == "number" then
		return Color3.new(a.R * b, a.G * b, a.B * b)
	elseif aType == "Vector2" and bType == "number" then
		return a * b
	elseif aType == "number" and bType == "Vector2" then
		return b * a
	elseif aType == "Vector3" and bType == "number" then
		return a * b
	elseif aType == "number" and bType == "Vector3" then
		return b * a
	elseif aType == "CFrame" and bType == "number" then
		return a * b
	elseif aType == "number" and bType == "CFrame" then
		return b * a
	elseif aType == "UDim" and bType == "number" then
		return UDim.new(a.Scale * b, a.Offset * b)
	elseif aType == "number" and bType == "UDim" then
		return UDim.new(b.Scale * a, b.Offset * a)
	elseif aType == "UDim2" and bType == "number" then
		return UDim2.new(a.X.Scale * b, a.X.Offset * b, a.Y.Scale * b, a.Y.Offset * b)
	elseif aType == "number" and bType == "UDim2" then
		return UDim2.new(b.X.Scale * a, b.X.Offset * a, b.Y.Scale * a, b.Y.Offset * a)
	else
		error(string.format("Cannot multiply types: %s and %s", aType, bType))
	end
end

-- Add function
local function add(a, b)
	local aType = typeof(a)
	local bType = typeof(b)

	if aType ~= bType then
		error(string.format("Cannot add different types: %s and %s", aType, bType))
	end

	if aType == "number" then
		return a + b
	elseif aType == "Color3" then
		return Color3.new(math.clamp(a.R + b.R, 0, 1), math.clamp(a.G + b.G, 0, 1), math.clamp(a.B + b.B, 0, 1))
	elseif aType == "Vector2" then
		return a + b
	elseif aType == "Vector3" then
		return a + b
	elseif aType == "CFrame" then
		return a * b
	elseif aType == "UDim" then
		return UDim.new(a.Scale + b.Scale, a.Offset + b.Offset)
	elseif aType == "UDim2" then
		return a + b
	else
		error(string.format("Cannot add type: %s", aType))
	end
end

return {
    Lerp = lerp,
    Multiply = multiply,
    Add = add
}