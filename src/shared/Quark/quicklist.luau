ql = {}

export type QuickList<T> = {
	t: { [number]: T },
	copy: () -> QuickList<T>,
	deep_copy: () -> QuickList<T>,
	insert: (pos: number?, value: T) -> QuickList<T>,
	append: (...T) -> QuickList<T>,
	append_table: (_table: { [T]: T }) -> QuickList<T>,
	join: (sep: string?) -> string,
	split: (index: number?) -> QuickList<T>,
	sort: (comp: ((T, T) -> boolean) | ("descending" | "desc")?) -> QuickList<T>,
	forEach: (func: (v: T) -> ()) -> QuickList<T>,
	enumerate: (func: (i: number, v: T) -> ()) -> QuickList<T>,
	merge: (tab: QuickList<T> | { [T]: T }) -> QuickList<T>,
	retain: (func: (i: number, v: T) -> boolean, should_remove: boolean?) -> QuickList<T>,
	rep: (value: T, times: number?) -> QuickList<T>,
	remove: (pos: number | T) -> QuickList<T>,
	pop: (pos: number) -> T,
	move: (pos1: number, pos2: number) -> QuickList<T>,
	reverse: () -> QuickList<T>,
	string: (str: string, sep: string?) -> QuickList<T>,
	find: (value: T) -> number?,
	count: (value: T) -> number,
	count_by: (func: (T) -> boolean?) -> number,
	unique: () -> QuickList<T>,
	get_table: (((i: number, v: T) -> boolean?)?) -> { [number]: T },
	shuffle: () -> QuickList<T>,
	random: () -> T,
	flatten: () -> QuickList<T>,
	average: () -> number,
	startsWith: (tab: { [T]: T }) -> boolean,
	endsWith: (tab: { [T]: T }) -> boolean,
	checkql: (tab: T) -> boolean,
	sum: () -> number,
	setEach: (func: (i: number, v: T) -> T) -> QuickList<T>,
	first: () -> T?,
	last: () -> T?,
	execN: (amount: number, func: (i: number) -> T) -> QuickList<T>,
	filter: ((i: number, v: T) -> boolean?) -> QuickList<T>,
}

function flattenTable(tab)
	local flat = {}
	for i = 1, #tab do
		print(tab[i])
		if type(tab[i]) == "table" then
			for _, j in ipairs(flattenTable(tab[i])) do
				table.insert(flat, j)
			end
		else
			table.insert(flat, tab[i])
		end
	end
	return flat
end

function checkql(tab)
	if type(tab) ~= "table" then
		return false
	end
	local mt = getmetatable(tab)
	return mt and mt.__index == ql
end

function getNegativeIndex(tab, index)
	if index < 1 then
		return #tab + index
	end
	return index
end

function concat(tab, sep, _scope)
	local str = ""
	for i, v in ipairs(tab) do
		if type(v) == "table" then
			str = str .. tostring(ql(v))
		else
			str = str .. tostring(v)
		end
		if i < #tab then
			str = str .. sep
		end
	end
	return str
end

-- function concat_dictionary(tab, sep, scope)
-- 	local str = ""
-- 	for i, v in tab do
-- 		local tabs = string.rep("	", scope + 1)
-- 		local value = tostring(v)
-- 		if typeof(v) == "table" then
-- 			value = concat_table(v, sep or ",", scope + 1)
-- 		end
-- 		local line = "[" .. '"' .. i .. '"' .. "] = " .. value .. (sep or ",") .. "\n"
-- 		str = str .. tabs .. line
-- 	end
-- 	return str
-- end

function concat_table(self, separator, scope)
	-- scope -= 1
	-- local array = true
	-- for i, _ in self do
	-- 	if type(i) ~= "number" then
	-- 		array = false
	-- 	end
	-- end

	if #self < 1 then
		return "[]"
	end

	local vertical = #self > 10
	local indent = " "
	local str = `[{scope == 1 and vertical and "\n" or ""}`

	for i, v in (checkql(self) and self.t) or self do
		local sep = (i == #self) and "" or separator
		if typeof(v) == "string" then
			str = str .. `"{v}"{sep}`
		elseif typeof(v) == "table" then
			str = str
				.. `{vertical and string.rep(indent, scope * 20 - 1) or ""}{concat_table(v, separator, scope + 1)}{sep}{vertical and "\n" or ""}`
		else
			str = str .. `{v}{sep}`
		end
	end

	return str .. `{string.rep(indent, scope == 1 and vertical and 16 or 0)}]`
end

local customMethods = {}

function setupCustom()
	--[[This creates a shallow copy of the table
    self.copy() : QuickList<T>
    ]]
	function customMethods.copy<T>(self): QuickList<T>
		return ql(table.clone(self.t))
	end

	--[[This creates a deep copy of the table
       self.copy() : QuickList<T>
    ]]
	function customMethods.deep_copy<T>(self)
		local copy = ql {}
		for k, v in self do
			if type(v) == "table" and checkql(v) then
				v = customMethods.deep_copy(v)
			end
			self[k] = v
		end
		return copy
	end

	--[[Insert a value at a specific index. Anything infront will be pushed forward.
    () : self
    ]]
	function customMethods.insert<T>(self, pos, value): QuickList<T>
		if pos and not value then
			warn "Position was given (ql.insert()) but value was not. Did you want `ql.append()` ?"
		end
		pos = pos or #self.t + 1
		table.insert(self.t, pos, value)
		return self
	end

	--[[Inser a value at the end of the table.
    () : self
    ]]
	function customMethods.append<T>(self, ...): QuickList<T>
		for _, v in { ... } do
			table.insert(self.t, v)
		end
		return self
	end

	function customMethods.append_table<T>(self, _table: {}): QuickList<T>
		self.append(table.unpack(_table))
		return self
	end

	--[[Join the table using a separator. (Optional)
    () : string
    ]]
	function customMethods.join<T>(self, sep): string
		sep = sep or ""
		return concat(self.t, sep)
	end

	--[[Split the table into 2 tables using an index.
    () : QuickList<T>:{QuickList<T>, QuickList<T>}
    ]]
	function customMethods.split<T>(self, index): (QuickList<T>, QuickList<T>)
		index = index or math.ceil(#self / 2)
		return self { 1, index }, self { index + 1, #self }
	end

	--[[Returns a sorted copy of the table.
    Use the parameter "descending" or "desc" to sort descending or provide a function(a,b).
    (Comparison:(Optional)) : QuickList<T>
    ]]
	function customMethods.sort<T>(self, comp): QuickList<T>
		if comp == "descending" or comp == "desc" then
			comp = function(a, b)
				return b < a
			end
		end

		local copy = self.copy()
		table.sort(copy.t, comp)

		return copy
	end

	--Loop through the list. Callback ( v:Value ).
	function customMethods.forEach<T>(self, func): QuickList<T>
		for i = 1, #self.t do
			if func then
				func(self.t[i])
			end
		end
		return self
	end

	--Loop through the list. Callback ( i:Index, v:Value ).
	function customMethods.enumerate<T>(self, func): QuickList<T>
		for i = 1, #self.t do
			if func then
				func(i, self.t[i])
			end
		end
		return self
	end

	--[[Merge a copy of this table with another. Appends the values to the end.
    () : QuickList<T>
    ]]
	function customMethods.merge<T>(self, tab): QuickList<T>
		assert(type(tab) == "table", "A QuickList<T> or table must be provided.")
		local copy = self.copy()

		if not checkql(tab) then
			copy.append(table.unpack(tab))
			return copy
		end

		copy.append(table.unpack(tab.get_table()))
		return copy
	end

	function customMethods.retain<T>(self: QuickList<T>, func, should_remove)
		if should_remove then
			for i = #self.t, 1, -1 do
				if not func(i, self[i]) then
					self.remove(i)
				end
			end
			return self
		else
			local newTable = {}
			self.enumerate(function(i, v)
				if func(i, v) then
					-- print(v)
					table.insert(newTable, v)
				end
			end)
			return ql(nil, newTable)
		end
	end

	--Add a value multiple times to the end.
	function customMethods.rep<T>(self, value, times): QuickList<T>
		times = times or 1
		for _ = 1, times do
			self.append(value)
		end
		return self
	end

	--Remove a value at position.
	function customMethods.remove<T>(self, pos): QuickList<T>
		if tonumber(pos) then
			table.remove(self.t, pos)
		else
			local index = self.find(pos)
			if index then
				table.remove(self.t, index)
			else
				self.t[pos] = nil
			end
		end
		return self
	end

	--Removes the value at position, but returns it as well.
	function customMethods.pop<T>(self, pos): any
		local val = self[pos]
		self.remove(pos)
		return val
	end

	--Move a value from 1 position/index to another.
	function customMethods.move<T>(self, pos1, pos2): QuickList<T>
		self.insert(pos2, self.pop(pos1))
		return self
	end

	--Returns a reversed copy of the table.
	function customMethods.reverse<T>(self): QuickList<T>
		local newTable = ql()
		for i = #self, 1, -1 do
			newTable.append(self[i])
		end
		return newTable
	end

	--Split a string into a QuickList<T>
	-- (string:string, sep:string) : QuickList<T>
	function customMethods.string<T>(_self, str, sep): QuickList<T>
		sep = sep or " "
		local result = ql()
		for match in (str .. sep):gmatch("(.-)" .. sep) do
			result.append(match)
		end
		return result
	end

	--Check if a value exists in the table.
	--Returns first index of value if it exists.
	--Returns nil if it doesn't.
	function customMethods.find<T>(self, value): number
		local index = nil
		self.enumerate(function(i, v)
			if v == value then
				index = i
				return
			end
		end)
		return index
	end

	--Get how many times a value shows up in the table.
	function customMethods.count<T>(self, value): number
		local count = 0
		self.forEach(function(v)
			if v == value then
				count = count + 1
			end
		end)
		return count
	end

	--Get how many times a value shows up in the table.
	--Using a custom count function: ((object) -> true)
	function customMethods.count_by<T>(self, func): number
		local count = 0
		self.forEach(function(v)
			if func(v) then
				count = count + 1
			end
		end)
		return count
	end

	--Return a copy of this table with unique values.
	--If any value is repeated, it will only show up once.
	-- () : QuickList<T>
	function customMethods.unique<T>(self): QuickList<T>
		local newTable = ql()
		self.forEach(function(v)
			if not newTable.find(v) then
				newTable.append(v)
			end
		end)
		return newTable
	end

	--Return the `table`, with optional function to dictate what's in the table (not a quicklist).
	--Optional function will not order by normal.
	--E.g {[1] = 'hello', [5] = 'world'}
	function customMethods.get_table<T>(self, func)
		local dict = {}
		self.enumerate(function(i, v)
			if func then
				if func(i, v) then
					dict[i] = v
				end
			else
				dict[i] = v
			end
		end)
		return dict
	end

	--Returns a shuffled copy of the table.
	function customMethods.shuffle<T>(self)
		local list = self.t
		for i = #list, 2, -1 do
			local j = math.random(i)
			list[i], list[j] = list[j], list[i]
		end
		return ql(list)
	end

	--Get a pseudo-random value from the table.
	function customMethods.random<T>(self)
		return self[math.random(#self)]
	end

	--Return a new QuickList<T> by flattening nested tables.
	function customMethods.flatten<T>(self)
		local flat = ql(flattenTable(self.t))
		return flat
	end

	--Get the average of all number values inside the table.
	function customMethods.average<T>(self)
		local average = 0
		local n = 0
		self.forEach(function(v)
			if tonumber(v) then
				average = average + v
				n = n + 1
			end
		end)
		return average / n
	end

	--Check if the QuickList<T> starts with a given sequence (table) of elements.
	function customMethods.startsWith<T>(self, tab)
		for i = 1, #tab do
			if tab[i] ~= self[i] then
				return false
			end
		end
		return true
	end

	--Check if the QuickList<T> ends with a given sequence (table) of elements.
	function customMethods.endsWith<T>(self, tab)
		local lenDiff = #self - #tab
		for i = #tab, 1, -1 do
			if tab[i] ~= self[i + lenDiff] then
				return false
			end
		end
		return true
	end

	--Check if a table is a QuickList<T>
	function customMethods.checkql<T>(_self, tab)
		if type(tab) ~= "table" then
			return false
		end
		local mt = getmetatable(tab)
		return mt and mt.__index == ql
	end

	function customMethods.sum<T>(self)
		local res = 0
		self.forEach(function(v)
			if tonumber(v) then
				res = res + tonumber(v)
			end
		end)
		return res
	end

	function customMethods.setEach<T>(self, func)
		self.enumerate(function(i, v)
			self[i] = func(i, v)
		end)
		return self
	end

	function customMethods.first<T>(self)
		if #self > 0 then
			return self[1]
		end
		return
	end

	function customMethods.last<T>(self)
		if #self > 0 then
			return self[#self]
		end
		return
	end

	function customMethods.execN<T>(self, amount: number, func: (i: number) -> any)
		for i = 1, amount do
			self.append(func(i))
		end

		return self
	end

	function customMethods.filter<T>(self, func)
		local new = {}
		self.enumerate(function(i, v)
			if func(i, v) then
				table.insert(new, v)
			end
		end)
		return ql(new)
	end
end

setupCustom()

------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

-- Creates a new 'QuickList<T>' array. Use ql{values} to make it easier to make a QuickList<T>.
--Made by creepersaur. Go subscribe to my youtube channel 😀.
function ql.new<T>(_self, _table): QuickList<T>
	_table = _table or {}
	if checkql(_table) then
		_table = _table.t
	end

	local self = { t = _table } :: QuickList<T>
	self = setmetatable(self, ql)

	return self
end

function setupql()
	ql.__type = "QuickList"
	function ql.__index(self, index)
		if tonumber(index) then
			return self.t[getNegativeIndex(self, index)]
		end

		if customMethods[index] then
			return function(...)
				return customMethods[index](self, ...)
			end
		end

		return self.t[index]
	end

	function ql.__call<T>(self, index): QuickList<T>?
		if type(index) ~= "table" or #index < 1 then
			return
		end
		local _start = index[1]
		local _end = #self.t
		local _inter = 1
		if #index > 1 then
			_end = getNegativeIndex(self, index[2])
			if #index == 3 then
				_inter = index[3]
			end
		end

		local newTable = {}
		for i = _start, _end, _inter do
			table.insert(newTable, self.t[i])
		end
		return ql(newTable)
	end

	function ql.__len(self): number
		return #self.t
	end

	function ql.__tostring(self): string
		return concat_table(self.t, ", ", 1)
	end

	function ql.__newindex(self, key, value)
		self.t[key] = value
	end

	function ql.__eq(self, other): boolean
		local res = true
		self.enumerate(function(i, v)
			if v ~= other[i] then
				res = false
				return
			end
		end)
		return res
	end

	function ql.__add<T>(self, other): QuickList<T>
		local copy = self.copy()
		copy.enumerate(function(i, v)
			if #other < i then
				return
			end
			pcall(function()
				copy[i] = v + other[i]
			end)
		end)
		return copy
	end

	function ql.lt(self, other)
		if self.sum() < other.sum() then
			return true
		end
		return false
	end

	function ql.le(self, other)
		return ql.lt(self, other) or self.sum() == other.sum()
	end

	function ql.__concat(self, other): string
		local copy = self.copy()
		copy.forEach(function(i, v)
			pcall(function()
				if type(other) == "table" then
					copy[i] = v .. other[i]
				else
					copy[i] = other
				end
			end)
		end)
		return copy
	end
end

setupql()

return setmetatable(ql, {
	__call = ql.new,
})
