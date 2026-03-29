return function()
	local Stylesheet = require(script.Stylesheet)()
	local Styles = {
		Created = {},
	}

	Styles.Stylesheet = Stylesheet
	Styles.Created = Stylesheet.Created

	return Styles
end
