export type CUSTOM_PROPERTIES = {
	children: { any } | any,
	class: string,
	style: { any },
}

export type StyleProperties = {
	[string]: {
		corner: UDim | number?,
		corner_radius: UDim | number?,

		aspect_ratio: number?,
		aspect: number?,
		stroke: {
			Thickness: number?,
			Color: Color3?,
			ApplyStrokeMode: Enum.ApplyStrokeMode?,
			Transparency: number?,
		}?,

		padding: number | UDim | {
			left: number | UDim?,
			PaddingLeft: number | UDim?,
			right: number | UDim?,
			PaddingRight: number | UDim?,
			top: number | UDim?,
			PaddingTop: number | UDim?,
			bottom: number | UDim?,
			PaddingBottom: number | UDim?,
		},
	},
}

return 0
