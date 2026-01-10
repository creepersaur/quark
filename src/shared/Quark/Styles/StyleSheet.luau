local all_properties = require(script.Parent.Parent.Misc.all_properties)
local custom_properties = require(script.Parent.Parent.Misc.custom_properties)
local Types = require(script.Parent.Parent.Types)

return function()
	local module = {
		Created = {},
		_class_id = "__class__",
	}

	function module.Class(name: string)
		return `{module._class_id}{name}`
	end

	local Style = {
		__new_index = function(self, idx, value)
			if rawget(self, idx) then
				self[idx] = value
			else
				self.Properties[idx] = value
			end
		end,
	}

	Style.__index = Style

	-- [[ Handle custom properties ]]
	local function HandleCustomProperties(obj: any, prop: string, value: any)
		local is_custom = true
		local item = nil

		if prop == "corner_radius" or prop == "corner" then
			item = Instance.new("UICorner")
			if type(value) == "number" then
				item.CornerRadius = UDim.new(0, value)
			else
				item.CornerRadius = value
			end
		elseif prop == "aspect_ratio" or prop == "aspect" then
			item = Instance.new("UIAspectRatioConstraint")
			item.AspectRatio = value
		elseif prop == "stroke" or prop == "border" then
			item = Instance.new("UIStroke")
			item.Thickness = value.Thickness or 1
			item.Color = value.Color or Color3.new()
			item.Transparency = value.Transparency or 0
			item.ApplyStrokeMode = value.ApplyStrokeMode or Enum.ApplyStrokeMode.Contextual
		elseif prop == "padding" then
			item = Instance.new("UIPadding")
			if type(value) == "number" then
				item.PaddingLeft = UDim.new(0, value)
				item.PaddingRight = UDim.new(0, value)
				item.PaddingTop = UDim.new(0, value)
				item.PaddingBottom = UDim.new(0, value)
			elseif typeof(value) == "UDim" then
				item.PaddingLeft = value
				item.PaddingRight = value
				item.PaddingTop = value
				item.PaddingBottom = value
			else
				for i, v in value do
					if i == "left" then
						i = "PaddingLeft"
					elseif i == "right" then
						i = "PaddingRight"
					elseif i == "top" then
						i = "PaddingTop"
					elseif i == "bottom" then
						i = "PaddingBottom"
					end

					if type(v) == "number" then
						item[i] = UDim.new(0, v)
					else
						item[i] = v
					end
				end
			end
		else
			is_custom = false
		end

		if item then
			item.Parent = obj
		end

		return is_custom
	end

	--[[ Write properties to an object ]]
	local function WriteObjectProperties(obj: any, style_properties: { [string]: any })
		for i, v in style_properties do
			if not HandleCustomProperties(obj, i, v) then
				obj[i] = v
			end
		end
	end

	--[[ Create a new Style object ]]
	function module.new(name: string)
		return function(
			Styles: { [string]: all_properties.ALL_PROPERTIES & custom_properties.StyleProperties }
		): Types.Style
			local self = setmetatable({
				Properties = Styles or {},
			}, Style)

			module.Created[name] = self

			return self
		end
	end

	--[[ Apply the style to the object and its DESCENDANTS. ]]
	function Style:ApplyRecursive(obj: any)
		self:ApplySingle(obj)

		local _, child_table = pcall(function()
			return rawget(obj, "Children")
		end)

		if not child_table then
			return
		end

		for _, v in child_table do
			if v[1] then
				for _, p in v do
					self:ApplyRecursive(p)
				end
			else
				self:ApplyRecursive(v)
			end
		end
	end

	--[[ Apply the style to the object. ]]
	function Style:ApplySingle(obj: any)
		local ObjectUnwrapped = (type(obj) == "table" and obj.Object) or obj
		local style_properties = self.Properties[ObjectUnwrapped.ClassName]
		if style_properties then
			WriteObjectProperties(ObjectUnwrapped, style_properties)
		end

		local class = type(obj) == "table" and obj.Class
		if not class then
			return
		end

		local split = class():split(" ")
		for _, v in split do
			if #v < 1 then
				continue
			end

			style_properties = self.Properties[`{module._class_id}{v}`]
			if style_properties then
				WriteObjectProperties(ObjectUnwrapped, style_properties)
			end
		end
	end

	--[[ Push Properties to the existing style. ]]
	function Style:Push(name: string)
		return function(Properties: { [string]: any })
			self[name] = Properties
		end
	end

	function module.GetStyle(name: string)
		return module.Created[name]
	end

	return module
end
