local ReplicatedStorage = game:GetService("ReplicatedStorage")

local State = require(ReplicatedStorage.Shared.Quark.Reactive.State)
local Types = require(script.Parent.Parent.Types)
local all_instances = require(script.Parent.all_instances)
local Created = {}

local function AddChildren(self, list)
	if not list[1] then
		if typeof(list) == "table" and not list._is_new then
			AddChildren(self, list.Children)
		else
			local new_object = (list.Object or list)
			new_object.Parent = self.Object
			table.insert(Created, new_object)
			table.insert(self.Children, list)

			if rawget(self, "Style") then
				local style = rawget(self, "Style")
				if typeof(list) == "table" then
					rawset(list, "Style", style)
				end
				style:ApplyRecursive(list)
			end
		end

		return
	end

	if #list < 1 then
		return
	end

	for _, obj in list do
		if typeof(obj) == "table" and obj._is_state then
			obj = obj()
		end

		if typeof(obj) == "table" and not obj.GetObject and not obj._is_new then
			AddChildren(self, obj)
		else
			local new_object = (obj.GetObject and obj.GetObject(obj) or obj)
			new_object.Parent = self.Object
			table.insert(Created, new_object)

			if rawget(self, "Style") then
				rawget(self, "Style"):ApplyRecursive(obj)
			end
		end
	end
end

type INSTANCE_X = all_instances.ALL_INSTANCES
type New<T> = Types.New<T>

function New<T>(ClassName: Instance | INSTANCE_X | string): T | ({ [string]: any }) -> New<T> & T
	local obj: any = ClassName
	if typeof(obj) == "string" then
		obj = Instance.new(ClassName :: string)
	end

	local self = {
		Object = obj,
		Children = {},
		__id = "x" .. math.random(0, math.huge),
		Style = nil,
		Class = State.new "",
		_is_new = true,
	}

	self.Class.connect(function()
		local style = rawget(self, "Style")
		if style then
			style:ApplyRecursive(self)
		end
	end)

	function self:PushChildren(children: { any })
		for i, v in children do
			if v._is_state then
				v = v()
			end

			AddChildren(self, v)
		end
		table.insert(self.Children, children)

		return self
	end

	function self:Push(child: any)
		if child._is_state then
			child = child()
		end

		AddChildren(self, child)

		return self
	end

	function self:PushClass(class: string)
		self.Class(`{self.Class()} {class}`)

		return self
	end

	function self.GetObject(self)
		return self.Object
	end

	self = setmetatable(self, {
		__index = function(self, key)
			local object = rawget(self, "Object")
			local sucess, obj_value = pcall(function()
				return object[key]
			end)
			local value = (sucess and obj_value) or rawget(self, key)

			if type(value) == "function" then
				-- Wrap the function so it can be called with ':'
				return function(_, ...)
					return value(object, ...)
				end
			end

			return value
		end,
		__newindex = function(self, idx, value)
			self.Object[idx] = value
		end,
		__call = function(self, Properties: { [string]: any }): New<T>
			for i, v in Properties do
				if i == "children" then
					if v._is_state then
						v = v()
					end

					self.Children = v
					AddChildren(self, v)
				elseif i == "Parent" then
					self.Object.Parent = (typeof(v) == "table" and v.Object) or v
				elseif i == "class" then
					rawget(self, "Class")(v)
				elseif i == "style" then
					rawset(self, "Style", v)
				elseif isSignal(self.Object, i) then
					assert(
						typeof(v) == "function" or typeof(v) == "table" and v._is_state,
						"RBXScriptSignal requires a function for connection."
					)
					table.insert(
						Created,
						self.Object[i]:Connect(function(...)
							v(self, ...)
						end)
					)
				else
					if typeof(v) == "table" then
						if v._is_state then
							self.Object[i] = v()
							v.connect(function(value)
								self.Object[i] = value
							end)
						elseif v._is_spring or v._is_tween then
							v:BindToProperty(self.Object, i)
						end
					else
						self.Object[i] = v
					end
				end
			end

			return self :: any
		end,
	})

	table.insert(Created, self.Object)

	return self :: any
end

function isSignal(object, propertyName)
	-- Check if object exists
	if not object then
		return false
	end

	-- Use pcall to safely check the property
	local success, result = pcall(function()
		return typeof(object[propertyName]) == "RBXScriptSignal"
	end)

	-- Return false if pcall failed, otherwise return the result
	return success and result
end

return {
	New = New,
	Created = Created,
}
