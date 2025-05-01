local State = require(script.Parent.Parent.Reactive.State)
local Types = require(script.Parent.Parent.Types)
local all_instances = require(script.Parent.all_instances)
local all_properties = require(script.Parent.all_properties)
local default_properties = require(script.Parent.default_properties)
local Created = {}

local function AddChildren(self, list)
	if not list[1] then
		if type(list) == "table" and list._is_entries then
			list = list.Object
		end

		if type(list) == "table" and not list._is_new then
			if list.Children then
				AddChildren(self, list.Children)
				return
			end
		elseif type(list) == "table" and list.Object then
			local new_object = list.Object
			new_object.Parent = self.Object
			table.insert(Created, new_object)
			table.insert(self.Children, list)

			if rawget(self, "Style") then
				local style = rawget(self, "Style")
				if type(list) == "table" then
					rawset(list, "Style", style)
				end
				style:ApplyRecursive(list)
			end

			return
		end
	end

	for _, obj in list do
		if type(obj) == "table" and obj._is_state then
			obj = obj()
		end

		if type(list) == "table" and obj._is_entries then
			obj = obj.Object
		end

		if type(obj) == "table" and not obj.GetObject and not obj._is_new then
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
type PROPERTY_X = all_properties.ALL_PROPERTIES
type New<T> = Types.New<T>

local EventPrefix = "_event|"

function New<T>(
	ClassName: Instance | INSTANCE_X
): T | ({ [string]: any } & PROPERTY_X) -> New<T> & T & Instance & () -> New<T>
	local obj: any = ClassName
	if type(obj) == "string" then
		obj = Instance.new((ClassName :: any) :: string)
	end

	local self = {
		Object = obj,
		Children = {},
		__id = "x" .. math.random(-9_223_372_036_854_774_4, 9_223_372_036_854_774_4),
		Style = nil,
		Class = State.new "",
		_is_new = true,
	}

	local signal_connections: { Types.Signal<any> } = {}

	local class_connection = self.Class.connect(function()
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

	function self:Cleanup()
		self.Object:Destroy()
		class_connection:Disconnect()
		for _, v in signal_connections do
			v:Disconnect()
		end
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
			if not Properties then
				return self
			end
			local queuedParent = nil
			for i, v in Properties do
				if i == "children" then
					if v._is_state then
						v = v()
					elseif not v.Object and #v < 1 then
						continue
					end

					self.Children = v
					AddChildren(self, v)
				elseif i == "Parent" then
					queuedParent = (type(v) == "table" and v.Object) or v
				elseif i == "class" then
					rawget(self, "Class")(v)
				elseif i == "style" then
					rawset(self, "Style", v)
					v:ApplyRecursive(self)
				elseif string.sub(i, 1, #EventPrefix) == EventPrefix then
					assert(
						isSignal(self.Object, i:split(EventPrefix)[2]),
						"`OnEvent` should only be used for event signals."
					)
					assert(
						type(v) == "function",
						"(OnEvent) RBXScriptSignal requires a function for connection."
					)
					table.insert(
						signal_connections,
						self.Object[i]:Connect(function(...)
							v(self, ...)
						end)
					)
				elseif type(i) == "function" then
					if string.sub(i, 1, #EventPrefix) ~= EventPrefix then
						self.Object[i] = v(self)
					end
				else
					if type(v) == "table" then
						if v._is_state then
							self.Object[i] = v()
							table.insert(
								signal_connections,
								v.connect(function(value)
									self.Object[i] = value
								end)
							)
						elseif v._is_spring or v._is_tween then
							local e = v.Value
							self.Object[i] = e()
							table.insert(
								signal_connections,
								e.connect(function(value)
									self.Object[i] = value
								end)
							)
						end
					else
						self.Object[i] = v
					end
				end
			end

			if queuedParent then
				self.Object.Parent = queuedParent
			end

			return self :: any
		end,
	})

	if type(ClassName) == "string" then
		if default_properties[ClassName] then
			self(default_properties[ClassName])
		end
	end

	table.insert(Created, self)

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
	OnEvent = function(EventName: string)
		return EventPrefix .. EventName
	end,
	Created = Created,
}
