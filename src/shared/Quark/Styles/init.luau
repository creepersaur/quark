local module = {
	Created = {},
	_class_id = "__class_",
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

export type Style = {
	ApplyRecursive: (obj: any) -> (),
	ApplySingle: (obj: any) -> (),
	Push: (name: string) -> (),
	Properties: { [string]: { [string]: any } },
}

--[[ Create a new Style object ]]
function module.new(name: string)
	return function(Styles: { [string]: { [string]: any } }): Style
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

    if not child_table then return end

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
	local ObjectUnwrapped = (typeof(obj) == "table" and obj.Object) or obj
	local style_properties = self.Properties[ObjectUnwrapped.ClassName]
	if style_properties then
		WriteObjectProperties(ObjectUnwrapped, style_properties)
	end

	local class = typeof(obj) == "table" and obj.Class
	if not class then
		return
	end

	local split = class():split " "
	for _, v in split do
        if #v < 1 then continue end

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

--[[ Write properties to an object ]]
function WriteObjectProperties(obj: any, style_properties: { [string]: any })
	for i, v in style_properties do
		obj[i] = v
	end
end

function module.GetStyle(name: string)
	return module.Created[name]
end

return module
