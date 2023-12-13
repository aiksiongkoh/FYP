Class {
	#name : #CADDrawingInterface,
	#superclass : #GFDrawingInterface,
	#instVars : [
		'cadApp',
		'depthSortedGOsUnderCursor',
		'geoRootItem',
		'selectedGEOs',
		'worldFrame',
		'projectionFrame',
		'activeSketch',
		'mbdProcess'
	],
	#classVars : [
		'UI'
	],
	#category : #'StCAD-UI-CAD'
}

{ #category : #accessing }
CADDrawingInterface class >> defaultPalette [
	"Copyright (C) 1993-1995 Polymorphic Software, Inc. All Rights Reserved"
	"Answer the default palette of the tools I can use."
	| palette selectionTool |
	selectionTool := CADSelectionTool new.
	palette := GFToolPalette new.
	palette
		addCategory: ((GFCategory icon: (GFTool stockIconFor: 'Zorder')
					name: 'Z-Ordering Tools')
					defaultTool: selectionTool;
					addTool: GFGOActionTool bringToFront;
					addTool: GFGOActionTool sendToBack;
					yourself);
		addCategory: ((GFCategory icon: (GFTool stockIconFor: 'Lines')
					name: 'Line Tools')
					defaultTool: selectionTool;
					addTool: CADLineGO creationTool;
					addTool: CADLineGO arrowCreationTool;
					yourself);
		addCategory: ((GFCategory icon: (GFTool stockIconFor: 'ClosedGOs')
					name: 'Closed Path Tools')
					defaultTool: selectionTool;
					addTool: GFRectangleGO creationTool;
					addTool: GFRoundedRectangleGO creationTool;
					addTool: GFEllipseGO creationTool;
					addTool: GFImageGO creationTool;
					yourself);
		addCategory: ((GFCategory icon: (GFTool stockIconFor: 'Paths')
					name: 'Path Tools')
					defaultTool: selectionTool;
					addTool: GFBezierGO creationTool;
					addTool: GFPolylineGO creationTool;
					addTool: GFOrthogonalPathGO creationTool;
					addTool: GFOrthogonalPathGO arrowCreationTool;
					addTool: GFSplineGO creationTool;
					yourself);
		addCategory: ((GFCategory icon: (GFTool stockIconFor: 'Components')
					name: 'Host Widgets')
					defaultTool: selectionTool;
					addTool: GFTextGO creationTool;
					addTool: GFHostWidgetGO buttonCreationTool;
					addTool: GFHostWidgetGO textFieldCreationTool;
					addTool: GFHostWidgetGO paragraphCreationTool;
					addTool: GFHostWidgetGO listCreationTool;
					yourself).
	^palette.
]

{ #category : #accessing }
CADDrawingInterface class >> drawingClass [
	"Copyright (C) 1993-1995 Polymorphic Software, Inc. All Rights Reserved"
	^CADDrawing.
]

{ #category : #accessing }
CADDrawingInterface class >> eventsTriggered [
	"Always run 'PsiEventModel resetEventsTriggered' when events are added or removed."

	eventsTriggered isNil
		ifTrue: 
			[(eventsTriggered := Set new) addAll: self superclass eventsTriggered.
			eventsTriggered add: #deselect.
			eventsTriggered add: #noActiveSketch.
			eventsTriggered add: #getCADUnits.
			eventsTriggered add: #getMbDUnits.
			eventsTriggered add: #getMbDSystem].
	^eventsTriggered
]

{ #category : #'class initialization' }
CADDrawingInterface class >> initialize [

	"CADDrawingInterface initialize."

	"GEO is should not be aware of objects outside of its domain."

	"CADDrawingInterface does the translation."

	GEOtoCADdict := IdentityDictionary new.
	GEOtoCADdict at: GEOLine put: CADLineGO.
	GEOtoCADdict at: GEOPolyline put: CADPolylineGO.
	GEOtoCADdict at: DXFPolyline put: DXFPolylineGO.
	GEOtoCADdict at: GEOEquationCurve put: CADEquationCurveGO.
	GEOtoCADdict at: GEORectangle put: CADRectangleGO.
	GEOtoCADdict at: GEOCurveMarker put: CADCurveMarkerGO.
	GEOtoCADdict at: GEOMarker put: CADMarkerGO.
	GEOtoCADdict at: GEOMassMarker put: CADMassMarkerGO.
	GEOtoCADdict at: GEOWorldFrame2 put: CADWorldFrameGO.
	GEOtoCADdict at: GEOPlane put: CADPlaneGO.
	GEOtoCADdict at: GEOSketch put: CADSketchGO.
	GEOtoCADdict at: GEOAssembly put: CADAssemblyGO.
	GEOtoCADdict at: GEOPart put: CADPartGO.
	GEOtoCADdict at: GEOSolidModel put: CADSolidModelGO.
	GEOtoCADdict at: GEOWEFace put: CADFaceGO.
	GEOtoCADdict at: GEORectangle put: CADRectangleGO.
	GEOtoCADdict at: GEOEllipse put: CADEllipseGO.
	GEOtoCADdict at: GEOCircle put: CADCircleGO.
	GEOtoCADdict at: GEOAngleJoint put: CADAngleJointGO.
	GEOtoCADdict at: GEOCylindricalJoint put: CADCylindricalJointGO.
	GEOtoCADdict at: GEOPointInLineJoint put: CADPointInLineJointGO.
	GEOtoCADdict at: GEOPointInPlaneJoint put: CADPointInPlaneJointGO.
	GEOtoCADdict at: GEOLineInPlaneJoint put: CADLineInPlaneJointGO.
	GEOtoCADdict
		at: GEOConstantVelocityJoint
		put: CADConstantVelocityJointGO.
	GEOtoCADdict at: GEOScrewJoint put: CADScrewJointGO.
	GEOtoCADdict at: GEORackPinJoint put: CADRackPinJointGO.
	GEOtoCADdict at: GEOPerpendicularJoint put: CADPerpendicularJointGO.
	GEOtoCADdict at: GEOParallelAxesJoint put: CADParallelAxesJointGO.
	GEOtoCADdict at: GEOGearJoint put: CADGearJointGO.
	GEOtoCADdict at: GEOParallelGearJoint put: CADParallelGearJointGO.
	GEOtoCADdict at: GEONoRotationJoint put: CADNoRotationJointGO.
	GEOtoCADdict at: GEOFixedJoint put: CADFixedJointGO.
	GEOtoCADdict at: GEOPlanarJoint put: CADPlanarJointGO.
	GEOtoCADdict at: GEORevoluteJoint put: CADRevoluteJointGO.
	GEOtoCADdict at: GEOCVCVJoint put: CADCVCVJointGO.
	GEOtoCADdict at: GEOKineIJ put: CADKineIJGO.
	GEOtoCADdict at: GEORobotAxis put: CADRobotAxisGO.
	GEOtoCADdict at: GEORevCylJoint put: CADRevCylJointGO.
	GEOtoCADdict at: GEOCylSphJoint put: CADCylSphJointGO.
	GEOtoCADdict at: GEOSphericalJoint put: CADSphericalJointGO.
	GEOtoCADdict at: GEOSphSphJoint put: CADSphSphJointGO.
	GEOtoCADdict at: GEOTranslationalJoint put: CADTranslationalJointGO.
	GEOtoCADdict at: GEOUniversalJoint put: CADUniversalJointGO.
	GEOtoCADdict at: GEOGeneralMotion put: CADGeneralMotionGO.
	GEOtoCADdict at: GEOAllowZRotation put: CADAllowZRotationGO.
	GEOtoCADdict at: GEORotationalMotion put: CADRotationalMotionGO.
	GEOtoCADdict at: GEOTranslationalMotion put: CADTranslationalMotionGO.
	GEOtoCADdict at: GEOForceTorqueGeneral put: ForceTorqueGeneralGO.
	GEOtoCADdict at: GEOForceTorqueInLine put: ForceTorqueInLineGO.
	GEOtoCADdict at: StCAD_UI_PDMS_Frame put: StCAD_UI_PDMS_FrameGO. "VW_TRANSLATION:StCAD.UI.PDMS.FrameGO:StCAD_UI_PDMS_FrameGO" "VW_TRANSLATION:StCAD.UI.PDMS.Frame:StCAD_UI_PDMS_Frame"
	GEOtoCADdict at: StCAD_UI_MOSES_Frame put: StCAD_UI_MOSES_FrameGO. "VW_TRANSLATION:StCAD.UI.MOSES.FrameGO:StCAD_UI_MOSES_FrameGO" "VW_TRANSLATION:StCAD.UI.MOSES.Frame:StCAD_UI_MOSES_Frame"
	GEOtoCADdict at: StCAD_UI_POVRay_Frame put: StCAD_UI_POVRay_FrameGO. "VW_TRANSLATION:StCAD.UI.POVRay.FrameGO:StCAD_UI_POVRay_FrameGO" "VW_TRANSLATION:StCAD.UI.POVRay.Frame:StCAD_UI_POVRay_Frame"
	GEOtoCADdict at: GEOGravity put: CADGravityGO.
	GEOtoCADdict at: AmbientLighting put: CADLightingGO.
	GEOtoCADdict at: ParallelLighting put: CADLightingGO.
	GEOtoCADdict at: StCAD_UI_DXF_DXFBLOCK put: CADDXFBLOCKGO. "VW_TRANSLATION:StCAD.UI.DXF.DXFBLOCK:StCAD_UI_DXF_DXFBLOCK"
	GEOtoCADdict at: StCAD_NMT_Model put: CADNMTGO "VW_TRANSLATION:StCAD.NMT.Model:StCAD_NMT_Model"
]

{ #category : #'VisualWorks metadata' }
CADDrawingInterface class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'Polymorphic'
	)

]

{ #category : #calc }
CADDrawingInterface >> a3DCenter [
	^(geoRootItem == nil or: [geoRootItem rOcenterO == nil])
		ifTrue: [(FullColumn zero: 3)]
		ifFalse: [geoRootItem rOcenterO]
]

{ #category : #accessing }
CADDrawingInterface >> aGraphicViewPopupMenu [
	| interface answerMenu |
	interface := self interface.
	answerMenu := Menu new.
	answerMenu addItemLabel: '&Undo' value: [interface undo].
	^answerMenu
]

{ #category : #rendering }
CADDrawingInterface >> aParallelCameraWithBounds: aRect [ 
	^projectionFrame aParallelCameraWithBounds: aRect
		inPreferredRect: drawing drawingRect
]

{ #category : #rendering }
CADDrawingInterface >> aPerspectiveCameraWithBounds: aRect [ 
	^projectionFrame aPerspectiveCameraWithBounds: aRect
]

{ #category : #accessing }
CADDrawingInterface >> aRevoluteJointAt: rDpD [ 
	| depthSortedGOs |
	depthSortedGOs := self graphicsIntersecting: rDpD.
	depthSortedGOs := depthSortedGOs select: [:assoc | assoc key isRevolute].
	^depthSortedGOs isEmpty not 
		ifTrue: [depthSortedGOs first key]
		ifFalse: 
			[self soleSelection 
				ifNotNil: [:a | a cadObject isRevolute ifTrue: [a cadObject] ifFalse: [nil]]]
]

{ #category : #accessing }
CADDrawingInterface >> activeSketch [
	^activeSketch
]

{ #category : #accessing }
CADDrawingInterface >> activeSketch1: sketch [ 
	| wrapper sketchedFeature sketchedFeature2 wrapper2 |
	activeSketch := sketch.
	sketchedFeature := sketch container.
	wrapper := GEONotDoneFeature new.
	wrapper container: sketchedFeature container.
	wrapper become: sketchedFeature.
	sketchedFeature2 := wrapper.
	wrapper2 := sketchedFeature.
	sketchedFeature2 sketch: sketch.
	wrapper2 feature: sketchedFeature2.
	self noSelections.
	sketch part clearSolidModel.
	self createUpdateSelectGOfor: sketch
]

{ #category : #accessing }
CADDrawingInterface >> activeSketch: sketch [ 
	| wrapper sketchedFeature sketchedFeature2 wrapper2 |
	self hasValidActiveSketch 
		ifTrue: 
			[activeSketch == sketch 
				ifFalse: 
					[Dialog 
						warn: 'Complete the part with an active sketch before selecting another sketch.'].
			self createUpdateSelectGOfor: activeSketch]
		ifFalse: 
			[self noSelections.
			activeSketch := sketch.
			sketchedFeature := sketch container.
			wrapper := GEONotDoneFeature new.
			wrapper container: sketchedFeature container.
			wrapper become: sketchedFeature.
			sketchedFeature2 := wrapper.
			wrapper2 := sketchedFeature.
			sketchedFeature2 sketch: sketch.
			wrapper2 feature: sketchedFeature2.
			sketch part clearSolidModel.
			self createUpdateSelectGOfor: sketch]
]

{ #category : #accessing }
CADDrawingInterface >> addAnyPart: geo [ 
	self geoRootItem: geo
]

{ #category : #DYN }
CADDrawingInterface >> animateFrame2: integer [ 
	geoRootItem updateForFrame: integer.
	geoRootItem refFrame quietlyChanged.
	display projectAndAnimateFrame
]

{ #category : #DYN }
CADDrawingInterface >> animateFrame3: integer [ 
	geoRootItem updateForFrame: integer.
	geoRootItem refFrame calcAll.
	display projectAndAnimateFrame
]

{ #category : #DYN }
CADDrawingInterface >> animateFrame: integer [ 
	geoRootItem updateForFrame: integer.
	geoRootItem refFrame quietlyChanged.
	display projectAndAnimateFrame
]

{ #category : #accessing }
CADDrawingInterface >> animationData [
	^geoRootItem animationData
]

{ #category : #accessing }
CADDrawingInterface >> assemblyList [
	| collection |
	collection := SortedCollection sortBlock: [:a :b | a name <= b name].
	geoRootItem == nil ifFalse: [geoRootItem assemblyList: collection].
	^collection
]

{ #category : #accessing }
CADDrawingInterface >> bindGEO: aGEO toCAD: aCAD [ 
	aGEO cadObject: aCAD.
	aGEO
		when: #changed
		ask: aCAD
		perform: #updateFromGEO.
	aGEO
		when: #release
		ask: aCAD
		perform: #release.
	(aGEO canTriggerEvent: #refFrameChanged)
		ifTrue: [aGEO
				when: #refFrameChanged
				ask: aCAD
				perform: #updateFromGEO].
	aCAD metaObject: aGEO
]

{ #category : #control }
CADDrawingInterface >> button1DoubleClick1: rSpPx [ 
	| rDpPx tool |
	rDpPx := self rDpPxfromrSpPx: rSpPx.
	display mousePoint: rDpPx.
	self newMousePoint: rDpPx.
	(tool := self activeTool) == nil ifTrue: [^self defaultButton1DoubleClick: rDpPx].
	^tool button1DoubleClick: rDpPx
]

{ #category : #control }
CADDrawingInterface >> button1DoubleClick: rDpPx [ 
	| tool |
	display mousePoint: rDpPx.
	self newMousePoint: rDpPx.
	(tool := self activeTool) == nil ifTrue: [^self defaultButton1DoubleClick: rDpPx].
	^tool button1DoubleClick: rDpPx
]

{ #category : #control }
CADDrawingInterface >> button1Down1: rSpPx [ 
	| rDpPx tool |
	self halt.
	rDpPx := self rDpPxfromrSpPx: rSpPx.
	display mousePoint: rDpPx.
	self newMousePoint: rDpPx.
	(tool := self activeTool) == nil ifTrue: [^self defaultButton1Down: rDpPx].
	^[tool button1Down: rDpPx]
		on: NearParallelIntersectionError do: [:ex | ex return]
]

{ #category : #control }
CADDrawingInterface >> button1Down: rDpPx [ 
	| tool |
	display mousePoint: rDpPx.
	self newMousePoint: rDpPx.
	(tool := self activeTool) == nil ifTrue: [^self defaultButton1Down: rDpPx].
	^[tool button1Down: rDpPx]
		on: NearParallelIntersectionError do: [:ex | ex return]
]

{ #category : #control }
CADDrawingInterface >> button2Down1: rSpPx [ 
	| rDpPx tool |
	rDpPx := self rDpPxfromrSpPx: rSpPx.
	display mousePoint: rDpPx.
	self newMousePoint: rDpPx.
	(tool := self activeTool) == nil ifTrue: [^self defaultButton2Down: rDpPx].
	^tool button2Down: rDpPx
]

{ #category : #control }
CADDrawingInterface >> button2Down: rDpPx [ 
	| tool |
	display mousePoint: rDpPx.
	self newMousePoint: rDpPx.
	(tool := self activeTool) == nil ifTrue: [^self defaultButton2Down: rDpPx].
	^tool button2Down: rDpPx
]

{ #category : #DYN }
CADDrawingInterface >> cadAnimateSeries: series [ 
	series do: [:i | (geoRootItem canUpdateForFrame: i)
			ifFalse: 
				[self halt.
				^false]].
	^true
]

{ #category : #accessing }
CADDrawingInterface >> cadApp [
	^cadApp
]

{ #category : #accessing }
CADDrawingInterface >> cadApp: aCADApp [ 
	cadApp := aCADApp
]

{ #category : #accessing }
CADDrawingInterface >> cadClassFor: geoClass [ 
	^GEOtoCADdict at: geoClass
]

{ #category : #accessing }
CADDrawingInterface >> cadUnits [
	| answer |
	answer := self triggerEvent: #getCADUnits.
	answer == nil
		ifTrue: 
			[answer := Units new.
			self cadUnits: answer].
	^answer
]

{ #category : #accessing }
CADDrawingInterface >> cadUnits: cadUnits [ 
	self removeActionsForEvent: #getCADUnits.
	cadUnits notNil ifTrue: [self
			when: #getCADUnits
			ask: cadUnits
			perform: #yourself]
]

{ #category : #DYN }
CADDrawingInterface >> canUpdateForFrame: integer [ 
	^geoRootItem canUpdateForFrame: integer
]

{ #category : #accessing }
CADDrawingInterface >> centerPaneAtDrawingPoint: rDpD [ 
	| rDpanecenterD |
	rDpanecenterD := self paneBoundsInDrawingCoordinates center.
	self scrollTopCorner: rDpD - rDpanecenterD.
	self projectWorld
]

{ #category : #accessing }
CADDrawingInterface >> connectorList [
	| collection |
	collection := SortedCollection sortBlock: [:a :b | a name <= b name].
	geoRootItem == nil ifFalse: [geoRootItem connectorList: collection].
	^collection
]

{ #category : #DYN }
CADDrawingInterface >> createAllowZRotation [
	self selectTool: (CADCreationTool
				icon: (GFTool stockIconFor: 'Line')
				cursor: self gfCursorClass crossHair
				class: CADAllowZRotationGO
				name: 'AllowZRotation').
]

{ #category : #DYN }
CADDrawingInterface >> createDynamicForceTorqueGeneral [
	self selectTool: (CADCreationTool
				icon: (GFTool stockIconFor: 'Line')
				cursor: self gfCursorClass crossHair
				class: ForceTorqueGeneralGO
				name: 'GeneralForceTorque').
]

{ #category : #DYN }
CADDrawingInterface >> createDynamicsForceTorqueInLine [
	self selectTool: (CADCreationTool
				icon: (GFTool stockIconFor: 'Line')
				cursor: self gfCursorClass crossHair
				class: ForceTorqueInLineGO
				name: 'InLineForce').
]

{ #category : #GEO }
CADDrawingInterface >> createExtrusion [
	| dummyExtrudedFeature sketchedFeature notDoneFeature |
	(activeSketch notNil and: [activeSketch graphics isEmpty not])
		ifTrue: 
			[dummyExtrudedFeature := GEOExtrudedFeature basicNew.
			(CADExtrudedFeatureDialog openOn: dummyExtrudedFeature)
				ifTrue: 
					[sketchedFeature := activeSketch container.
					notDoneFeature := sketchedFeature container.
					sketchedFeature become: GEOExtrudedFeature basicNew.
					sketchedFeature := notDoneFeature becomeFeature.
					sketchedFeature sketch: activeSketch.
					sketchedFeature zStart: dummyExtrudedFeature zStart.
					sketchedFeature zEnd: dummyExtrudedFeature zEnd.
					sketchedFeature isCut: false.
					sketchedFeature part buildSolidModel.
					self noActiveSketch.
					self soleSelection: sketchedFeature part]]
		ifFalse: [Dialog warn: 'Please select or create an active sketch before extruding.']
]

{ #category : #modeling }
CADDrawingInterface >> createGOfor: geo [ 
	| cadClass |
	cadClass := self cadClassFor: geo class.
	^cadClass createGOfor: geo
]

{ #category : #modeling }
CADDrawingInterface >> createGOsFor: geos [ 
	^geos collect: [:geo | self createGOfor: geo]
]

{ #category : #GEO }
CADDrawingInterface >> createJoint: symbol from: mkri to: mkrj [
]

{ #category : #DYN }
CADDrawingInterface >> createJointAngle [
	self selectTool: (CADCreationTool
				icon: (GFTool stockIconFor: 'Line')
				cursor: self gfCursorClass crossHair
				class: CADAngleJointGO
				name: 'JointAngle').
]

{ #category : #DYN }
CADDrawingInterface >> createJointConstantVelocityZ [
	self selectTool: (CADCreationTool
				icon: (GFTool stockIconFor: 'Line')
				cursor: self gfCursorClass crossHair
				class: CADConstantVelocityJointGO
				name: 'JointConstantVelocityZ').
]

{ #category : #DYN }
CADDrawingInterface >> createJointCurveOnCurve [
	self selectTool: (CADCreationTool
				icon: (GFTool stockIconFor: 'Line')
				cursor: self gfCursorClass crossHair
				class: CADCVCVJointGO
				name: 'JointCurveOnCurve').
]

{ #category : #DYN }
CADDrawingInterface >> createJointCylSph [
	self selectTool: (CADCreationTool
				icon: (GFTool stockIconFor: 'Line')
				cursor: self gfCursorClass crossHair
				class: CADCylSphJointGO
				name: 'JointCylSph').
]

{ #category : #DYN }
CADDrawingInterface >> createJointCylindricalZ [
	self selectTool: (CADCreationTool
				icon: (GFTool stockIconFor: 'Line')
				cursor: self gfCursorClass crossHair
				class: CADCylindricalJointGO
				name: 'JointCylindricalZ').
]

{ #category : #DYN }
CADDrawingInterface >> createJointFixed [
	self selectTool: (CADCreationTool
				icon: (GFTool stockIconFor: 'Line')
				cursor: self gfCursorClass crossHair
				class: CADFixedJointGO
				name: 'JointFixed').
]

{ #category : #DYN }
CADDrawingInterface >> createJointGear [
	self selectTool: (CADCreationTool
				icon: (GFTool stockIconFor: 'Line')
				cursor: self gfCursorClass crossHair
				class: CADGearJointGO
				name: 'JointGear')
]

{ #category : #DYN }
CADDrawingInterface >> createJointLineInPlane [
	self selectTool: (CADCreationTool
				icon: (GFTool stockIconFor: 'Line')
				cursor: self gfCursorClass crossHair
				class: CADLineInPlaneJointGO
				name: 'JointLineInPlane').
]

{ #category : #DYN }
CADDrawingInterface >> createJointLineInPlaneXY [
	self selectTool: (CADCreationTool
				icon: (GFTool stockIconFor: 'Line')
				cursor: self gfCursorClass crossHair
				class: CADLineInPlaneJointGO
				name: 'JointLineInPlaneXY').
]

{ #category : #DYN }
CADDrawingInterface >> createJointNoRotation [
	self selectTool: (CADCreationTool
				icon: (GFTool stockIconFor: 'Line')
				cursor: self gfCursorClass crossHair
				class: CADNoRotationJointGO
				name: 'JointNoRotation').
]

{ #category : #DYN }
CADDrawingInterface >> createJointParallelGear [
	self selectTool: (CADCreationTool
				icon: (GFTool stockIconFor: 'Line')
				cursor: self gfCursorClass crossHair
				class: CADParallelGearJointGO
				name: 'JointParallelGear').
]

{ #category : #DYN }
CADDrawingInterface >> createJointParallelZ [
	self selectTool: (CADCreationTool
				icon: (GFTool stockIconFor: 'Line')
				cursor: self gfCursorClass crossHair
				class: CADParallelAxesJointGO
				name: 'JointParallelZ').
]

{ #category : #DYN }
CADDrawingInterface >> createJointPerpendicularZ [
	self selectTool: (CADCreationTool
				icon: (GFTool stockIconFor: 'Line')
				cursor: self gfCursorClass crossHair
				class: CADPerpendicularJointGO
				name: 'JointPerpendicularZ').
]

{ #category : #DYN }
CADDrawingInterface >> createJointPlanarXY [
	self selectTool: (CADCreationTool
				icon: (GFTool stockIconFor: 'Line')
				cursor: self gfCursorClass crossHair
				class: CADPlanarJointGO
				name: 'JointPlanarXY').
]

{ #category : #DYN }
CADDrawingInterface >> createJointPointInLineZ [
	self selectTool: (CADCreationTool
				icon: (GFTool stockIconFor: 'Line')
				cursor: self gfCursorClass crossHair
				class: CADPointInLineJointGO
				name: 'JointPointInLineZ').
]

{ #category : #DYN }
CADDrawingInterface >> createJointPointInPlaneXY [
	self selectTool: (CADCreationTool
				icon: (GFTool stockIconFor: 'Line')
				cursor: self gfCursorClass crossHair
				class: CADPointInPlaneJointGO
				name: 'JointPointInPlaneXY').
]

{ #category : #DYN }
CADDrawingInterface >> createJointRackXAndPinionZ [
	self selectTool: (CADCreationTool
				icon: (GFTool stockIconFor: 'Line')
				cursor: self gfCursorClass crossHair
				class: CADRackPinJointGO
				name: 'JointRackXAndPinionZ').
]

{ #category : #DYN }
CADDrawingInterface >> createJointRevCyl [
	self selectTool: (CADCreationTool
				icon: (GFTool stockIconFor: 'Line')
				cursor: self gfCursorClass crossHair
				class: CADRevCylJointGO
				name: 'JointRevCyl').
]

{ #category : #DYN }
CADDrawingInterface >> createJointRevoluteZ [
	self selectTool: (CADCreationTool
				icon: (GFTool stockIconFor: 'Line')
				cursor: self gfCursorClass crossHair
				class: CADRevoluteJointGO
				name: 'JointRevoluteZ').
]

{ #category : #DYN }
CADDrawingInterface >> createJointScrewZ [
	self selectTool: (CADCreationTool
				icon: (GFTool stockIconFor: 'Line')
				cursor: self gfCursorClass crossHair
				class: CADScrewJointGO
				name: 'JointScrewZ').
]

{ #category : #DYN }
CADDrawingInterface >> createJointSphSph [
	self selectTool: (CADCreationTool
				icon: (GFTool stockIconFor: 'Line')
				cursor: self gfCursorClass crossHair
				class: CADSphSphJointGO
				name: 'JointSphSph').
]

{ #category : #DYN }
CADDrawingInterface >> createJointSpherical [
	self selectTool: (CADCreationTool
				icon: (GFTool stockIconFor: 'Line')
				cursor: self gfCursorClass crossHair
				class: CADSphericalJointGO
				name: 'JointSpherical').
]

{ #category : #DYN }
CADDrawingInterface >> createJointTranslationalZ [
	self selectTool: (CADCreationTool
				icon: (GFTool stockIconFor: 'Line')
				cursor: self gfCursorClass crossHair
				class: CADTranslationalJointGO
				name: 'JointTranslationalZ').
]

{ #category : #DYN }
CADDrawingInterface >> createJointUniversalZ [
	self selectTool: (CADCreationTool
				icon: (GFTool stockIconFor: 'Line')
				cursor: self gfCursorClass crossHair
				class: CADUniversalJointGO
				name: 'JointUniversalZ').
]

{ #category : #DYN }
CADDrawingInterface >> createKineIJ [
	self selectTool: (CADCreationTool
				icon: (GFTool stockIconFor: 'Line')
				cursor: self gfCursorClass crossHair
				class: CADKineIJGO
				name: 'KineIJ').
]

{ #category : #DYN }
CADDrawingInterface >> createKinematicIJ [
	self selectTool: (CADCreationTool
				icon: (GFTool stockIconFor: 'Line')
				cursor: self gfCursorClass crossHair
				class: CADKineIJGO
				name: 'KinematicIJ').
]

{ #category : #DYN }
CADDrawingInterface >> createMotionGeneral [
	self selectTool: (CADCreationTool
				icon: (GFTool stockIconFor: 'Line')
				cursor: self gfCursorClass crossHair
				class: CADGeneralMotionGO
				name: 'MotionGeneral').
]

{ #category : #DYN }
CADDrawingInterface >> createMotionRotationalZ [
	self selectTool: (CADCreationTool
				icon: (GFTool stockIconFor: 'Line')
				cursor: self gfCursorClass crossHair
				class: CADRotationalMotionGO
				name: 'MotionRotationalZ').
]

{ #category : #DYN }
CADDrawingInterface >> createMotionTranslationalZ [
	self selectTool: (CADCreationTool
				icon: (GFTool stockIconFor: 'Line')
				cursor: self gfCursorClass crossHair
				class: CADTranslationalMotionGO
				name: 'MotionTranslationalZ').
]

{ #category : #modeling }
CADDrawingInterface >> createUpdateSelectGOfor: geo [ 
	| cadClass cadGO |
	cadClass := self cadClassFor: geo class.
	cadGO := cadClass createGOfor: geo.
	cadGO updateProjection: projectionFrame.
	self soleSelection: geo.
	^cadGO
]

{ #category : #accessing }
CADDrawingInterface >> cursorPointSnapped: snap limit: limit [ 
	^self
		snaprDpPx: display rDcursorPx
		if: snap
		limit: limit
]

{ #category : #GEO }
CADDrawingInterface >> cut [
	"Connectors to cut geos are also cut."

	| cutGEOs connectorList markers |
	cutGEOs := selectedGEOs 
				collect: [:geo | geo isFace ifTrue: [geo part] ifFalse: [geo]].
	connectorList := self connectorList.
	markers := self markersIn: cutGEOs.
	connectorList do: 
			[:connector | 
			((cutGEOs includes: connector) not and: [connector isConnectedTo: markers]) 
				ifTrue: [cutGEOs add: connector]].
	cutGEOs := cutGEOs 
				reject: [:geo | (geo isMemberOf: GEOCurveMarker) or: [geo isMemberOf: GEOSketch]].
	self storeMemento: (self cutMementoFor: cutGEOs) for: self.
	self noSelections.	"Clear selections before cutting to avoid problems with handles."
	self cutGEOs: cutGEOs.
	self redraw.
	self triggerEvent: #select	"To update the treeview."
]

{ #category : #accessing }
CADDrawingInterface >> cutAssembly: geo [ 
	self cutPart: geo
]

{ #category : #accessing }
CADDrawingInterface >> cutGEOs: geos [ 
	geos do: [:geo | geo cut]
]

{ #category : #GEO }
CADDrawingInterface >> cutMementoFor: aCollection [ 
	| mem |
	mem := GFMemento originator: self.
	aCollection do: [:each | mem addActionReceiver: each selector: #uncut].
	mem addActionSelector: #uncutGEOs: with: aCollection; addActionSelector: #repairDamage.
	^mem
]

{ #category : #accessing }
CADDrawingInterface >> cutPart: geo [ 
	geoRootItem == nil ifTrue: [^self].
	geoRootItem := nil.
	selectedGEOs emptySelf.
	activeSketch := nil
]

{ #category : #GEO }
CADDrawingInterface >> deleteGEORootItem [
	geoRootItem == nil ifTrue: [^self].
	self noSelections.
	geoRootItem release.
	geoRootItem := nil.
	activeSketch := nil.
	memento := GFBoundedStack bound: 15.
	self triggerEvent: #geoRootItemDeleted
]

{ #category : #calc }
CADDrawingInterface >> drawCircle [
	self hasValidActiveSketch
		ifTrue: [self selectTool: CADCircleGO creationTool.]
		ifFalse: 
			[Dialog
				warn: 'There must be an active sketch to draw on.\Select or create one first.'
						withCRs.].
]

{ #category : #calc }
CADDrawingInterface >> drawEllipse [
	self hasValidActiveSketch
		ifTrue: [self selectTool: CADEllipseGO creationTool.]
		ifFalse: 
			[Dialog
				warn: 'There must be an active sketch to draw on.\Select or create one first.'
						withCRs.].
]

{ #category : #calc }
CADDrawingInterface >> drawLine [
	self selectTool: CADLineGO creationTool.
]

{ #category : #calc }
CADDrawingInterface >> drawPolyline [
	self hasValidActiveSketch
		ifTrue: [self selectTool: CADPolylineGO creationTool.]
		ifFalse: 
			[Dialog
				warn: 'There must be an active sketch to draw on.\Select or create one first.'
						withCRs.].
]

{ #category : #calc }
CADDrawingInterface >> drawRectangle [
	self hasValidActiveSketch
		ifTrue: [self selectTool: CADRectangleGO creationTool.]
		ifFalse: 
			[Dialog
				warn: 'There must be an active sketch to draw on.\Select or create one first.'
						withCRs.].
]

{ #category : #calc }
CADDrawingInterface >> drawingRect [
	^drawing drawingRect
]

{ #category : #GEO }
CADDrawingInterface >> editMarkerSize [
	| axisLength allMarkers cadFrame |
	axisLength := Dialog prompt: 'Enter new axis length'
				defaultExpression: CADFrameGO AxisLength printString.
	axisLength isNil ifTrue: [^self.].
	(axisLength isReal and: [axisLength positive.])
		ifTrue: 
			[CADFrameGO AxisLength: axisLength.
			allMarkers := self markerList , self massMarkerList.
			allMarkers do: 
					[:marker |
					(cadFrame := marker cadObject) notNil
						ifTrue: [cadFrame axisLength: axisLength.].].
			(cadFrame := worldFrame cadObject) notNil
				ifTrue: [cadFrame axisLength: axisLength.].
			self projectWorld.]
		ifFalse: [Dialog warn: 'Axis length must be a positive number.'.].
]

{ #category : #accessing }
CADDrawingInterface >> faceGOat: rDpD [
	| depthSortedGOs |
	depthSortedGOs := self graphicsIntersecting: rDpD.
	depthSortedGOs := depthSortedGOs
				select: [:assoc | assoc key isKindOf: CADFaceGO.].
	^depthSortedGOs isEmpty not
		ifTrue: [depthSortedGOs first key.]
		ifFalse: [nil.].
]

{ #category : #calc }
CADDrawingInterface >> fitAssemblyInPane [
	"
	Find center of 3D space. 
	Shift projection frame to point at 3D center. 
	Shift projection frame origin to screen center. 
	Scale projection to fit 3D world into screen window. 
	Do paneBoundsInDrawingCoordinates first before reseting 
	drawing visibleArea."

	| paneRect fullRect ratio pixelPerMetre |
	paneRect := self paneBoundsInDrawingCoordinates.
	drawing 
		visibleArea: (drawing injectFigures: drawing firstGO displayBox deepCopy
				into: [:rect :each | rect mergeWith: each displayBox]).
	fullRect := drawing displayBox.
	drawing drawingRect: (paneRect extent negated corner: paneRect extent).
	ratio := paneRect extent / fullRect extent.
	ratio := ratio x min: ratio y.
	pixelPerMetre := self pixelPerMetre * (ratio * 0.75d).
	projectionFrame rFfF: self a3DCenter pixelPerMetre: pixelPerMetre.
	self centerPaneAtDrawingPoint: 0 @ 0
]

{ #category : #calc }
CADDrawingInterface >> fitAssemblyInPane1 [
	"
	Find center of 3D space. 
	Shift projection frame to point at 3D center. 
	Shift projection frame origin to screen center. 
	Scale projection to fit 3D world into screen window. 
	"

	| fullRect paneRect ratio pixelPerMetre |
	drawing visibleArea: (drawing injectFigures: drawing firstGO displayBox deepCopy into: [:rect :each | rect mergeWith: each displayBox]).
	fullRect := drawing displayBox.
	paneRect := self paneBoundsInDrawingCoordinates.
	drawing drawingRect: (paneRect extent negated corner: paneRect extent).
	ratio := paneRect extent / fullRect extent.
	ratio := ratio x min: ratio y.
	pixelPerMetre := self pixelPerMetre * (ratio * 0.75d).
	projectionFrame rFfF: self a3DCenter pixelPerMetre: pixelPerMetre.
	self centerPaneAtDrawingPoint: 0 @ 0.
	self repairDamage
]

{ #category : #calc }
CADDrawingInterface >> fitAssemblyInPane2 [
	"
	Find center of 3D space. 
	Shift projection frame to point at 3D center. 
	Shift projection frame origin to screen center. 
	Scale projection to fit 3D world into screen window. 
	Do paneBoundsInDrawingCoordinates first before reseting 
	drawing visibleArea."

	| paneRect fullRect ratio pixelPerMetre |
	paneRect := self paneBoundsInDrawingCoordinates.
	drawing 
		visibleArea: (drawing injectFigures: drawing firstGO displayBox deepCopy
				into: [:rect :each | rect mergeWith: each displayBox]).
	fullRect := drawing displayBox.
	drawing drawingRect: (paneRect extent negated corner: paneRect extent).
	ratio := paneRect extent / fullRect extent.
	ratio := ratio x min: ratio y.
	pixelPerMetre := self pixelPerMetre * (ratio * 0.75d).
	projectionFrame rFfF: self a3DCenter pixelPerMetre: pixelPerMetre.
	self centerPaneAtDrawingPoint: 0 @ 0.
	self repairDamage.
	self projectWorld
]

{ #category : #calc }
CADDrawingInterface >> fixedScaleMenu [


	"Private"
	^Menu new
		addItemLabel: '0%' value: #halt;
		addItemLabel: '25%' value: (MessageSend receiver: self selector: #scale: argument: 25);
		addItemLabel: '50%' value: (MessageSend receiver: self selector: #scale: argument: 50);
		addItemLabel: '75%' value: (MessageSend receiver: self selector: #scale: argument: 75);
		addItemLabel: '100%' value: (MessageSend receiver: self selector: #scale: argument: 100);
		addItemLabel: '125%' value: (MessageSend receiver: self selector: #scale: argument: 125);
		addItemLabel: '150%' value: (MessageSend receiver: self selector: #scale: argument: 150);
		addItemLabel: '200%' value: (MessageSend receiver: self selector: #scale: argument: 200);
		yourself
]

{ #category : #DYN }
CADDrawingInterface >> followPart: aGEOPart [ 
	| simulationData mbdSystem aaSimulationData |
	simulationData := geoRootItem aSimulationData.
	self hideHandles.
	mbdSystem := MbDSystem new.
	self mbdSystem: mbdSystem.
	
	[aaSimulationData := simulationData copy.
	aaSimulationData tend: aaSimulationData tstart.
	geoRootItem aSimulationData: aaSimulationData.
	[mbdSystem perform: #followPart: with: aGEOPart] 
		on: SimulationStoppingError
		do: [:ex | ex return]] 
			ensure: 
				[geoRootItem aSimulationData: simulationData.
				self unhideHandles.
				self mbdSystem: nil]
]

{ #category : #accessing }
CADDrawingInterface >> forceTorqueList [
	| collection |
	collection := SortedCollection sortBlock: [:a :b | a name <= b name].
	geoRootItem == nil ifFalse: [geoRootItem forceTorqueList: collection].
	^collection
]

{ #category : #GEO }
CADDrawingInterface >> fromFileAssemblyRoot1 [

	"Read assembly from a file for the root item."

	| prompt fileName bos geoAssembly originalDir newDir |
	prompt := 'Enter filename to read a Assembly.  Use wildcards (*.asm) to get list of relevant Assembly files.'.
	fileName := cadApp fileName.
	fileName := fileName isNil
		            ifTrue: [ 
		            Dialog requestFileName: prompt default: '*.asm' ]
		            ifFalse: [ 
			            originalDir := Filename currentDirectory directory.
			            newDir := fileName asFilename directory.
			            newDir beCurrentDirectory.
			            [ Dialog requestFileName: prompt default: '*.asm' ] 
				            ensure: [ originalDir beCurrentDirectory ] ].
	fileName isEmpty not ifTrue: [ 
		cadApp fileName: fileName.
		bos := StCAD_Misc_BinaryObjectStorage onOldNoScan:
			       fileName asFilename readStream. "VW_TRANSLATION:StCAD.Misc.BinaryObjectStorage:StCAD_Misc_BinaryObjectStorage"
		[ geoAssembly := bos contents at: 1 ] valueNowOrOnUnwindDo: [ 
			bos close ].
		(geoAssembly notNil and: [ geoAssembly isAssembly ])
			ifTrue: [ 
				self deleteGEORootItem.
				self geoRootItem: geoAssembly.
				self createUpdateSelectGOfor: geoAssembly.
				self repairDamage.
				cadApp isDirty: false ]
			ifFalse: [ Dialog warn: 'Error reading an assembly from file.' ] ]
]

{ #category : #GEO }
CADDrawingInterface >> fromFilePartRoot [

	"Read part from a file for the root item."

	| prompt fileName bos geoPart originalDir newDir |
	prompt := 'Enter filename to read a Part.  Use wildcards (*.prt) to get list of relevant Part files.'.
	fileName := cadApp fileName.
	fileName := fileName isNil
		            ifTrue: [ 
		            Dialog requestFileName: prompt default: '*.prt' ]
		            ifFalse: [ 
			            originalDir := Filename currentDirectory directory.
			            newDir := fileName asFilename directory.
			            newDir beCurrentDirectory.
			            [ Dialog requestFileName: prompt default: '*.prt' ] 
				            ensure: [ originalDir beCurrentDirectory ] ].
	fileName isEmpty not ifTrue: [ 
		cadApp fileName: fileName.
		bos := StCAD_Misc_BinaryObjectStorage onOldNoScan:
			       fileName asFilename readStream. "VW_TRANSLATION:StCAD.Misc.BinaryObjectStorage:StCAD_Misc_BinaryObjectStorage"
		[ geoPart := bos contents at: 1 ] valueNowOrOnUnwindDo: [ bos close ].
		(geoPart notNil and: [ geoPart isPart ])
			ifTrue: [ 
				self deleteGEORootItem.
				self geoRootItem: geoPart.
				self createUpdateSelectGOfor: geoPart.
				cadApp isDirty: false ]
			ifFalse: [ Dialog warn: 'Error reading a part from file.' ] ]
]

{ #category : #calc }
CADDrawingInterface >> fullProjectedRectangle [
	drawing 
		visibleArea: (drawing injectFigures: drawing firstGO displayBox deepCopy
				into: [:rect :each | rect mergeWith: each displayBox]).
	^drawing displayBox scaledBy: 1.0d / projectionFrame pixelPerMetre
]

{ #category : #accessing }
CADDrawingInterface >> fullpath [
	^OrderedCollection with: self
]

{ #category : #accessing }
CADDrawingInterface >> geoRootItem [
	^geoRootItem
]

{ #category : #accessing }
CADDrawingInterface >> geoRootItem: aGEO [ 
	memento := GFBoundedStack bound: 15.
	aGEO container: self.
	geoRootItem := aGEO.
	geoRootItem refFrame refFrame: worldFrame
]

{ #category : #accessing }
CADDrawingInterface >> geoTime [
	^geoRootItem geoTime
]

{ #category : #output }
CADDrawingInterface >> getString: string [ 
	^cadApp textCollector getString: string
]

{ #category : #accessing }
CADDrawingInterface >> graphicObjectAt1: rDpD [ 
	| selectedAsso |
	depthSortedGOsUnderCursor := self graphicsIntersecting: rDpD.
	^depthSortedGOsUnderCursor isEmpty not
		ifTrue: 
			["Give priority to selected GO's."
			selectedAsso := depthSortedGOsUnderCursor detect: [:asso | selections includes: asso key]
						ifNone: nil.
			selectedAsso notNil
				ifTrue: [selectedAsso key]
				ifFalse: [depthSortedGOsUnderCursor first key]]
		ifFalse: [nil]
]

{ #category : #accessing }
CADDrawingInterface >> graphicObjectAt2: rDpD [ 
	depthSortedGOsUnderCursor := self graphicsIntersecting: rDpD.
	^depthSortedGOsUnderCursor isEmpty not
		ifTrue: [depthSortedGOsUnderCursor first key]
		ifFalse: [nil]
]

{ #category : #accessing }
CADDrawingInterface >> graphicObjectAt: rDpD [ 
	| selectedAsso |
	depthSortedGOsUnderCursor := self graphicsIntersecting: rDpD.
	^depthSortedGOsUnderCursor isEmpty not
		ifTrue: 
			["Give priority to selected GO's."
			selectedAsso := depthSortedGOsUnderCursor detect: [:asso | selections includes: asso key]
						ifNone: nil.
			selectedAsso notNil
				ifTrue: [selectedAsso key]
				ifFalse: [depthSortedGOsUnderCursor first key]]
		ifFalse: [nil]
]

{ #category : #accessing }
CADDrawingInterface >> graphicsIntersecting1: rDpD [

	"Sort according to depth (increasing z in ProjectionFrame)."

	| set geoLine dStartIntsec answer |
	set := StCAD_Misc_OrderedSet new. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	drawing graphicsIntersecting: rDpD collectIn: set.
	geoLine := self projectorAt: rDpD.
	set := set collect: [ :aGO | 
		       (aGO respondsTo: #isGFGraphicObject)
			       ifTrue: [ 
				       dStartIntsec := aGO metaObject plane 
					                       distXYPlaneIntersectLine: geoLine.
				       aGO -> dStartIntsec ]
			       ifFalse: [ "Already aGO -> depth." aGO ] ].
	answer := set asSortedCollection: [ :x :y | "Make CADMarkerGO top priority. Otherwise depth sort."
		          (x key isMemberOf: CADMarkerGO)
			          ifTrue: [ 
				          (y key isMemberOf: CADMarkerGO)
					          ifTrue: [ x value <= y value ]
					          ifFalse: [ true ] ]
			          ifFalse: [ 
				          (y key isMemberOf: CADMarkerGO)
					          ifTrue: [ false ]
					          ifFalse: [ x value <= y value ] ] ]. "	Transcript cr; show: answer printString."
	^ answer
]

{ #category : #accessing }
CADDrawingInterface >> graphicsIntersecting: rDpD [

	"Sort according to depth (increasing z in ProjectionFrame)."

	| set geoLine dStartIntsec answer |
	set := StCAD_Misc_OrderedSet new. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	drawing graphicsIntersecting: rDpD collectIn: set.
	geoLine := self projectorAt: rDpD.
	set := set collect: [ :aGO | 
		       (aGO respondsTo: #isGFGraphicObject)
			       ifTrue: [ 
				       dStartIntsec := aGO metaObject plane 
					                       distXYPlaneIntersectLine: geoLine.
				       aGO -> dStartIntsec ]
			       ifFalse: [ "Already aGO -> depth." aGO ] ].
	answer := set asSortedCollection: [ :x :y | 
		          x key dimension ~= y key dimension
			          ifTrue: [ "Dimension sort." 
			          x key dimension <= y key dimension ]
			          ifFalse: [ "Depth sort." x value <= y value ] ].
	^ answer
]

{ #category : #calc }
CADDrawingInterface >> gridMenu [
"Copyright (C) 1993-1995 Polymorphic Software, Inc.  All Rights Reserved"

	| menu |
	menu := (Menu new)
		addItemLabel: 'Use Grid' value: #halt;
		addItemLabel: 'Snap Selections' value: (MessageSend receiver: self selector: #snapSelectionsToGrid);
		addItemLabel: 'Display Grid' value: (MessageSend receiver: self selector: #toggleDisplayGrid);
		addItemLabel: 'Set Grid Size...' value: (MessageSend receiver: self selector: #setGridSize);
		addItemLabel: 'Grid Color...' value: (MessageSend receiver: self selector: #setGridColor).
	(menu someMenuItemLabeled: 'Use Grid') indication: [self drawing usesGrid ].
	(menu someMenuItemLabeled: 'Display Grid') indication: [self drawing displayGrid ].
	^menu
]

{ #category : #accessing }
CADDrawingInterface >> handles [
	^handles
]

{ #category : #testing }
CADDrawingInterface >> hasValidActiveSketch [
	^activeSketch notNil and: [self sketchList includes: activeSketch]
]

{ #category : #'initialize-release' }
CADDrawingInterface >> initialize [
	palette := self class defaultPalette.
	palette setInterface: self.
	selections := OrderedCollection new.
	handles := OrderedCollection new.
	drawing := self class drawingClass new.
	drawing container: self.
	display := CADDoubleBufferingGraphicsDisplaySystem new.
	display interface: self.
	hideHandles := 0.
	memento := GFBoundedStack bound: 15.
	selectedGEOs := GEOSelections new.
	worldFrame := GEOWorldFrame2 new.
	worldFrame refFrame: self.
	worldFrame fixedAtRef.
	projectionFrame := GEOProjectionFrame2 new.
	projectionFrame refFrame: worldFrame.
	projectionFrame fixedAtRef.
	projectionFrame pixelPerMetre: 800 / 10.0d.
	projectionFrame 
		when: #changed
		ask: self
		perform: #projectWorld.
	self projectWorldFrame
]

{ #category : #GEO }
CADDrawingInterface >> insertGravity [
	(geoRootItem notNil and: [geoRootItem isAssembly]) 
		ifTrue: [CADGravityDialog openOn: geoRootItem gravity gXYZ]
		ifFalse: [Dialog warn: 'Motion simulation needs an assembly.']
]

{ #category : #GEO }
CADDrawingInterface >> insertGravity1 [
	| dummyGravity gravity |
	(geoRootItem notNil and: [geoRootItem isAssembly])
		ifTrue: 
			[dummyGravity := geoRootItem defaultGravity.
			gravity := geoRootItem gravity.
			dummyGravity gXYZ: gravity gXYZ copy.
			(CADGravityDialog openOn: dummyGravity gXYZ)
				ifTrue: [geoRootItem gravity: dummyGravity]]
		ifFalse: [Dialog warn: 'Motion simulation needs an assembly.']
]

{ #category : #GEO }
CADDrawingInterface >> insertMarker [
	"Create a marker on a selected plane."

	| plane name geoMarker |
	(selectedGEOs isEmpty not
		and: 
			[plane := selectedGEOs soleSelection.
			plane isPlanar])
		ifTrue: 
			[name := self promptUserForMarkerNameIn: plane anyPart.
			name isEmpty not
				ifTrue: 
					[geoMarker := GEOMarker new.
					geoMarker name: name.
					plane addMarker: geoMarker.
					self createUpdateSelectGOfor: geoMarker.
					plane isFace not ifTrue: [plane release]]]
		ifFalse: [Dialog warn: 'Select a face or a plane. Then insert a new marker.']
]

{ #category : #GEO }
CADDrawingInterface >> insertMarker1 [
	"Create a marker on a selected plane."

	| plane name geoMarker markerGO |
	plane := selectedGEOs soleSelection.
	plane isPlanar
		ifTrue: 
			[name := self promptUserForMarkerNameIn: plane anyPart.
			name isEmpty not
				ifTrue: 
					[geoMarker := GEOMarker new.
					geoMarker name: name.
					plane addMarker: geoMarker.
					markerGO := self createGOfor: geoMarker.
					markerGO updateProjection: projectionFrame.
					self soleSelection: geoMarker]]
		ifFalse: [Dialog warn: 'Marker must be on a plane or face.']
]

{ #category : #GEO }
CADDrawingInterface >> insertMarker2 [
	"Create a marker on a selected plane."

	| plane name geoMarker markerGO |
	plane := selectedGEOs soleSelection.
	plane isPlanar
		ifTrue: 
			[name := self promptUserForMarkerNameIn: plane anyPart.
			name isEmpty not
				ifTrue: 
					[geoMarker := GEOMarker new.
					geoMarker name: name.
					plane addMarker: geoMarker.
					markerGO := self createGOfor: geoMarker.
					markerGO updateProjection: projectionFrame.
					self soleSelection: geoMarker.
					plane isFace not ifTrue: [plane release]]]
		ifFalse: [Dialog warn: 'Marker must be on a plane or face.']
]

{ #category : #GEO }
CADDrawingInterface >> insertMarker3 [
	"Create a marker on a selected plane."

	| plane name geoMarker |
	plane := selectedGEOs soleSelection.
	plane isPlanar
		ifTrue: 
			[name := self promptUserForMarkerNameIn: plane anyPart.
			name isEmpty not
				ifTrue: 
					[geoMarker := GEOMarker new.
					geoMarker name: name.
					plane addMarker: geoMarker.
					self createUpdateSelectGOfor: geoMarker.
					plane isFace not ifTrue: [plane release]]]
		ifFalse: [Dialog warn: 'Marker must be on a plane or face.']
]

{ #category : #GEO }
CADDrawingInterface >> insertPart [
	"Create a part and the initial sketch on a selected plane."

	"OK to use the plane's refFrame since the plane is always discarded."

	| plane assembly name geoPart |
	self hasValidActiveSketch 
		ifTrue: 
			[Dialog 
				warn: 'Complete the part with an active sketch. Then insert a new part.'.
			^self].
	(selectedGEOs isEmpty not and: 
			[plane := selectedGEOs soleSelection.
			plane isPlanar and: [plane container isAssembly]]) 
		ifTrue: 
			[assembly := plane assembly.
			name := self promptUserForPartNameIn: assembly.
			name isEmpty not 
				ifTrue: 
					[geoPart := GEOPart new.
					geoPart name: name.
					assembly addAnyPart: geoPart.
					self createUpdateSelectGOfor: geoPart.	"
					Now select a corresponding plane on the part."
					self selectPlane: plane refFrame aAFf.
					plane release]]
		ifFalse: 
			[Dialog warn: 'Select an assembly. Select a plane. Then insert a new part']
]

{ #category : #GEO }
CADDrawingInterface >> insertPartFile [

	"Create a part and the initial sketch on a selected plane."

	"OK to use the plane's refFrame since the plane is always 
	discarded."

	| plane assembly name titleString filterArray filenameString newName bos geoPart prompt originalDir newDir |
	self hasValidActiveSketch ifTrue: [ 
		Dialog warn:
			'Complete the part with an active sketch. Then insert a new part.'.
		^ self ].
	(selectedGEOs isEmpty not and: [ 
		 plane := selectedGEOs soleSelection.
		 plane isPlanar and: [ plane container isAssembly ] ])
		ifTrue: [ 
			assembly := plane assembly.
			name := self promptUserForPartNameIn: assembly.
			name isEmpty not ifTrue: [ 
				(('win32*' match: OSHandle currentPlatformID) or: [ 
					 'unix*linux*' match: OSHandle currentPlatformID ])
					ifTrue: [ 
						titleString := 'Insert a Part'.
						filterArray := OrderedCollection new.
						filterArray add:
							(CommonFileFilter filter: '*.prt' description: '*.prt  (Part)').
						filterArray add:
							(CommonFileFilter filter: '*.*' description: '*.*  (All)').
						filenameString := nil.
						filenameString := filenameString isNil
							                  ifTrue: [ '' ]
							                  ifFalse: [ filenameString ].
						newName := CommonFileSelectionDialog
							           openTitle: titleString
							           filters: filterArray
							           filename: filenameString
							           mustExist: true ]
					ifFalse: [ 
						prompt := 'Enter filename to read a Part.  Use wildcards (*.prt) to get list of relevant Part files.'.
						newName := cadApp fileName isNil
							           ifTrue: [ 
							           Dialog requestFileName: prompt default: '*.prt' ]
							           ifFalse: [ 
								           originalDir := Filename currentDirectory directory.
								           newDir := cadApp fileName asFilename directory.
								           newDir beCurrentDirectory.
								           [ Dialog requestFileName: prompt default: '*.prt' ] 
									           ensure: [ originalDir beCurrentDirectory ] ] ].
				(newName notNil and: [ newName isEmpty not ]) ifTrue: [ 
					bos := StCAD_Misc_BinaryObjectStorage onOldNoScan:
						       newName asFilename readStream. "VW_TRANSLATION:StCAD.Misc.BinaryObjectStorage:StCAD_Misc_BinaryObjectStorage"
					[ geoPart := bos contents at: 1 ] valueNowOrOnUnwindDo: [ 
						bos close ].
					(geoPart notNil and: [ geoPart isPart ])
						ifTrue: [ 
							geoPart name: name.
							assembly addAnyPart: geoPart.
							geoPart refFrame
								rFfF: plane refFrame rFfF
								aAFf: plane refFrame aAFf.
							self createUpdateSelectGOfor: geoPart.
							plane release ]
						ifFalse: [ Dialog warn: 'Error reading an assembly from file.' ] ] ] ]
		ifFalse: [ 
			Dialog warn:
				'Select an assembly. Select a plane. Then insert a new part' ]
]

{ #category : #GEO }
CADDrawingInterface >> insertSketch [
	"Create a sketch on a selected plane."

	| plane part name newSketch newFeature |
	self hasValidActiveSketch
		ifTrue: 
			[Dialog warn: 'Complete the part with an active sketch before inserting another sketch.'.
			^self].
	(selectedGEOs isEmpty not
		and: 
			[plane := selectedGEOs soleSelection.
			plane isPlanar and: [plane container isPart]])
		ifTrue: 
			[part := plane part.
			name := self promptUserForSketchNameIn: part.
			name isEmpty
				ifFalse: 
					[newSketch := GEOSketch new.
					newSketch refFrame: plane refFrame copy.
					newSketch name: name.
					newFeature := GEOSketchedFeature new.
					newFeature sketch: newSketch.
					part addFeature: newFeature.
					self activeSketch: newSketch.
					plane release]]
		ifFalse: [Dialog warn: 'Select a part. Select a plane. Then insert a new sketch']
]

{ #category : #accessing }
CADDrawingInterface >> interface [
	^self
]

{ #category : #testing }
CADDrawingInterface >> isInterface [
	^true
]

{ #category : #accessing }
CADDrawingInterface >> jointList [
	| collection |
	collection := SortedCollection sortBlock: [:a :b | a name <= b name].
	geoRootItem == nil ifFalse: [geoRootItem jointList: collection].
	^collection
]

{ #category : #accessing }
CADDrawingInterface >> kineIJList [
	| collection |
	collection := SortedCollection sortBlock: [:a :b | a name <= b name].
	geoRootItem == nil ifFalse: [geoRootItem kineIJList: collection].
	^collection
]

{ #category : #output }
CADDrawingInterface >> logContactForce: double [ 
	self logString: #'ADM: \Contact force = %1' withArgument: (double * self mbdUnits force) asFloat printString
]

{ #category : #output }
CADDrawingInterface >> logImpactVelocity: double [ 
	self logString: #'ADM: \Impact velocity = %1' withArgument: (double * self mbdUnits velocity) asFloat printString
]

{ #category : #output }
CADDrawingInterface >> logSeparationDistance: double [ 
	self logString: #'ADM: \Curve-curve separation = %1' withArgument: (double * self mbdUnits length) asFloat printString
]

{ #category : #output }
CADDrawingInterface >> logString: string [ 
	cadApp textCollector logString: string
]

{ #category : #output }
CADDrawingInterface >> logString: string withArgument: string1 [ 
	cadApp textCollector logString: string withArgument: string1
]

{ #category : #output }
CADDrawingInterface >> logString: string withArguments: arrayOfStrings [ 
	cadApp textCollector logString: string withArguments: arrayOfStrings
]

{ #category : #accessing }
CADDrawingInterface >> markerGOat: rDpD [
	| depthSortedGOs |
	depthSortedGOs := self graphicsIntersecting: rDpD.
	depthSortedGOs := depthSortedGOs
				select: [:assoc | assoc key isKindOf: CADMarkerGO.].
	^depthSortedGOs isEmpty not
		ifTrue: [depthSortedGOs first key.]
		ifFalse: [nil.].
]

{ #category : #accessing }
CADDrawingInterface >> markerList [
	| collection |
	collection := SortedCollection sortBlock: [:a :b | a fullName <= b fullName].
	geoRootItem == nil ifFalse: [geoRootItem markerList: collection].
	^collection
]

{ #category : #accessing }
CADDrawingInterface >> markersIn: geos [

	| set |
	set := StCAD_Misc_OrderedSet new. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	geos isSequenceable
		ifTrue: [ geos do: [ :geo | geo addMarkersIn: set ] ]
		ifFalse: [ geos addMarkersIn: set ].
	^ set asOrderedCollection
]

{ #category : #accessing }
CADDrawingInterface >> massMarkerList [
	^(self partList collect: [:part | part massMarker])
		select: [:item | item notNil]
]

{ #category : #accessing }
CADDrawingInterface >> mbdSystem [
	^self triggerEvent: #getMbDSystem
]

{ #category : #accessing }
CADDrawingInterface >> mbdSystem: mbdSystem [ 
	self removeActionsForEvent: #getMbDSystem.
	mbdSystem notNil
		ifTrue: 
			[mbdSystem admSystem: self.
			self
				when: #getMbDSystem
				ask: mbdSystem
				perform: #yourself]
]

{ #category : #accessing }
CADDrawingInterface >> mbdUnits [
	^self triggerEvent: #getMbDUnits
]

{ #category : #accessing }
CADDrawingInterface >> mbdUnits: mbdUnits [ 
	self removeActionsForEvent: #getMbDUnits.
	mbdUnits notNil ifTrue: [self
			when: #getMbDUnits
			ask: mbdUnits
			perform: #yourself]
]

{ #category : #calc }
CADDrawingInterface >> mementoForNewGO: aGO [ 
	"Answer the memento used to remove aGO from the drawing"

	| aMemento |
	aMemento := GFMemento originator: self.
	aMemento addActionSelector: #removeHandlesFor: with: aGO.
	aMemento addActionSelector: #removeGO: with: aGO.
	aMemento addActionReceiver: aGO selector: #release.
	aGO isHostWidgetGO ifTrue: [aMemento addActionReceiver: aGO selector: #removeHostWidget].
	aMemento addActionSelector: #removeGEO: with: aGO metaObject.
	^aMemento
]

{ #category : #calc }
CADDrawingInterface >> menu [
	| menu |
	menu := Menu new.
"	menu addItemLabel: '&Halt' value: (MessageSend receiver: self selector: #halt)."
	menu addItemLabel: '&Undo' value: (MessageSend receiver: self selector: #undo).
	menu addItemLabel: 'Cu&t' value: (MessageSend receiver: self selector: #cut).
	^menu
]

{ #category : #accessing }
CADDrawingInterface >> metrePerPixel [
	^projectionFrame metrePerPixel
]

{ #category : #accessing }
CADDrawingInterface >> motionList [
	| collection |
	collection := SortedCollection sortBlock: [:a :b | a name <= b name].
	geoRootItem == nil ifFalse: [geoRootItem motionList: collection].
	^collection
]

{ #category : #GEO }
CADDrawingInterface >> newAssemblyRoot [
	"Create a new assembly for the root item."

	| name geoAssembly |
	self deleteGEORootItem.
	name := self promptUserForAssemblyName.
	name isEmpty not
		ifTrue: 
			[cadApp fileName: name asString , '.asm'.
			cadApp isDirty: true.
			geoAssembly := GEOAssembly new.
			geoAssembly name: name.
			self geoRootItem: geoAssembly.
			self createUpdateSelectGOfor: geoAssembly.
			self repairDamage]
]

{ #category : #calc }
CADDrawingInterface >> newMousePoint: aPoint [ 
	"aPoint is in projection frame coordinates."

	self triggerEvent: #mousePointChanged with: aPoint
]

{ #category : #GEO }
CADDrawingInterface >> newPartRoot [
	"Create a new part for the root item."

	| name geoPart |
	name := self promptUserForPartName.
	name isEmpty not
		ifTrue: 
			[cadApp fileName: name asString , '.prt'.
			cadApp isDirty: true.
			geoPart := GEOPart new.
			geoPart name: name.
			self deleteGEORootItem.
			self geoRootItem: geoPart.
			self createUpdateSelectGOfor: geoPart]
]

{ #category : #accessing }
CADDrawingInterface >> noActiveSketch [
	activeSketch := nil.
	self triggerEvent: #noActiveSketch
]

{ #category : #GEO }
CADDrawingInterface >> noSelections [
	self hideHandles.
	selections do: [:each | each deselect].
	selections := OrderedCollection new.
	handles := OrderedCollection new.
	hideHandles := 0.
	selectedGEOs emptySelf.
	self triggerEvent: #deselect
]

{ #category : #DYN }
CADDrawingInterface >> outputFor: analysisType [ 
	"Yield process at the end of output so that current process may be aborted safely."

	((analysisType == #DYNAMIC or: [analysisType == #'INITIAL CONDITIONS'])
		or: [analysisType == #STATIC])
		ifTrue: 
			[geoRootItem updateFromMbD.
			geoRootItem refFrame changed.
			self repairDamage]
		ifFalse: [analysisType == #INPUT
				ifTrue: [geoRootItem storeInputFromMbD]
				ifFalse: [analysisType == #DISCONTINUITY ifTrue: [geoRootItem storeDiscontinuityFromMbD]]].
	Processor yield
]

{ #category : #accessing }
CADDrawingInterface >> paneBoundsInDrawingCoordinates [
	^display displayPane bounds
]

{ #category : #accessing }
CADDrawingInterface >> paneBoundsInDrawingCoordinates1 [
	^self paneBoundsInScrollbarCoordinates translatedBy: drawing cornerToOriginOffset negated
]

{ #category : #accessing }
CADDrawingInterface >> paneBoundsInScrollbarCoordinates [
	^display displayPane bounds
]

{ #category : #calc }
CADDrawingInterface >> paneRect [
	^display paneRect
]

{ #category : #accessing }
CADDrawingInterface >> partList [
	| collection |
	collection := SortedCollection sortBlock: [:a :b | a name <= b name].
	geoRootItem == nil ifFalse: [geoRootItem partList: collection].
	^collection
]

{ #category : #DYN }
CADDrawingInterface >> performSimulation: symbol [ 
	| choices values simulationData dummy mbdSystem elapsedSeconds initialState |
	choices := OrderedCollection new.
	values := OrderedCollection new.
	choices add: 'previous input state'.
	values add: [self updateFromInputState].
	choices add: 'initial assembled state'.
	values add: [self updateFromInitiallyAssembledState].
	choices add: 'current state'.
	values add: [].
	initialState := Dialog 
				choose: 'Which input state do you want \to use for the current simulation?' 
						withCRs
				fromList: choices
				values: values
				lines: 4
				cancel: nil.
	initialState notNil 
		ifTrue: 
			[simulationData := geoRootItem aSimulationData.
			dummy := simulationData == nil 
						ifTrue: [GEOSimulationData new]
						ifFalse: [simulationData copy].
			(CADSimulationDialog openOn: dummy) 
				ifTrue: 
					[initialState value.
					geoRootItem storeInputState.
					mbdProcess := 
							[cadApp textCollectorWindowRaise.
							self hideHandles.
							geoRootItem aSimulationData: dummy.
							mbdSystem := MbDSystem new.
							self mbdSystem: mbdSystem.
							self logString: #'ADM \\\Starting Simulation.'.
							elapsedSeconds := Time secondsToRun: 
											[[mbdSystem perform: symbol] on: SimulationStoppingError
												do: [:ex | ex return]].
							self logString: #'ADM \Elapsed time is %1 seconds.'
								withArgument: elapsedSeconds printString.
							self mbdSystem: nil.
							self unhideHandles] 
									forkAt: Processor userBackgroundPriority]]
]

{ #category : #accessing }
CADDrawingInterface >> pixelPerMetre [
	^projectionFrame pixelPerMetre
]

{ #category : #control }
CADDrawingInterface >> popupMenu [
	| aGO |
	self soleSelection ifNil: 
			[self aGraphicViewPopupMenu 
				ifNotNil: [:aMenu | (aMenu startUpForView: self displayPane) evaluateIfNoTarget: self]]
		ifNotNil: 
			[:geoItem | 
			(aGO := geoItem cadObject) ifNotNil: 
					[:cadObject | 
					cadObject aGraphicViewPopupMenu 
						ifNotNil: [:aMenu | (aMenu startUpForView: self displayPane) evaluateIfNoTarget: aGO]]].
	self redraw
]

{ #category : #control }
CADDrawingInterface >> popupMenu1 [
	| pane drawingMenu cadObjectMenu aGO myPerformer |
	pane := self displayPane.
	drawingMenu := drawing menu 
				ifNotNil: [:menu | menu == #noMenu ifTrue: [nil] ifFalse: [menu]].
	cadObjectMenu := self soleSelection ifNotNil: 
					[:geoItem | 
					(aGO := geoItem cadObject) ifNotNil: 
							[:cadObject | 
							cadObject menu 
								ifNotNil: [:menu | menu == #noMenu ifTrue: [nil] ifFalse: [menu]]]].
	drawingMenu ifNotNil: 
			[cadObjectMenu ifNil: 
					[myPerformer := drawing triggerEvent: #getMenuPerformer ifNotHandled: [self].
					(drawingMenu startUpForView: pane) evaluateIfNoTarget: myPerformer]
				ifNotNil: 
					[cadObjectMenu addItemGroup: (Array 
								with: ((MenuItem labeled: self menuLabel) submenu: drawingMenu)).
					(cadObjectMenu startUpForView: pane) evaluateIfNoTarget: aGO].
			self redraw]
]

{ #category : #modeling }
CADDrawingInterface >> postBuildSolidModelFrom: geoPart [ 
	cadApp isDirty: true
]

{ #category : #DYN }
CADDrawingInterface >> postMbDrun [
	geoRootItem deleteMbD
]

{ #category : #modeling }
CADDrawingInterface >> preBuildSolidModelFrom: geoPart [ 
	"Do nothing."
]

{ #category : #DYN }
CADDrawingInterface >> preMbDrun [
	geoRootItem calcCharacteristicDimensions.
	geoRootItem deleteMbD.
	geoRootItem createMbD.
	geoRootItem mbdObject asFixed
]

{ #category : #projection }
CADDrawingInterface >> projectWorld [
	drawing damageAll.
	drawing updateProjection: projectionFrame
]

{ #category : #projection }
CADDrawingInterface >> projectWorldFrame [
	| worldFrameGO |
	worldFrameGO := self createGOfor: worldFrame.
	worldFrameGO updateProjection: projectionFrame
]

{ #category : #projection }
CADDrawingInterface >> projectionAxis [
	^projectionFrame aAOf timesFullColumn: (FullColumn 
				with: 0.0d
				with: 0.0d
				with: 1.0d)
]

{ #category : #accessing }
CADDrawingInterface >> projectionFrame [
	^projectionFrame
]

{ #category : #projection }
CADDrawingInterface >> projectionVertical [
	^projectionFrame aAOf timesFullColumn: (FullColumn 
				with: 0.0d
				with: -1.0d
				with: 0.0d)
]

{ #category : #projection }
CADDrawingInterface >> projectorAt: rDpPx [ 
	| rPpP rPpPz projector |
	rPpP := projectionFrame rPpPfromrDpPx: rDpPx.
	rPpPz := rPpP copy.
	rPpPz at: 3 put: 1.0d.
	projector := GEOLine start: rPpP end: rPpPz.
	projector refFrame: projectionFrame.
	^projector
]

{ #category : #accessing }
CADDrawingInterface >> promptUserForAssemblyName [
	| assemblyList assemblyName |
	assemblyList := self assemblyList.
	assemblyName := 'Assembly<1p>' expandMacrosWith: assemblyList size + 1.
	assemblyName := Dialog request: 'Enter a unique assembly name.' expandMacros initialAnswer: assemblyName.
	[(assemblyList detect: [:assembly | assembly name asSymbol = assemblyName asSymbol]
		ifNone: [nil]) isNil]
		whileFalse: [assemblyName := Dialog
						request: ('''<1s>'' is already taken.<n>Enter a unique assembly name.' expandMacrosWith: assemblyName)
						initialAnswer: assemblyName
						onCancel: ['']].
	^assemblyName
]

{ #category : #accessing }
CADDrawingInterface >> promptUserForForceTorqueNameIn: geoAssembly [ 
	| forceTorqueList forceTorqueName |
	forceTorqueList := geoAssembly forceTorqueList.
	forceTorqueName := 'Force<1p>' expandMacrosWith: forceTorqueList size + 1.
	forceTorqueName := Dialog request: ('In assembly ''<1s>'', enter a unique forceTorque name.' expandMacrosWith: geoAssembly name)
				initialAnswer: forceTorqueName.
	[(forceTorqueList detect: [:forceTorque | forceTorque name asSymbol = forceTorqueName asSymbol]
		ifNone: [nil]) isNil]
		whileFalse: [forceTorqueName := Dialog
						request: ('''<1s>'' is already taken.<n>Enter a unique forceTorque name.' expandMacrosWith: forceTorqueName)
						initialAnswer: forceTorqueName
						onCancel: ['']].
	^forceTorqueName
]

{ #category : #accessing }
CADDrawingInterface >> promptUserForJointNameIn: geoAssembly [ 
	| jointList jointName |
	jointList := geoAssembly jointList.
	jointName := 'Joint<1p>' expandMacrosWith: jointList size + 1.
	jointName := Dialog request: ('In assembly ''<1s>'', enter a unique joint name.' expandMacrosWith: geoAssembly name)
				initialAnswer: jointName.
	[(jointList detect: [:joint | joint name asSymbol = jointName asSymbol]
		ifNone: [nil]) isNil]
		whileFalse: [jointName := Dialog
						request: ('''<1s>'' is already taken.<n>Enter a unique joint name.' expandMacrosWith: jointName)
						initialAnswer: jointName
						onCancel: ['']].
	^jointName
]

{ #category : #accessing }
CADDrawingInterface >> promptUserForKineIJNameIn: geoAssembly [ 
	| kineIJList kineIJName |
	kineIJList := geoAssembly kineIJList.
	kineIJName := 'KineIJ<1p>' expandMacrosWith: kineIJList size + 1.
	kineIJName := Dialog request: ('In assembly ''<1s>'', enter a unique kineIJ name.' expandMacrosWith: geoAssembly name)
				initialAnswer: kineIJName.
	[(kineIJList detect: [:kineIJ | kineIJ name asSymbol = kineIJName asSymbol]
		ifNone: [nil]) isNil]
		whileFalse: [kineIJName := Dialog
						request: ('''<1s>'' is already taken.<n>Enter a unique kineIJ name.' expandMacrosWith: kineIJName)
						initialAnswer: kineIJName
						onCancel: ['']].
	^kineIJName
]

{ #category : #accessing }
CADDrawingInterface >> promptUserForMarkerNameIn: geoPart [ 
	| markers markerName |
	markers := geoPart markers.
	markerName := 'Marker<1p>' expandMacrosWith: markers size + 1.
	markerName := Dialog request: ('In part ''<1s>'', enter a unique marker name.' expandMacrosWith: geoPart name)
				initialAnswer: markerName.
	[(markers detect: [:marker | marker name asSymbol = markerName asSymbol]
		ifNone: [nil]) isNil]
		whileFalse: [markerName := Dialog
						request: ('''<1s>'' is already taken.<n>Enter a unique marker name.' expandMacrosWith: markerName)
						initialAnswer: markerName
						onCancel: ['']].
	^markerName
]

{ #category : #accessing }
CADDrawingInterface >> promptUserForMotionNameIn: geoAssembly [ 
	| motionList motionName |
	motionList := geoAssembly motionList.
	motionName := 'Motion<1p>' expandMacrosWith: motionList size + 1.
	motionName := Dialog request: ('In assembly ''<1s>'', enter a unique motion name.' expandMacrosWith: geoAssembly name)
				initialAnswer: motionName.
	[(motionList detect: [:motion | motion name asSymbol = motionName asSymbol]
		ifNone: [nil]) isNil]
		whileFalse: [motionName := Dialog
						request: ('''<1s>'' is already taken.<n>Enter a unique motion name.' expandMacrosWith: motionName)
						initialAnswer: motionName
						onCancel: ['']].
	^motionName
]

{ #category : #accessing }
CADDrawingInterface >> promptUserForPartName [
	| partList partName |
	partList := self partList.
	partName := 'Part' , (partList size + 1) asString.
	partName := Dialog request: 'Enter a unique part name.' initialAnswer: partName.
	[(partList detect: [:part | part name asSymbol = partName asSymbol]
		ifNone: [nil]) isNil]
		whileFalse: [partName := Dialog
						request: partName asString , ' is already taken.\Enter a unique part name.' withCRs
						initialAnswer: partName
						onCancel: ['']].
	^partName
]

{ #category : #accessing }
CADDrawingInterface >> promptUserForPartNameIn: geoAssembly [ 
	| partList partName |
	partList := geoAssembly partList.
	partName := 'Part<1p>' expandMacrosWith: partList size + 1.
	partName := Dialog 
				request: ('In assembly ''<1s>'', enter a unique part name.' 
						expandMacrosWith: geoAssembly name)
				initialAnswer: partName.
	
	[(partList detect: 
			[:part | 
			part name ifNil: [false] ifNotNil: [:a | a asSymbol = partName asSymbol]]
		ifNone: [nil]) isNil] 
			whileFalse: 
				[partName := Dialog 
							request: ('''<1s>'' is already taken.<n>Enter a unique part name.' 
									expandMacrosWith: partName)
							initialAnswer: partName
							onCancel: ['']].
	^partName
]

{ #category : #accessing }
CADDrawingInterface >> promptUserForRobotAxisNameIn: geoAssembly [ 
	| cRobotAxis aRobotAxisName |
	cRobotAxis := geoAssembly cRobotAxis.
	aRobotAxisName := 'RobotAxis<1p>' expandMacrosWith: cRobotAxis size + 1.
	aRobotAxisName := Dialog 
				request: ('In assembly ''<1s>'', enter a unique RobotAxis name.' 
						expandMacrosWith: geoAssembly name)
				initialAnswer: aRobotAxisName.
	
	[(cRobotAxis 
		detect: [:aRobotAxis | aRobotAxis name asSymbol = aRobotAxisName asSymbol]
		ifNone: [nil]) isNil] 
			whileFalse: 
				[aRobotAxisName := Dialog 
							request: ('''<1s>'' is already taken.<n>Enter a unique RobotAxis name.' 
									expandMacrosWith: aRobotAxisName)
							initialAnswer: aRobotAxisName
							onCancel: ['']].
	^aRobotAxisName
]

{ #category : #accessing }
CADDrawingInterface >> promptUserForSketchNameIn: geoPart [ 
	| sketchList sketchName |
	sketchList := geoPart sketchList.
	^sketchList size < 1
		ifTrue: 
			[sketchName := 'Sketch<1p>' expandMacrosWith: sketchList size + 1.
			sketchName := Dialog request: ('In part ''<1s>'', enter a unique sketch name.' expandMacrosWith: geoPart name)
						initialAnswer: sketchName.
			[(sketchList detect: [:sketch | sketch name asSymbol = sketchName asSymbol]
				ifNone: [nil]) isNil]
				whileFalse: [sketchName := Dialog
								request: ('''<1s>'' is already taken.<n>Enter a unique sketch name.' expandMacrosWith: sketchName)
								initialAnswer: sketchName
								onCancel: ['']].
			sketchName]
		ifFalse: 
			[Dialog warn: 'Currently, there is a limit of only one sketch per part.<n>This limit will be lifted in the future.' expandMacros.
			'']
]

{ #category : #accessing }
CADDrawingInterface >> rDpPxfromrSpPx: rSpPx [ 
	^rSpPx - drawing rSDPx
]

{ #category : #accessing }
CADDrawingInterface >> rTopLeftOfDrawingToDrawingOriginInPixels [
	^drawing rTopLeftOfDrawingToDrawingOriginInPixels
]

{ #category : #rendering }
CADDrawingInterface >> removeDisplayList [
	geoRootItem ifNotNil: [:aAssembly | aAssembly removeDisplayList]
]

{ #category : #GEO }
CADDrawingInterface >> removeGEO: aGEO [ 
	geoRootItem removeGEO: aGEO
]

{ #category : #rendering }
CADDrawingInterface >> renderOn: aRenderingContext [ 
	worldFrame renderOn: aRenderingContext.
	geoRootItem notNil ifTrue: [geoRootItem renderOn: aRenderingContext]
]

{ #category : #calc }
CADDrawingInterface >> rotateWorldHandle [
	"
	Show rotate handle at 100@0 from screen center. 
	Draw line from center to right as reference. 
	Track mouse, use angle from center to cursor and reference for rotation. 
	_ Rotate projection frame about 3D center in the reverse direction. 
	Use memento for possible undo. 
	block := 
	[:deg | 
	| radius theta tip lineGO string text | 
	radius := 200. 
	theta := deg negated asDouble degreesToRadians. 
	tip := (Point r: radius theta: theta) rounded. 
	lineGO := CADLineGO start: 0 @ 0 stop: tip. 
	lines addLast: lineGO. 
	string := deg asString , 'deg'. 
	text := GFTextGO text: string. 
	text translateBy: tip. 
	text disableInteraction. 
	lines addLast: text]. 
	"
	| rotateHandle lines block compositeGO |
	rotateHandle := CADTrackHandle on: projectionFrame at: #rDPPx.
	rotateHandle hotSpot: [:handle | handle origin + (100 @ 0).].
	rotateHandle setSense: nil
		change: 
			[:projFrame :frozenProjFrame :rDoriginPx :rDfirstPx :rDoldPx :rDnewPx |
			| radialVector zP thetaO axiszPO newFrame |
			radialVector := 100 @ 0 + rDnewPx - rDfirstPx.
			radialVector isZero
				ifFalse: 
					[zP := FullColumn with: 0.0d with: 0.0d with: 1.0d.
					thetaO := radialVector theta asDouble.
					axiszPO := frozenProjFrame aAOP timesFullColumn: zP.
					newFrame := frozenProjFrame copy.
					newFrame
						rotateAt: frozenProjFrame rOfO
						axisF: axiszPO negated
						theta: thetaO.
					projFrame copyrFfFandAFfFrom: newFrame.].].
	rotateHandle mementoType: #positionMemento.
	rotateHandle description: 'rotate world'.
	lines := OrderedCollection new.
	block :=
			[:deg |
			| radius theta tip lineGO |
			radius := 100.
			theta := deg negated asDouble degreesToRadians.
			tip := (Point r: radius theta: theta) rounded.
			lineGO := CADLineGO start: 0 @ 0 stop: tip.
			lines addLast: lineGO.].
	block value: 0.
	compositeGO := GFCompositeGO graphicObjects: lines.
	compositeGO hideVisibleAreaIndicator.
	compositeGO disableInteraction.
	rotateHandle displayImage: compositeGO.
	^rotateHandle.
]

{ #category : #calc }
CADDrawingInterface >> scrollTopCorner: delta [ 
	display scrollTopCorner: delta
]

{ #category : #GEO }
CADDrawingInterface >> selectActiveSketch: sketch [ 
	self hasValidActiveSketch
		ifTrue: 
			[Dialog warn: 'Complete the part with an active sketch before selecting another sketch.'.
			^self].
	(Dialog
		choose: 'Selecting the sketch will delete its associated feature <n>and make it active for editing.' expandMacros
		labels: (Array with: 'continue' with: 'stop')
		values: #(true false)
		default: true)
		ifTrue: [self activeSketch: sketch]
]

{ #category : #calc }
CADDrawingInterface >> selectPlane: aA [ 
	| anyPart geoPlane |
	(selectedGEOs isEmpty not
		and: 
			[anyPart := selectedGEOs soleSelection.
			anyPart isPart or: [anyPart isAssembly]])
		ifTrue: 
			[geoPlane := GEOPlane new.
			geoPlane container: anyPart.
			geoPlane refFrame
				refFrame: anyPart refFrame
				rFfF: (FullColumn zero: 3)
				aAFf: aA.
			self createUpdateSelectGOfor: geoPlane]
		ifFalse: [Dialog warn: 'Select a part or assembly. Then select a plane.']
]

{ #category : #calc }
CADDrawingInterface >> selectXrightYupPlane [
	self selectPlane: (FullMatrix newWithElements: #(#(1.0d 0.0d 0.0d) #(0.0d 1.0d 0.0d) #(0.0d 0.0d 1.0d)))
]

{ #category : #calc }
CADDrawingInterface >> selectXrightZdownPlane [
	self selectPlane: (FullMatrix newWithElements: #(#(1.0d 0.0d 0.0d) #(0.0d 0.0d 1.0d) #(0.0d -1.0d 0.0d)))
]

{ #category : #calc }
CADDrawingInterface >> selectYupZleftPlane [
	self selectPlane: (FullMatrix newWithElements: #(#(0.0d 0.0d 1.0d) #(0.0d 1.0d 0.0d) #(-1.0d 0.0d 0.0d)))
]

{ #category : #accessing }
CADDrawingInterface >> selectedGEOs [
	^selectedGEOs
]

{ #category : #GEO }
CADDrawingInterface >> selections: aCollection [ 
	self noSelections.
	self addHandlesForAll: aCollection.
	self showHandles.
	aCollection do: [:aGO | selectedGEOs add: aGO metaObject].
	self triggerEvent: #select
]

{ #category : #calc }
CADDrawingInterface >> showHandle: aHandle [ 
	"Show a specific handle regardless of the hideHandles count"

	display displayHandles: (Array with: aHandle)
]

{ #category : #accessing }
CADDrawingInterface >> sketchList [
	| collection |
	collection := SortedCollection sortBlock: [:a :b | a name <= b name].
	geoRootItem == nil ifFalse: [geoRootItem sketchList: collection].
	^collection
]

{ #category : #accessing }
CADDrawingInterface >> snapMousePoint: rSpPx if: snap limit1: limit [ 
	| rDpPx |
	rDpPx := self rDpPxfromrSpPx: rSpPx.
	rDpPx := drawing
				snapToGrid: rDpPx
				if: snap
				limit: limit.
	display mousePoint: rDpPx.
	self newMousePoint: rDpPx.
	^rDpPx
]

{ #category : #accessing }
CADDrawingInterface >> snapMousePoint: rSpPx if: snap limit: limit [ 
	| rDpPx |
	rDpPx := self rDpPxfromrSpPx: rSpPx.
	rDpPx := drawing
				snapToGrid: rDpPx
				if: snap
				limit: limit.
	display mousePoint: rDpPx.
	self newMousePoint: rDpPx.
	^rDpPx
]

{ #category : #accessing }
CADDrawingInterface >> snaprDpPx: rDpPx if: snap limit: limit [ 
	| rDpPxnew |
	rDpPxnew := drawing
				snapToGrid: rDpPx
				if: snap
				limit: limit.
	display mousePoint: rDpPxnew.
	self newMousePoint: rDpPxnew.
	^rDpPxnew
]

{ #category : #accessing }
CADDrawingInterface >> snaprSpPx: rSpPx if: snap limit: limit [ 
	| rDpPx |
	rDpPx := self rDpPxfromrSpPx: rSpPx.
	^self
		snaprDpPx: rDpPx
		if: snap
		limit: limit
]

{ #category : #accessing }
CADDrawingInterface >> soleSelection [
	^selectedGEOs soleSelection
]

{ #category : #accessing }
CADDrawingInterface >> soleSelection: aGEO [ 
	| cadGO |
	cadGO := aGEO cadObject.
	cadGO notNil ifTrue: [self setDefaultTool; selection: cadGO].
	selectedGEOs soleSelection: aGEO
]

{ #category : #DYN }
CADDrawingInterface >> startDynamic [
	self performSimulation: #runDYNAMIC
]

{ #category : #DYN }
CADDrawingInterface >> startKinematic [
	self performSimulation: #runKINEMATIC
]

{ #category : #DYN }
CADDrawingInterface >> startQuasiStatic [
	"
	Convergence is fragile for quasistatic analysis.
	When there is no convergence, the aA matrices are no longer valid rotation matrices. So all geometry is no longer correct. Condition the aA matrices to avoid the problem.
	"

	self performSimulation: #runSTATICS.
	(geoRootItem refFrame)
		conditionA;
		changed.
	self repairDamage
]

{ #category : #DYN }
CADDrawingInterface >> startQuasiStatic1 [
	| simulationData dummy mbdSystem elapsedSeconds |
	simulationData := geoRootItem aSimulationData.
	dummy := simulationData == nil
				ifTrue: [GEOSimulationData new]
				ifFalse: [simulationData copy].
	(CADSimulationDialog openOn: dummy)
		ifTrue: [mbdProcess := 
					[cadApp textCollectorWindowRaise.
					self hideHandles.
					geoRootItem aSimulationData: dummy.
					mbdSystem := MbDSystem new.
					self mbdSystem: mbdSystem.
					elapsedSeconds := (Time millisecondsToRun: [mbdSystem runSTATICS])
								// 1000.
					self logString: #'ADM \Elapsed time is %1 seconds.' withArgument: elapsedSeconds printString.
					self unhideHandles]
						forkAt: Processor userBackgroundPriority]
]

{ #category : #DYN }
CADDrawingInterface >> startQuasiStatic2 [
	self performSimulation: #runSTATICS
]

{ #category : #DYN }
CADDrawingInterface >> startTransient [
	self performSimulation: #runTRANSIENT
]

{ #category : #DYN }
CADDrawingInterface >> startTransient1 [
	| simulationData dummy mbdSystem elapsedSeconds |
	simulationData := geoRootItem aSimulationData.
	dummy := simulationData == nil
				ifTrue: [GEOSimulationData new]
				ifFalse: [simulationData copy].
	(CADSimulationDialog openOn: dummy)
		ifTrue: [mbdProcess := 
					[cadApp textCollectorWindowRaise.
					self hideHandles.
					geoRootItem aSimulationData: dummy.
					mbdSystem := MbDSystem new.
					self mbdSystem: mbdSystem.
					elapsedSeconds := (Time millisecondsToRun: [mbdSystem runTRANSIENT])
								// 1000.
					self logString: #'ADM \Elapsed time is %1 seconds.' withArgument: elapsedSeconds printString.
					self unhideHandles]
						forkAt: Processor userBackgroundPriority]
]

{ #category : #DYN }
CADDrawingInterface >> stopSimulation [
	"The garbage can cursor persists when this command is executed during garbage collection."
	"'Cursor normal show' forces a normal cursor."
	""

	| sem |
	mbdProcess == nil
		ifFalse: 
			[sem := Semaphore new.
			
			[mbdProcess terminate.
			mbdProcess := nil.
			sem signal]
				forkAt: mbdProcess priority.
			sem wait.
			Cursor normal show.
			self unhideHandles]
]

{ #category : #calc }
CADDrawingInterface >> tiltRotateWorld [
	"
	Find center of 3D space. 
	Shift projection frame to point at 3D center. 
	Shift projection frame origin to screen center. 
	Scale projection to fit 3D world into screen window. 
	Do paneBoundsInDrawingCoordinates first before reseting 
	drawing visibleArea."

	| paneRect fullRect ratio pixelPerMetre tiltHandle rotateHandle |
	paneRect := self paneBoundsInDrawingCoordinates.
	drawing 
		visibleArea: (drawing injectFigures: drawing firstGO displayBox deepCopy
				into: [:rect :each | rect mergeWith: each displayBox]).
	fullRect := drawing displayBox.
	drawing drawingRect: (paneRect extent negated corner: paneRect extent).
	ratio := paneRect extent / fullRect extent.
	ratio := ratio x min: ratio y.
	pixelPerMetre := self pixelPerMetre * (ratio * 0.75d).
	projectionFrame rFfF: self a3DCenter pixelPerMetre: pixelPerMetre.
	self centerPaneAtDrawingPoint: 0 @ 0.
	self noSelections.
	tiltHandle := self tiltWorldHandle.
	self addHandle: tiltHandle.
	rotateHandle := self rotateWorldHandle.
	self addHandle: rotateHandle
]

{ #category : #calc }
CADDrawingInterface >> tiltRotateWorld1 [
	"
	Find center of 3D space. 
	Shift projection frame to point at 3D center. 
	Shift projection frame origin to screen center. 
	Scale projection to fit 3D world into screen window. 
	"

	| tiltHandle rotateHandle fullRect paneRect ratio pixelPerMetre | self halt.
	drawing visibleArea: (drawing injectFigures: drawing firstGO displayBox deepCopy into: [:rect :each | rect mergeWith: each displayBox]).
	fullRect := drawing displayBox.
	paneRect := self paneBoundsInDrawingCoordinates.
	drawing drawingRect: (paneRect extent negated corner: paneRect extent).
	ratio := paneRect extent / fullRect extent.
	ratio := ratio x min: ratio y.
	pixelPerMetre := self pixelPerMetre * (ratio * 0.75d).
	projectionFrame rFfF: self a3DCenter pixelPerMetre: pixelPerMetre.
	self centerPaneAtDrawingPoint: 0 @ 0.
	self noSelections.
	tiltHandle := self tiltWorldHandle.
	self addHandle: tiltHandle.
	rotateHandle := self rotateWorldHandle.
	self addHandle: rotateHandle
]

{ #category : #calc }
CADDrawingInterface >> tiltRotateWorld2 [
	"
	Find center of 3D space. 
	Shift projection frame to point at 3D center. 
	Shift projection frame origin to screen center. 
	Scale projection to fit 3D world into screen window. 
	Do paneBoundsInDrawingCoordinates first before reseting 
	drawing visibleArea."

	| paneRect fullRect ratio pixelPerMetre tiltHandle rotateHandle |
	paneRect := self paneBoundsInDrawingCoordinates.
	drawing visibleArea: (drawing injectFigures: drawing firstGO displayBox deepCopy into: [:rect :each | rect mergeWith: each displayBox]).
	fullRect := drawing displayBox.
	drawing drawingRect: (paneRect extent negated corner: paneRect extent).
	ratio := paneRect extent / fullRect extent.
	ratio := ratio x min: ratio y.
	pixelPerMetre := self pixelPerMetre * (ratio * 0.75d).
	projectionFrame rFfF: self a3DCenter pixelPerMetre: pixelPerMetre.
	self centerPaneAtDrawingPoint: 0 @ 0.
	self noSelections.
	tiltHandle := self tiltWorldHandle.
	self addHandle: tiltHandle.
	rotateHandle := self rotateWorldHandle.
	self addHandle: rotateHandle
]

{ #category : #calc }
CADDrawingInterface >> tiltRotateWorld3 [
	"
	Find center of 3D space. 
	Shift projection frame to point at 3D center. 
	Shift projection frame origin to screen center. 
	Scale projection to fit 3D world into screen window. 
	Do paneBoundsInDrawingCoordinates first before reseting 
	drawing visibleArea."

	| paneRect fullRect ratio pixelPerMetre tiltHandle rotateHandle |
	paneRect := self paneBoundsInDrawingCoordinates.
	drawing 
		visibleArea: (drawing injectFigures: drawing firstGO displayBox deepCopy
				into: [:rect :each | rect mergeWith: each displayBox]).
	fullRect := drawing displayBox.
	drawing drawingRect: (paneRect extent negated corner: paneRect extent).
	ratio := paneRect extent / fullRect extent.
	ratio := ratio x min: ratio y.
	pixelPerMetre := self pixelPerMetre * (ratio * 0.75d).
	projectionFrame rFfF: self a3DCenter pixelPerMetre: pixelPerMetre.
	self centerPaneAtDrawingPoint: 0 @ 0.
	self projectWorld.
	self noSelections.
	tiltHandle := self tiltWorldHandle.
	self addHandle: tiltHandle.
	rotateHandle := self rotateWorldHandle.
	self addHandle: rotateHandle
]

{ #category : #calc }
CADDrawingInterface >> tiltWorldHandle [
	"
	Show tilt handle at screen center. 
	Draw circles for 90deg and 180deg tilt away from screen normal. 
	Track mouse, use vector from center to cursor for tilt direction 
	and magnitude. 
	_ Tilt projection frame about 3D center in the reverse direction. 
	"

	| tiltHandle pixelPerDegree |
	tiltHandle := CADTrackHandle on: projectionFrame at: #rDPPx.
	tiltHandle hotSpot: [:handle | handle origin].
	pixelPerDegree := 1.
	tiltHandle setSense: nil
		change: 
			[:projFrame :frozenProjFrame :rDoriginPx :rDfirstPx :rDoldPx :rDnewPx | 
			| radialVector tiltVector axisO thetaO newFrame |
			radialVector := rDnewPx - rDfirstPx.
			radialVector isZero
				ifFalse: 
					[tiltVector := radialVector y negated @ radialVector x.
					axisO := frozenProjFrame aAOP timesFullColumn: (frozenProjFrame rPpPfromrDpPx: tiltVector).
					thetaO := (radialVector r / pixelPerDegree) degreesToRadians.
					newFrame := frozenProjFrame copy.
					newFrame
						rotateAt: frozenProjFrame rOfO
						axisF: axisO
						theta: thetaO.
					projFrame copyrFfFandAFfFrom: newFrame]].
	tiltHandle mementoType: #positionMemento.
	tiltHandle description: 'tilt world'.	"	circles := OrderedCollection new. 
	block := 
	[:deg | 
	| radius rect ellipse string text | 
	radius := (deg * pixelPerDegree) rounded. 
	rect := radius negated @ radius negated corner: radius @ radius. 
	ellipse := GFEllipseGO ellipse: rect. 
	ellipse fillColor: nil. 
	ellipse disableInteraction. 
	circles addLast: ellipse. 
	string := deg asString , 'deg'. 
	text := GFTextGO text: string. 
	text translateBy: 0 @ radius. 
	text disableInteraction. 
	circles addLast: text]. 
	block value: 90. 
	block value: 180. 
	compositeGO := GFCompositeGO graphicObjects: circles. 
	compositeGO hideVisibleAreaIndicator. 
	compositeGO disableInteraction. 
	tiltHandle displayImage: compositeGO. 
	"
	^tiltHandle
]

{ #category : #accessing }
CADDrawingInterface >> timeSeries [
	^geoRootItem timeSeries
]

{ #category : #accessing }
CADDrawingInterface >> treeView [
	^cadApp widgetAt: #treeViewID
]

{ #category : #accessing }
CADDrawingInterface >> unbindGEO: aGEO fromCAD: aCAD [ 
	self quietlyRemoveHandlesFor: aCAD.
	aCAD damaged.
	aGEO removeAllActionsWithReceiver: aCAD.
	aCAD removeAllActionsWithReceiver: aGEO
]

{ #category : #accessing }
CADDrawingInterface >> uncutGEOs: geos [ 
	geos do: [:geo | self createUpdateSelectGOfor: geo]
]

{ #category : #accessing }
CADDrawingInterface >> undo [
	"Undo the last action"

	| mem |
	(memento == nil or: [memento isEmpty]) 
		ifTrue: 
			[Dialog warn: 'No more Undo'.
			^self].
	mem := memento pop.
	self hideHandlesWhile: [(mem at: 1) restoreFrom: (mem at: 2)].
	self redraw
]

{ #category : #DYN }
CADDrawingInterface >> updateForFrame1: integer [ 
	geoRootItem updateForFrame: integer.
	geoRootItem refFrame changed.
	self repairDamage
]

{ #category : #DYN }
CADDrawingInterface >> updateForFrame: integer [ 
	geoRootItem updateForFrame: integer.
	geoRootItem refFrame calcAll.
	drawing damageAll.
	drawing quietlyUpdateProjection: projectionFrame.
	self repairDamage
]

{ #category : #DYN }
CADDrawingInterface >> updateFromInitiallyAssembledState [
	geoRootItem updateFromInitiallyAssembledState.
	geoRootItem refFrame changed.
	self repairDamage
]

{ #category : #DYN }
CADDrawingInterface >> updateFromInputState [
	geoRootItem updateFromInputState.
	geoRootItem refFrame changed.
	self repairDamage
]

{ #category : #'initialize-release' }
CADDrawingInterface >> updateRequest [
	^mbdProcess isNil
		ifTrue: [true]
		ifFalse: [mbdProcess suspendedContext isNil
				ifTrue: [true]
				ifFalse: 
					[Dialog warn: 'Stop simulation before closing.' for: cadApp builder window.
					false]]
]

{ #category : #DYN }
CADDrawingInterface >> useCollisionTrialStepStats: stats [ 
	| mbdUnits impulse array |
	mbdUnits := self mbdUnits.
	impulse := mbdUnits force * mbdUnits time.
	array := Array new: 6.
	array at: 1 put: (stats at: #istep) printString.
	array at: 2 put: ((stats at: #t)
			* impulse) asFloat printString.
	array at: 3 put: (stats at: #order) printString.
	array at: 4 put: ((stats at: #h)
			* impulse) asFloat printString.
	array at: 5 put: (stats at: #corIterNo) printString.
	array at: 6 put: (stats at: #truncError) asFloat printString.
	self logString: #'ADM: \%1 , imp=%2 , o=%3 , dimp=%4 , it=%5 , e=%6' withArguments: array
]

{ #category : #DYN }
CADDrawingInterface >> useDynTrialStepStats: stats [ 
	| mbdUnits time array |
	mbdUnits := self mbdUnits.
	time := mbdUnits time.
	array := Array new: 6.
	array at: 1 put: (stats at: #istep) printString.
	array at: 2 put: ((stats at: #t) * time) asFloat printString.
	array at: 3 put: (stats at: #order) printString.
	array at: 4 put: ((stats at: #h) * time) asFloat printString.
	array at: 5 put: (stats at: #corIterNo) printString.
	array at: 6
		put: ((stats at: #truncError) ifNotNil: [:a | a asFloat]) printString.
	self logString: #'ADM: \%1 , t=%2 , o=%3 , h=%4 , it=%5 , e=%6'
		withArguments: array
]

{ #category : #DYN }
CADDrawingInterface >> useKineTrialStepStats: stats [ 
	self useDynTrialStepStats: stats
]

{ #category : #calc }
CADDrawingInterface >> viewWorldFrom: aA [ 
	"
	Find center of 3D space. 
	Shift projection frame to point at 3D center. 
	Shift projection frame origin to screen center. 
	Scale projection to fit 3D world into screen window. 
	"

	self storeMemento: projectionFrame positionMemento for: projectionFrame.
	projectionFrame rFfF: self a3DCenter aAFf: aA.
	self projectWorld
]

{ #category : #calc }
CADDrawingInterface >> viewXrightYleftZup [
	| aA |
	aA := FullMatrix
				rotationMatrixFromOrigin: (FullColumn zero: 3)
				zPoint: (FullColumn
						with: 1.0d
						with: 1.0d
						with: -1.0d)
				xPoint: (FullColumn
						with: 1.0d
						with: -1.0d
						with: 0.0d).
	self viewWorldFrom: aA
]

{ #category : #calc }
CADDrawingInterface >> viewXrightYup [
	self viewWorldFrom: (FullMatrix newWithElements: #(#(1.0d 0.0d 0.0d) #(0.0d -1.0d 0.0d) #(0.0d 0.0d -1.0d)))
]

{ #category : #calc }
CADDrawingInterface >> viewXrightZdown [
	self viewWorldFrom: (FullMatrix newWithElements: #(#(1.0d 0.0d 0.0d) #(0.0d 0.0d -1.0d) #(0.0d 1.0d 0.0d)))
]

{ #category : #calc }
CADDrawingInterface >> viewYupQuadmpm [
	| aA |
	aA := FullMatrix
				rotationMatrixFromOrigin: (FullColumn zero: 3)
				zPoint: (FullColumn
						with: 1.0d
						with: -1.0d
						with: 1.0d)
				xPoint: (FullColumn
						with: -1.0d
						with: 0.0d
						with: 1.0d).
	self viewWorldFrom: aA
]

{ #category : #calc }
CADDrawingInterface >> viewYupQuadmpp [
	| aA |
	aA := FullMatrix
				rotationMatrixFromOrigin: (FullColumn zero: 3)
				zPoint: (FullColumn
						with: 1.0d
						with: -1.0d
						with: -1.0d)
				xPoint: (FullColumn
						with: 1.0d
						with: 0.0d
						with: 1.0d).
	self viewWorldFrom: aA
]

{ #category : #calc }
CADDrawingInterface >> viewYupQuadppm [
	| aA |
	aA := FullMatrix
				rotationMatrixFromOrigin: (FullColumn zero: 3)
				zPoint: (FullColumn
						with: -1.0d
						with: -1.0d
						with: 1.0d)
				xPoint: (FullColumn
						with: -1.0d
						with: 0.0d
						with: -1.0d).
	self viewWorldFrom: aA
]

{ #category : #calc }
CADDrawingInterface >> viewYupQuadppp [
	| aA |
	aA := FullMatrix
				rotationMatrixFromOrigin: (FullColumn zero: 3)
				zPoint: (FullColumn
						with: -1.0d
						with: -1.0d
						with: -1.0d)
				xPoint: (FullColumn
						with: 1.0d
						with: 0.0d
						with: -1.0d).
	self viewWorldFrom: aA
]

{ #category : #calc }
CADDrawingInterface >> viewYupXleft [
	| aA |
	aA := FullMatrix
				rotationMatrixFromOrigin: (FullColumn zero: 3)
				zPoint: (FullColumn
						with: 0.0d
						with: 0.0d
						with: 1.0d)
				xPoint: (FullColumn
						with: -1.0d
						with: 0.0d
						with: 0.0d).
	self viewWorldFrom: aA
]

{ #category : #calc }
CADDrawingInterface >> viewYupXright [
	| aA |
	aA := FullMatrix
				rotationMatrixFromOrigin: (FullColumn zero: 3)
				zPoint: (FullColumn
						with: 0.0d
						with: 0.0d
						with: -1.0d)
				xPoint: (FullColumn
						with: 1.0d
						with: 0.0d
						with: 0.0d).
	self viewWorldFrom: aA
]

{ #category : #calc }
CADDrawingInterface >> viewYupZleft [
	| aA |
	aA := FullMatrix
				rotationMatrixFromOrigin: (FullColumn zero: 3)
				zPoint: (FullColumn
						with: -1.0d
						with: 0.0d
						with: 0.0d)
				xPoint: (FullColumn
						with: 0.0d
						with: 0.0d
						with: -1.0d).
	self viewWorldFrom: aA
]

{ #category : #calc }
CADDrawingInterface >> viewYupZright [
	| aA |
	aA := FullMatrix
				rotationMatrixFromOrigin: (FullColumn zero: 3)
				zPoint: (FullColumn
						with: 1.0d
						with: 0.0d
						with: 0.0d)
				xPoint: (FullColumn
						with: 0.0d
						with: 0.0d
						with: 1.0d).
	self viewWorldFrom: aA
]

{ #category : #calc }
CADDrawingInterface >> viewZupQuadmmp [
	| aA |
	aA := FullMatrix
				rotationMatrixFromOrigin: (FullColumn zero: 3)
				zPoint: (FullColumn
						with: 1.0d
						with: 1.0d
						with: -1.0d)
				xPoint: (FullColumn
						with: 1.0d
						with: -1.0d
						with: 0.0d).
	self viewWorldFrom: aA
]

{ #category : #calc }
CADDrawingInterface >> viewZupQuadmpp [
	| aA |
	aA := FullMatrix
				rotationMatrixFromOrigin: (FullColumn zero: 3)
				zPoint: (FullColumn
						with: 1.0d
						with: -1.0d
						with: -1.0d)
				xPoint: (FullColumn
						with: -1.0d
						with: -1.0d
						with: 0.0d).
	self viewWorldFrom: aA
]

{ #category : #calc }
CADDrawingInterface >> viewZupQuadpmp [
	| aA |
	aA := FullMatrix
				rotationMatrixFromOrigin: (FullColumn zero: 3)
				zPoint: (FullColumn
						with: -1.0d
						with: 1.0d
						with: -1.0d)
				xPoint: (FullColumn
						with: 1.0d
						with: 1.0d
						with: 0.0d).
	self viewWorldFrom: aA
]

{ #category : #calc }
CADDrawingInterface >> viewZupQuadppp [
	| aA |
	aA := FullMatrix
				rotationMatrixFromOrigin: (FullColumn zero: 3)
				zPoint: (FullColumn
						with: -1.0d
						with: -1.0d
						with: -1.0d)
				xPoint: (FullColumn
						with: -1.0d
						with: 1.0d
						with: 0.0d).
	self viewWorldFrom: aA
]

{ #category : #calc }
CADDrawingInterface >> viewZupXleft [
	| aA |
	aA := FullMatrix
				rotationMatrixFromOrigin: (FullColumn zero: 3)
				zPoint: (FullColumn
						with: 0.0d
						with: -1.0d
						with: 0.0d)
				xPoint: (FullColumn
						with: -1.0d
						with: 0.0d
						with: 0.0d).
	self viewWorldFrom: aA
]

{ #category : #calc }
CADDrawingInterface >> viewZupXright [
	| aA |
	aA := FullMatrix
				rotationMatrixFromOrigin: (FullColumn zero: 3)
				zPoint: (FullColumn
						with: 0.0d
						with: 1.0d
						with: 0.0d)
				xPoint: (FullColumn
						with: 1.0d
						with: 0.0d
						with: 0.0d).
	self viewWorldFrom: aA
]

{ #category : #calc }
CADDrawingInterface >> viewZupYleft [
	| aA |
	aA := FullMatrix
				rotationMatrixFromOrigin: (FullColumn zero: 3)
				zPoint: (FullColumn
						with: 1.0d
						with: 0.0d
						with: 0.0d)
				xPoint: (FullColumn
						with: 0.0d
						with: -1.0d
						with: 0.0d).
	self viewWorldFrom: aA
]

{ #category : #calc }
CADDrawingInterface >> viewZupYright [
	| aA |
	aA := FullMatrix
				rotationMatrixFromOrigin: (FullColumn zero: 3)
				zPoint: (FullColumn
						with: -1.0d
						with: 0.0d
						with: 0.0d)
				xPoint: (FullColumn
						with: 0.0d
						with: 1.0d
						with: 0.0d).
	self viewWorldFrom: aA
]

{ #category : #accessing }
CADDrawingInterface >> worldFrame [
	^worldFrame
]

{ #category : #accessing }
CADDrawingInterface >> zRotationalJointAt: rDpD [ 
	| depthSortedGOs |
	depthSortedGOs := self graphicsIntersecting: rDpD.
	depthSortedGOs := depthSortedGOs 
				select: [:assoc | assoc key isZRotational].
	^depthSortedGOs isEmpty not 
		ifTrue: [depthSortedGOs first key]
		ifFalse: 
			[self soleSelection 
				ifNotNil: [:a | a cadObject isZRotational ifTrue: [a cadObject] ifFalse: [nil]]]
]

{ #category : #accessing }
CADDrawingInterface >> zTranslationalJointAt: rDpD [ 
	| depthSortedGOs |
	depthSortedGOs := self graphicsIntersecting: rDpD.
	depthSortedGOs := depthSortedGOs 
				select: [:assoc | assoc key isZTranslational].
	^depthSortedGOs isEmpty not 
		ifTrue: [depthSortedGOs first key]
		ifFalse: 
			[self soleSelection 
				ifNotNil: [:a | a cadObject isZTranslational ifTrue: [a cadObject] ifFalse: [nil]]]
]

{ #category : #DYN }
CADDrawingInterface >> zeroAllVelocities [
	self partList do: [:part | part zeroVelocities]
]

{ #category : #GEO }
CADDrawingInterface >> zoomIn [
	"Use delay to make the menu item blink."

	(Delay forMilliseconds: 10) wait.
	self selectTool: (CADZoomInTool 
				icon: (GFTool stockIconFor: 'Line')
				cursor: self gfCursorClass crossHair
				name: 'Zoom In')
]

{ #category : #GEO }
CADDrawingInterface >> zoomOut [
	| rDpanePx rPcenterP rOcenterO pixelPerMetre |
	rDpanePx := self paneBoundsInDrawingCoordinates.
	projectionFrame := self projectionFrame.
	rPcenterP := projectionFrame 
				xyPlaneIntersectLine: (self projectorAt: rDpanePx center).
	rOcenterO := projectionFrame rOpOfromrfpf: rPcenterP.
	pixelPerMetre := self pixelPerMetre * 0.5d.
	projectionFrame rFfF: rOcenterO pixelPerMetre: pixelPerMetre.
	self centerPaneAtDrawingPoint: 0 @ 0.
	self noSelections.
	self setDefaultTool
]

{ #category : #GEO }
CADDrawingInterface >> zoomOut1 [
	| rDpanePx rPcenterP rOcenterO pixelPerMetre |
	rDpanePx := self paneBoundsInDrawingCoordinates.
	projectionFrame := self projectionFrame.
	rPcenterP := projectionFrame xyPlaneIntersectLine: (self projectorAt: rDpanePx center).
	rOcenterO := projectionFrame rOpOfromrfpf: rPcenterP.
	pixelPerMetre := self pixelPerMetre * 0.5d.
	projectionFrame rFfF: rOcenterO pixelPerMetre: pixelPerMetre.
	self centerPaneAtDrawingPoint: 0 @ 0.
	self displayAll.
	self noSelections.
	self setDefaultTool
]
