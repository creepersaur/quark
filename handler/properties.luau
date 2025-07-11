export type ALL_PROPERTIES = {
	AnimationId: string,
	Guid: string,
	Loop: boolean,
	Priority: Enum.AnimationPriority,
	AuthoredHipHeight: number,
	Animation: TrackerStreamAnimation|Animation,
	FACSDataLod: Enum.FACSDataLod,
	IsPlaying: boolean,
	WeightCurrent: number,
	WeightTarget: number,
	Length: number,
	Looped: boolean,
	Speed: number|NumberRange,
	TimePosition: number,
	SelectionImageObject: GuiObject,
	Version: number,
	CurrentScreenOrientation: Enum.ScreenOrientation,
	ScreenOrientation: Enum.ScreenOrientation,
	ProcessUserInput: boolean,
	ResetPlayerGuiOnSpawn: boolean,
	RtlTextSupport: Enum.RtlTextSupport,
	ShowDevelopmentGui: boolean,
	StudioDefaultStyleSheet: StyleSheet,
	StudioInsertWidgetLayerCollectorAutoLinkStyleSheet: StyleSheet,
	VirtualCursorMode: Enum.VirtualCursorMode,
	AssetId: number,
	BodyPart: Enum.BodyPart,
	Color: Color3|BrickColor|ColorSequence,
	Instance: Instance,
	CursorIcon: string,
	MaxActivationDistance: number,
	ActivatedCursorIcon: string,
	ApplyAtCenterOfMass: boolean,
	Axis: Vector3,
	DragFrame: CFrame,
	DragStyle: Enum.DragDetectorDragStyle|Enum.UIDragDetectorDragStyle,
	Enabled: boolean,
	GamepadModeSwitchKeyCode: Enum.KeyCode,
	KeyboardModeSwitchKeyCode: Enum.KeyCode,
	MaxDragAngle: number,
	MaxDragTranslation: Vector3|UDim2,
	MaxForce: number,
	MaxTorque: number,
	MinDragAngle: number,
	MinDragTranslation: Vector3|UDim2,
	Orientation: Vector3|Enum.ParticleOrientation,
	PermissionPolicy: Enum.DragDetectorPermissionPolicy,
	ReferenceInstance: Instance,
	ResponseStyle: Enum.DragDetectorResponseStyle|Enum.UIDragDetectorResponseStyle,
	Responsiveness: number,
	RunLocally: boolean,
	SecondaryAxis: Vector3,
	TrackballRadialPullFactor: number,
	TrackballRollFactor: number,
	VRSwitchKeyCode: Enum.KeyCode,
	WorldAxis: Vector3,
	WorldSecondaryAxis: Vector3,
	Active: boolean,
	Attachment0: Attachment,
	Attachment1: Attachment,
	Visible: boolean,
	C0: CFrame,
	C1: CFrame,
	IsKinematic: boolean,
	Part0: BasePart,
	Part1: BasePart,
	Transform: CFrame,
	LimitsEnabled: boolean,
	MaxFrictionTorque: number,
	Radius: number,
	Restitution: number,
	TwistLimitsEnabled: boolean,
	TwistLowerAngle: number,
	TwistUpperAngle: number,
	UpperAngle: number,
	ActuatorType: Enum.ActuatorType,
	AngularResponsiveness: number,
	AngularSpeed: number,
	AngularVelocity: number,
	CurrentAngle: number,
	LowerAngle: number,
	MotorMaxAcceleration: number,
	MotorMaxTorque: number,
	ServoMaxTorque: number,
	SoftlockServoUponReachingTarget: boolean,
	TargetAngle: number,
	CurrentDistance: number,
	LimitAngle0: number,
	LimitAngle1: number,
	Thickness: number,
	WinchEnabled: boolean,
	WinchForce: number,
	WinchResponsiveness: number,
	WinchSpeed: number,
	WinchTarget: number,
	CurrentPosition: number,
	LinearResponsiveness: number,
	LowerLimit: number,
	MotorMaxForce: number,
	ServoMaxForce: number,
	Size: number|UDim2|Vector3|NumberSequence,
	TargetPosition: number,
	UpperLimit: number,
	Velocity: number|Vector3,
	AngularActuatorType: Enum.ActuatorType,
	AngularLimitsEnabled: boolean,
	AngularRestitution: number,
	InclinationAngle: number,
	MotorMaxAngularAcceleration: number,
	RotationAxisVisible: boolean,
	SoftlockAngularServoUponReachingTarget: boolean,
	WorldRotationAxis: Vector3,
	Coils: number,
	CurrentLength: number,
	Damping: number,
	FreeLength: number,
	MaxLength: number,
	MinLength: number,
	Stiffness: number,
	LimitEnabled: boolean,
	MaxAngle: number,
	Source: Instance,
	BiometricDataConsent: boolean,
	ServiceState: number,
	Description: string,
	AbsolutePosition: Vector2,
	AbsoluteRotation: number,
	AbsoluteSize: Vector2,
	AutoLocalize: boolean,
	ClippedRect: Rect,
	IsNotOccluded: boolean,
	Localize: boolean,
	RawRect2D: Rect,
	RootLocalizationTable: LocalizationTable,
	SelectionBehaviorDown: Enum.SelectionBehavior,
	SelectionBehaviorLeft: Enum.SelectionBehavior,
	SelectionBehaviorRight: Enum.SelectionBehavior,
	SelectionBehaviorUp: Enum.SelectionBehavior,
	SelectionGroup: boolean,
	TotalGroupScale: number,
	AnchorPoint: Vector2,
	AutomaticSize: Enum.AutomaticSize,
	BackgroundColor: BrickColor,
	BackgroundColor3: Color3,
	BackgroundTransparency: number,
	BorderColor: BrickColor,
	BorderColor3: Color3,
	BorderMode: Enum.BorderMode,
	BorderSizePixel: number,
	ClipsDescendants: boolean,
	Draggable: boolean,
	GuiState: Enum.GuiState,
	Interactable: boolean,
	LayoutOrder: number,
	NextSelectionDown: GuiObject,
	NextSelectionLeft: GuiObject,
	NextSelectionRight: GuiObject,
	NextSelectionUp: GuiObject,
	Position: UDim2|Vector3|Vector2,
	Rotation: number|Vector3|NumberRange,
	Selectable: boolean,
	SelectionOrder: number,
	SelectionRect2D: Rect,
	SizeConstraint: Enum.SizeConstraint,
	Transparency: number|NumberSequence,
	ZIndex: number,
	GroupColor3: Color3,
	GroupTransparency: number,
	ResolutionScale: number,
	Style: Enum.FrameStyle|Enum.ButtonStyle|Enum.Style|Enum.ProximityPromptStyle,
	AutoButtonColor: boolean,
	HoverHapticEffect: HapticEffect,
	Modal: boolean,
	PressHapticEffect: HapticEffect,
	Selected: boolean,
	ContentImageSize: Vector2,
	HoverImage: string,
	Image: string,
	ImageColor3: Color3,
	ImageContent: Content,
	ImageRectOffset: Vector2,
	ImageRectSize: Vector2,
	ImageTransparency: number,
	IsLoaded: boolean,
	PressedImage: string,
	ResampleMode: Enum.ResamplerMode,
	ScaleType: Enum.ScaleType,
	SliceCenter: Rect,
	SliceScale: number,
	TileSize: UDim2,
	ContentText: string,
	Font: Enum.Font,
	FontFace: Enum.Font,
	FontSize: Enum.FontSize,
	LineHeight: number,
	LocalizationMatchIdentifier: string,
	LocalizationMatchedSourceText: string,
	LocalizedText: string,
	MaxVisibleGraphemes: number,
	OpenTypeFeatures: string,
	OpenTypeFeaturesError: string,
	RichText: boolean,
	Text: string,
	TextBounds: Vector2,
	TextColor: BrickColor,
	TextColor3: Color3,
	TextDirection: Enum.TextDirection,
	TextFits: boolean,
	TextScaled: boolean,
	TextSize: number,
	TextStrokeColor3: Color3,
	TextStrokeTransparency: number,
	TextTransparency: number,
	TextTruncate: Enum.TextTruncate,
	TextWrap: boolean,
	TextWrapped: boolean,
	TextXAlignment: Enum.TextXAlignment,
	TextYAlignment: Enum.TextYAlignment,
	AbsoluteCanvasSize: Vector2,
	AbsoluteWindowSize: Vector2,
	AutomaticCanvasSize: Enum.AutomaticSize,
	BottomImage: string,
	CanvasPosition: Vector2,
	CanvasSize: UDim2|Vector2,
	DraggingScrollBar: Enum.DraggingScrollBar,
	ElasticBehavior: Enum.ElasticBehavior,
	HorizontalBarRect: Rect,
	HorizontalScrollBarInset: Enum.ScrollBarInset,
	MaxCanvasPosition: Vector2,
	MidImage: string,
	ScrollBarImageColor3: Color3,
	ScrollBarImageTransparency: number,
	ScrollBarThickness: number,
	ScrollRate: number,
	ScrollVelocity: Vector2,
	ScrollingDirection: Enum.ScrollingDirection,
	ScrollingEnabled: boolean,
	SmoothScroll: boolean,
	TopImage: string,
	VerticalBarRect: Rect,
	VerticalScrollBarInset: Enum.ScrollBarInset,
	VerticalScrollBarPosition: Enum.VerticalScrollBarPosition,
	ClearTextOnFocus: boolean,
	CursorPosition: number,
	ManualFocusRelease: boolean,
	MultiLine: boolean,
	OverlayNativeInput: boolean,
	PlaceholderColor3: Color3,
	PlaceholderText: string,
	ReturnKeyType: Enum.ReturnKeyType,
	SelectionStart: number,
	ShouldEmitReturnEvents: boolean,
	ShouldEmitUpAndDownArrowEvents: boolean,
	ShowNativeInput: boolean,
	TextEditable: boolean,
	TextInputType: Enum.TextInputType,
	Playing: boolean,
	Resolution: Vector2,
	TimeLength: number,
	Video: string,
	Volume: number,
	Ambient: Color3,
	CurrentCamera: Camera,
	IsMirrored: boolean,
	LightColor: Color3,
	LightDirection: Vector3,
	Adornee: Instance|BasePart,
	AlwaysOnTop: boolean,
	Brightness: number,
	DistanceLowerLimit: number,
	DistanceStep: number,
	DistanceUpperLimit: number,
	ExtentsOffset: Vector3,
	ExtentsOffsetWorldSpace: Vector3,
	LightInfluence: number,
	MaxDistance: number,
	PlayerToHideFrom: Instance,
	SizeOffset: Vector2,
	StudsOffset: Vector3,
	StudsOffsetWorldSpace: Vector3,
	Title: string,
	HostWidgetWasRestored: boolean,
	ClipToDeviceSafeArea: boolean,
	DisplayOrder: number,
	IgnoreGuiInset: boolean,
	OnTopOfCoreBlur: boolean,
	SafeAreaCompatibility: Enum.SafeAreaCompatibility,
	ScreenInsets: Enum.ScreenInsets,
	Face: Enum.NormalId,
	AdShape: Enum.AdShape,
	EnableVideoAds: boolean,
	FallbackImage: string,
	Status: Enum.AdUnitStatus,
	HorizontalCurvature: number,
	PixelsPerStud: number,
	Shape: Enum.SurfaceGuiShape|Enum.PartType|Enum.ParticleEmitterShape,
	SizingMode: Enum.SurfaceGuiSizingMode,
	ToolPunchThroughDistance: number,
	ZOffset: number,
	Color3: Color3,
	Scale: Vector3|number,
	TargetSurface: Enum.NormalId,
	Part: BasePart,
	AutoSelectGuiEnabled: boolean,
	CoreEffectFolder: Folder,
	CoreGuiFolder: Folder,
	CoreGuiNavigationEnabled: boolean,
	GuiNavigationEnabled: boolean,
	IsModalDialog: boolean,
	IsWindows: boolean,
	MenuIsOpen: boolean,
	PreferredTextSize: Enum.PreferredTextSize,
	PreferredTransparency: number,
	ReducedMotionEnabled: boolean,
	SelectedCoreObject: GuiObject,
	SelectedObject: GuiObject,
	TopbarInset: Rect,
	TouchControlsEnabled: boolean,
	AddPathsToBundle: boolean,
	BuildDebouncePeriod: number,
	HighCompression: boolean,
	SerializePatch: boolean,
	ZstdCompression: boolean,
	Time: number,
	Value: string|CFrame,
	Angle: number,
	Range: number,
	Anchored: boolean,
	AssemblyAngularVelocity: Vector3,
	AssemblyCenterOfMass: Vector3,
	AssemblyLinearVelocity: Vector3,
	AssemblyMass: number,
	AssemblyRootPart: BasePart,
	AudioCanCollide: boolean,
	BackParamA: number,
	BackParamB: number,
	BackSurface: Enum.SurfaceType,
	BackSurfaceInput: Enum.InputType,
	BottomParamA: number,
	BottomParamB: number,
	BottomSurface: Enum.SurfaceType,
	BottomSurfaceInput: Enum.InputType,
	BrickColor: BrickColor,
	CFrame: CFrame,
	CanCollide: boolean,
	CanQuery: boolean,
	CanTouch: boolean,
	CastShadow: boolean,
	CenterOfMass: Vector3,
	CollisionGroup: string,
	CollisionGroupId: number,
	CurrentPhysicalProperties: PhysicalProperties,
	CustomPhysicalProperties: PhysicalProperties,
	Elasticity: number,
	EnableFluidForces: boolean,
	ExtentsCFrame: CFrame,
	ExtentsSize: Vector3,
	Friction: number,
	FrontParamA: number,
	FrontParamB: number,
	FrontSurface: Enum.SurfaceType,
	FrontSurfaceInput: Enum.InputType,
	LeftParamA: number,
	LeftParamB: number,
	LeftSurface: Enum.SurfaceType,
	LeftSurfaceInput: Enum.InputType,
	LocalTransparencyModifier: number,
	Locked: boolean,
	Mass: number,
	Massless: boolean,
	Material: Enum.Material,
	MaterialVariant: string,
	PivotOffset: CFrame,
	ReceiveAge: number,
	Reflectance: number,
	ResizeIncrement: number,
	ResizeableFaces: Faces,
	RightParamA: number,
	RightParamB: number,
	RightSurface: Enum.SurfaceType,
	RightSurfaceInput: Enum.InputType,
	RootPriority: number,
	RotVelocity: Vector3,
	SpecificGravity: number,
	TopParamA: number,
	TopParamB: number,
	TopSurface: Enum.SurfaceType,
	TopSurfaceInput: Enum.InputType,
	brickColor: BrickColor,
	FormFactor: Enum.FormFactor,
	formFactor: Enum.FormFactor,
	CollisionFidelity: Enum.CollisionFidelity,
	FluidFidelity: Enum.FluidFidelity,
	MeshSize: Vector3,
	UnscaledCofm: Vector3,
	UnscaledVolInertiaDiags: Vector3,
	UnscaledVolInertiaOffDiags: Vector3,
	UnscaledVolume: number,
	DoubleSided: boolean,
	HasJointOffset: boolean,
	HasSkinnedMesh: boolean,
	JointOffset: Vector3,
	MeshContent: Content,
	MeshId: string,
	RenderFidelity: Enum.RenderFidelity,
	TextureContent: Content,
	TextureID: string,
	SmoothingAngle: number,
	TriangleCount: number,
	UsePartColor: boolean,
	Acceleration: Vector3,
	Drag: number,
	EmissionDirection: Enum.NormalId,
	FlipbookFramerate: NumberRange,
	FlipbookIncompatible: string,
	FlipbookLayout: Enum.ParticleFlipbookLayout,
	FlipbookMode: Enum.ParticleFlipbookMode,
	FlipbookStartRandom: boolean,
	Lifetime: NumberRange,
	LightEmission: number,
	LockedToPart: boolean,
	Rate: number,
	RotSpeed: NumberRange,
	ShapeInOut: Enum.ParticleEmitterShapeInOut,
	ShapePartial: number,
	ShapeStyle: Enum.ParticleEmitterShapeStyle,
	SpreadAngle: Vector2,
	Squash: NumberSequence,
	Texture: string,
	TimeScale: number,
	VelocityInheritance: number,
	VelocitySpread: number,
	WindAffectsDrag: boolean,
	Data: string,
	MimeType: string,
	Sender: string,
	ActionText: string,
	ClickablePrompt: boolean,
	Exclusivity: Enum.ProximityPromptExclusivity,
	GamepadKeyCode: Enum.KeyCode,
	HoldDuration: number,
	KeyboardKeyCode: Enum.KeyCode,
	ObjectText: string,
	RequiresLineOfSight: boolean,
	UIOffset: Vector2,
	MaxPromptsVisible: number,
	EnableFallbackAudioInput: boolean,
	SessionName: string,
	TrackerMode: Enum.TrackerMode,
	TrackerType: Enum.TrackerType,
	CompileTarget: Enum.CompileTarget,
	CoverageInfo: boolean,
	DebugInfo: boolean,
	PackAsSource: boolean,
	RawBytecode: boolean,
	HitFrame: CFrame,
	HitNormal: Vector3,
	SearchDistance: number,
	SensedPart: BasePart,
	SensorMode: Enum.SensorMode,
	CenterOfPressure: Vector3,
	Force: Vector3,
	Torque: Vector3,
	FrameId: number,
	FrameName: string,
	FrameType: Enum.DebuggerFrameType,
	Globals: DebuggerVariable,
	Line: number,
	Locals: DebuggerVariable,
	Populated: boolean,
	Script: string,
	Upvalues: DebuggerVariable,
	AlphaMode: Enum.AlphaMode,
	ColorMap: string,
	ColorMapContent: Content,
	MetalnessMap: string,
	MetalnessMapContent: Content,
	NormalMap: string,
	NormalMapContent: Content,
	RoughnessMap: string,
	RoughnessMapContent: Content,
	TexturePack: string,
	AspectRatio: number,
	AspectType: Enum.AspectType,
	DominantAxis: Enum.DominantAxis,
	MaxSize: Vector2,
	MinSize: Vector2,
	MaxTextSize: number,
	MinTextSize: number,
	CornerRadius: UDim,
	BoundingBehavior: Enum.UIDragDetectorBoundingBehavior,
	BoundingUI: GuiBase2d,
	DragAxis: Vector2,
	DragRelativity: Enum.UIDragDetectorDragRelativity,
	DragRotation: number,
	DragSpace: Enum.UIDragDetectorDragSpace,
	DragUDim2: UDim2,
	ReferenceUIInstance: GuiObject,
	SelectionModeDragSpeed: UDim2,
	SelectionModeRotateSpeed: number,
	UIDragSpeedAxisMapping: Enum.UIDragSpeedAxisMapping,
	FlexMode: Enum.UIFlexMode,
	GrowRatio: number,
	ItemLineAlignment: Enum.ItemLineAlignment,
	ShrinkRatio: number,
	Offset: Vector2,
	AbsoluteContentSize: Vector2,
	FillDirection: Enum.FillDirection,
	HorizontalAlignment: Enum.HorizontalAlignment,
	SortOrder: Enum.SortOrder,
	VerticalAlignment: Enum.VerticalAlignment,
	AbsoluteCellCount: Vector2,
	AbsoluteCellSize: Vector2,
	CellPadding: UDim2,
	CellSize: UDim2,
	FillDirectionMaxCells: number,
	StartCorner: Enum.StartCorner,
	HorizontalFlex: Enum.UIFlexAlignment,
	Padding: UDim|UDim2,
	VerticalFlex: Enum.UIFlexAlignment,
	Wraps: boolean,
	Animated: boolean,
	Circular: boolean,
	CurrentPage: GuiObject,
	EasingDirection: Enum.EasingDirection,
	EasingStyle: Enum.EasingStyle,
	GamepadInputEnabled: boolean,
	ScrollWheelInputEnabled: boolean,
	TouchInputEnabled: boolean,
	TweenTime: number,
	FillEmptySpaceColumns: boolean,
	FillEmptySpaceRows: boolean,
	MajorAxis: Enum.TableMajorAxis,
	PaddingBottom: UDim,
	PaddingLeft: UDim,
	PaddingRight: UDim,
	PaddingTop: UDim,
	ApplyStrokeMode: Enum.ApplyStrokeMode,
	LineJoinMode: Enum.LineJoinMode,
}

return 0