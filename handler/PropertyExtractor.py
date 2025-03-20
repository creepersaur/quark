import json
import os

f = open("handler\\Roblox_data.json", "r")
data = json.loads(f.read())
props = {}

enums = ["AccessModifierType", "AccessoryType", "ActionOnStopSync", "ActionType", "ActuatorRelativeTo", "ActuatorType", "AdAvailabilityResult", "AdEventType", "AdFormat", "AdShape", "AdTeleportMethod", "AdUIEventType", "AdUIType", "AdUnitStatus", "AdornCullingMode", "AlignType", "AlphaMode", "AnalyticsCustomFieldKeys", "AnalyticsEconomyAction", "AnalyticsEconomyFlowType", "AnalyticsEconomyTransactionType", "AnalyticsLogLevel", "AnalyticsProgressionStatus", "AnalyticsProgressionType", "AnimationClipFromVideoStatus", "AnimationPriority", "AnimatorRetargetingMode", "AnnotationEditingMode", "AnnotationRequestResult", "AnnotationRequestType", "AppLifecycleManagerState", "AppShellActionType", "AppShellFeature", "AppUpdateStatus", "ApplyStrokeMode", "AspectType", "AssetCreatorType", "AssetFetchStatus", "AssetType", "AssetTypeVerification", "AudioApiRollout", "AudioChannelLayout", "AudioFilterType", "AudioSimulationFidelity", "AudioSubType", "AudioWindowSize", "AutoIndentRule", "AutomaticSize", "AvatarAssetType", "AvatarChatServiceFeature", "AvatarContextMenuOption", "AvatarGenerationError", "AvatarItemType", "AvatarPromptResult", "AvatarThumbnailCustomizationType", "AvatarUnificationMode", "Axis", "BenefitType", "BinType", "BodyPart", "BodyPartR15", "BorderMode", "BreakReason", "BreakpointRemoveReason", "BulkMoveMode", "BundleType", "Button", "ButtonStyle", "CageType", "CameraMode", "CameraPanMode", "CameraSpeedAdjustBinding", "CameraType", "CatalogCategoryFilter", "CatalogSortAggregation", "CatalogSortType", "CellBlock", "CellMaterial", "CellOrientation", "CenterDialogType", "CharacterControlMode", "ChatCallbackType", "ChatColor", "ChatMode", "ChatPrivacyMode", "ChatRestrictionStatus", "ChatStyle", "ChatVersion", "ClientAnimatorThrottlingMode", "CloseReason", "CollaboratorStatus", "CollisionFidelity", "CommandPermission", "CompileTarget", "CompletionAcceptanceBehavior", "CompletionItemKind", "CompletionItemTag", "CompletionTriggerKind", "ComputerCameraMovementMode", "ComputerMovementMode", "ConnectionError", "ConnectionState", "ContentSourceType", "ContextActionPriority", "ContextActionResult", "ControlMode", "CoreGuiType", "CreateAssetResult", "CreateOutfitFailure", "CreatorType", "CreatorTypeFilter", "CurrencyType", "CustomCameraMode", "DataStoreRequestType", "DebuggerEndReason", "DebuggerExceptionBreakMode", "DebuggerFrameType", "DebuggerPauseReason", "DebuggerStatus", "DevCameraOcclusionMode", "DevComputerCameraMovementMode", "DevComputerMovementMode", "DevTouchCameraMovementMode", "DevTouchMovementMode", "DeveloperMemoryTag", "DeviceFeatureType", "DeviceForm", "DeviceLevel", "DeviceType", "DialogBehaviorType", "DialogPurpose", "DialogTone", "DominantAxis", "DraftStatusCode", "DragDetectorDragStyle", "DragDetectorPermissionPolicy", "DragDetectorResponseStyle", "DraggerCoordinateSpace", "DraggerMovementMode", "DraggingScrollBar", "EasingDirection", "EasingStyle", "EditableStatus", "ElasticBehavior", "EnviromentalPhysicsThrottle", "ExperienceAuthScope", "ExplosionType", "FACSDataLod", "FacialAnimationStreamingState", "FieldOfViewMode", "FillDirection", "FilterErrorType", "FilterResult", "FinishRecordingOperation", "FluidFidelity", "FluidForces", "Font", "FontSize", "FontStyle", "FontWeight", "ForceLimitMode", "FormFactor", "FrameStyle", "FramerateManagerMode", "FriendRequestEvent", "FriendStatus", "FunctionalTestResult", "GameAvatarType", "GamepadType", "GearGenreSetting", "GearType", "Genre", "GraphicsMode", "GraphicsOptimizationMode", "GuiState", "GuiType", "HandlesStyle", "HapticEffectType", "HighlightDepthMode", "HorizontalAlignment", "HoverAnimateSpeed", "HttpCachePolicy", "HttpCompression", "HttpContentType", "HttpError", "HttpRequestType", "HumanoidCollisionType", "HumanoidDisplayDistanceType", "HumanoidHealthDisplayType", "HumanoidRigType", "HumanoidStateType", "IKCollisionsMode", "IKControlConstraintSupport", "IKControlType", "IXPLoadingStatus", "ImageAlphaType", "ImageCombineType", "InOut", "InfoType", "InitialDockState", "InputActionType", "InputType", "IntermediateMeshGenerationResult", "InterpolationThrottlingMode", "InviteState", "ItemLineAlignment", "JoinSource", "JointCreationMode", "KeyCode", "KeyInterpolationMode", "KeywordFilterType", "Language", "LeftRight", "LexemeType", "LightingStyle", "Limb", "LineJoinMode", "ListDisplayMode", "ListenerLocation", "ListenerType", "LiveEditingAtomicUpdateResponse", "LiveEditingBroadcastMessageType", "LoadCharacterLayeredClothing", "LoadDynamicHeads", "LocationType", "MarketplaceBulkPurchasePromptStatus", "MarketplaceItemPurchaseStatus", "MarketplaceProductType", "MarkupKind", "MatchmakingType", "Material", "MaterialPattern", "MembershipType", "MeshPartDetailLevel", "MeshPartHeadsAndAccessories", "MeshScaleUnit", "MeshType", "MessageType", "ModelLevelOfDetail", "ModelStreamingBehavior", "ModelStreamingMode", "ModerationStatus", "ModifierKey", "MouseBehavior", "MoveState", "MoverConstraintRootBehaviorMode", "MuteState", "NameOcclusion", "NetworkOwnership", "NetworkStatus", "NoiseType", "NormalId", "NotificationButtonType", "OperationType", "OrientationAlignmentMode", "OutfitSource", "OutfitType", "OutputLayoutMode", "OverrideMouseIconBehavior", "PackagePermission", "PartType", "ParticleEmitterShape", "ParticleEmitterShapeInOut", "ParticleEmitterShapeStyle", "ParticleFlipbookLayout", "ParticleFlipbookMode", "ParticleFlipbookTextureCompatible", "ParticleOrientation", "PathStatus", "PathWaypointAction", "PathfindingUseImprovedSearch", "PermissionLevelShown", "PhysicsSimulationRate", "PhysicsSteppingMethod", "Platform", "PlaybackState", "PlayerActions", "PlayerCharacterDestroyBehavior", "PlayerChatType", "PlayerDataErrorState", "PlayerDataLoadFailureBehavior", "PoseEasingDirection", "PoseEasingStyle", "PositionAlignmentMode", "PreferredTextSize", "PrimalPhysicsSolver", "PrimitiveType", "PrivilegeType", "ProductLocationRestriction", "ProductPurchaseChannel", "ProductPurchaseDecision", "PromptCreateAssetResult", "PromptCreateAvatarResult", "PromptPublishAssetResult", "PropertyStatus", "ProximityPromptExclusivity", "ProximityPromptInputType", "ProximityPromptStyle", "QualityLevel", "R15CollisionType", "RaycastFilterType", "RejectCharacterDeletions", "RenderFidelity", "RenderPriority", "RenderingCacheOptimizationMode", "RenderingTestComparisonMethod", "ReplicateInstanceDestroySetting", "ResamplerMode", "ReservedHighlightId", "RestPose", "ReturnKeyType", "ReverbType", "RibbonTool", "RigScale", "RigType", "RollOffMode", "RolloutState", "RotationOrder", "RotationType", "RtlTextSupport", "RunContext", "RunState", "RuntimeUndoBehavior", "SafeAreaCompatibility", "SalesTypeFilter", "SandboxedInstanceMode", "SaveAvatarThumbnailCustomizationFailure", "SaveFilter", "SavedQualitySetting", "ScaleType", "ScopeCheckResult", "ScreenInsets", "ScreenOrientation", "ScrollBarInset", "ScrollingDirection", "SecurityCapability", "SelectionBehavior", "SelectionRenderMode", "SelfViewPosition", "SensorMode", "SensorUpdateType", "ServerLiveEditingMode", "ServiceVisibility", "Severity", "ShowAdResult", "SignalBehavior", "SizeConstraint", "SolverConvergenceMetricType", "SolverConvergenceVisualizationMode", "SortDirection", "SortOrder", "SpecialKey", "StartCorner", "StateObjectFieldType", "Status", "StreamOutBehavior", "StreamingIntegrityMode", "StreamingPauseMode", "StudioCloseMode", "StudioDataModelType", "StudioPlaceUpdateFailureReason", "StudioScriptEditorColorCategories", "StudioScriptEditorColorPresets", "StudioStyleGuideColor", "StudioStyleGuideModifier", "Style", "SubscriptionExpirationReason", "SubscriptionPaymentStatus", "SubscriptionPeriod", "SubscriptionState", "SurfaceConstraint", "SurfaceGuiShape", "SurfaceGuiSizingMode", "SurfaceType", "SwipeDirection", "TableMajorAxis", "TeamCreateErrorState", "Technology", "TeleportMethod", "TeleportResult", "TeleportState", "TeleportType", "TerrainAcquisitionMethod", "TerrainFace", "TextChatMessageStatus", "TextDirection", "TextFilterContext", "TextInputType", "TextTruncate", "TextXAlignment", "TextYAlignment", "TextureMode", "TextureQueryType", "ThreadPoolConfig", "ThrottlingPriority", "ThumbnailSize", "ThumbnailType", "TickCountSampleMethod", "TonemapperPreset", "TopBottom", "TouchCameraMovementMode", "TouchMovementMode", "TrackerError", "TrackerExtrapolationFlagMode", "TrackerFaceTrackingStatus", "TrackerLodFlagMode", "TrackerLodValueMode", "TrackerMode", "TrackerPromptEvent", "TrackerType", "TriStateBoolean", "TweenStatus", "UICaptureMode", "UIDragDetectorBoundingBehavior", "UIDragDetectorDragRelativity", "UIDragDetectorDragSpace", "UIDragDetectorDragStyle", "UIDragDetectorResponseStyle", "UIDragSpeedAxisMapping", "UIFlexAlignment", "UIFlexMode", "UITheme", "UiMessageType", "UsageContext", "UserCFrame", "UserInputState", "UserInputType", "VRComfortSetting", "VRControllerModelMode", "VRDeviceType", "VRLaserPointerMode", "VRSafetyBubbleMode", "VRScaling", "VRSessionState", "VRTouchpad", "VRTouchpadMode", "VelocityConstraintMode", "VerticalAlignment", "VerticalScrollBarPosition", "VibrationMotor", "VideoDeviceCaptureQuality", "VideoError", "ViewMode", "VirtualCursorMode", "VirtualInputMode", "VoiceChatState", "VoiceControlPath", "VolumetricAudio", "WaterDirection", "WaterForce", "WebSocketState", "WeldConstraintPreserve", "WhisperChatPrivacyMode", "WrapLayerAutoSkin", "WrapLayerDebugMode", "WrapTargetDebugMode", "ZIndexBehavior", ]
ignore = ["VideoQualitySettings", "ErrorReporting"]
important_classes = [""]

def get_type_from_string(vType: str):
	match vType:
		case "int": vType = "number"
		case "float": vType = "number"
		case "int64": vType = "number"
		case "ProtectedString": vType = "string"
		case "double": vType = "number"
		case "Rect2D": vType = "Rect"
		case "bool": vType = "boolean"
		case "CoordinateFrame": vType = "CFrame"
		case "Property": vType = "string"
		case "BinaryString": vType = "string"
		case "Tuple": vType = "{any}"
		case "Dictionary": vType = "{any}"
		case "Array": vType = "{any}"
		case "Map": vType = "{any}"
		case "Objects": vType = "{Object}"
		case "Variant": vType = "{any}"

	if vType in enums:
		vType = f"Enum.{vType}"

	if vType.startswith("Class:"):
		vType = vType.replace("Class:", "")
	
	return vType

for i in data:
	if i["type"] == "Property" and "hidden" not in i["tags"]:
		vType: str = i["ValueType"]
		vType = get_type_from_string(vType)

		if vType in ignore: continue
		
		# vType += "?"
		if i["Name"] in props:
			if vType in props[i["Name"]]: continue
			props[i["Name"]].append(vType)
		else:
			props[i["Name"]] = [vType]
	
	if i["type"] == "Event":
		args = i["Arguments"]
		compiled_args = []

		for a in args:
			vType = get_type_from_string(a["Type"])
			compiled_args.append(vType)

		arg_string = ", ".join(compiled_args)
		vType = f"RBXScriptSignal<{arg_string}>"

		if i["Name"] in props:
			if vType in props[i["Name"]]: continue
			props[i["Name"]].append(vType)
		else:
			props[i["Name"]] = [vType]

		#! NOTE: This isn't perfectly accurate
		#! In a perfect world we'd have different types per ClassName

props["Destroying"] = ["RBXScriptSignal<...any>"]

output = "export type ALL_PROPERTIES = {\n"
for i, v in props.items():
	type_string = "|".join(v)

	output += f"\t{i}: {type_string},\n"
output += "}\n\nreturn 0"

open('handler\\output.luau', "w").write(output)