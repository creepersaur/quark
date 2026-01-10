return function()
	local StyleSheet = require(script.StyleSheet)()
	local Styles = {
		Created = {},
	}

	Styles.StyleSheet = StyleSheet
	Styles.Created = StyleSheet.Created

	return Styles
end
