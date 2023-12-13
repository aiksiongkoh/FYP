Class {
	#name : #GEOAnyPart,
	#superclass : #GEOAnyGraphic,
	#instVars : [
		'markers'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'triggering events' }
GEOAnyPart class >> constructEventsTriggered [
	^(super constructEventsTriggered)
		add: #getRefCurves;
		add: #getRefPoints;
		add: #getRefSurfaces;
		add: #getNMT;
		yourself
]

{ #category : #'VisualWorks metadata' }
GEOAnyPart class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
GEOAnyPart >> aDXFBLOCK [
	^self triggerEvent: #getDXFBLOCK
]

{ #category : #accessing }
GEOAnyPart >> aDXFBLOCK: aDXFBLOCK [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	aDXFBLOCK removeSup.
	super addRefFrame: aDXFBLOCK aRefFrame.
	self removeActionsForEvent: #getDXFBLOCK.
	aDXFBLOCK ifNotNil: 
			[self 
				when: #getDXFBLOCK
				ask: aDXFBLOCK
				perform: #yourself].
	aDXFBLOCK aSup: self.
	self calcBoundingBox.
	^aDXFBLOCK
]

{ #category : #accessing }
GEOAnyPart >> aJpp [
	^DiagonalMatrix
		with: 0.0d
		with: 0.0d
		with: 0.0d
]

{ #category : #accessing }
GEOAnyPart >> aMassMarker: aMassMarker [ 
	| guideFrame |
	self removeActionsForEvent: #getMassMarker.
	aMassMarker ifNotNil: 
			[aMassMarker container: self.
			aMassMarker refFrame refFrame: self refFrame.
			guideFrame := GEOCartesianFrame2 
						refFrame: refFrame
						rFfF: (FullColumn zero: 3)
						aAFf: (FullMatrix identity: 3).
			aMassMarker guideFrame: guideFrame.
			self 
				when: #getMassMarker
				ask: aMassMarker
				perform: #yourself]
]

{ #category : #accessing }
GEOAnyPart >> aNMT [
	^self triggerEvent: #getNMT
]

{ #category : #accessing }
GEOAnyPart >> aNMT: aNMT [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	aNMT removeSup.
	super addRefFrame: aNMT aRefFrame.
	self removeActionsForEvent: #getNMT.
	aNMT ifNotNil: 
			[self 
				when: #getNMT
				ask: aNMT
				perform: #yourself].
	aNMT aSup: self.
	self calcBoundingBox.
	^aNMT
]

{ #category : #DYN }
GEOAnyPart >> addCurrentStateToDataSeries [
	| data |
	data := self dataFromCurrentState.
	self dataSeries add: data
]

{ #category : #accessing }
GEOAnyPart >> addCurveMarker: curveMarker [ 
	| curveMarkerRefFrame curveMarkerRefFrameRefFrame newCurveMarkerRefFrameRefFrame |
	curveMarker container: self.
	curveMarkerRefFrame := curveMarker refFrame.
	curveMarkerRefFrameRefFrame := curveMarkerRefFrame refFrame.
	newCurveMarkerRefFrameRefFrame := GEOCartesianFrame2
				refFrame: refFrame
				rFfF: (refFrame rfpffromrOpO: curveMarkerRefFrameRefFrame rOfO)
				aAFf: (refFrame aAOf transpose timesFullMatrix: curveMarkerRefFrameRefFrame aAOf).
	curveMarkerRefFrame release.
	curveMarker refFrame: curveMarkerRefFrame.
	curveMarkerRefFrame refFrame: newCurveMarkerRefFrameRefFrame.
	curveMarker rFfFCurve refFrame: newCurveMarkerRefFrameRefFrame.
	markers add: curveMarker
]

{ #category : #accessing }
GEOAnyPart >> addMarker2: geoMarker [ 
	| markerFrame newMarkerFrame guideFrame newGuideFrame |
	geoMarker container: self.
	markerFrame := geoMarker refFrame.
	newMarkerFrame := GEOCartesianFrame2
				refFrame: refFrame
				rFfF: (refFrame rfpffromrOpO: markerFrame rOfO)
				aAFf: (refFrame aAOf transpose timesFullMatrix: markerFrame aAOf).
	markerFrame release.
	geoMarker refFrame: newMarkerFrame.
	(guideFrame := geoMarker guideFrame) notNil
		ifTrue: 
			[newGuideFrame := GEOCartesianFrame2
						refFrame: refFrame
						rFfF: (refFrame rfpffromrOpO: guideFrame rOfO)
						aAFf: (refFrame aAOf transpose timesFullMatrix: guideFrame aAOf).
			geoMarker guideFrame: newGuideFrame].
	markers add: geoMarker
]

{ #category : #accessing }
GEOAnyPart >> addMarker: geoMarker [ 
	| markerFrame newMarkerFrame guideFrame newGuideFrame |
	geoMarker container: self.
	markerFrame := geoMarker refFrame.
	newMarkerFrame := GEOCartesianFrame2 
				refFrame: refFrame
				rFfF: (refFrame rfpffromrOpO: markerFrame rOfO)
				aAFf: (refFrame aAOf transpose timesFullMatrix: markerFrame aAOf).
	markerFrame release.
	geoMarker refFrame: newMarkerFrame.
	newGuideFrame := (guideFrame := geoMarker guideFrame) ifNil: 
					[GEOCartesianFrame2 
						refFrame: refFrame
						rFfF: (FullColumn zero: 3)
						aAFf: (FullMatrix identity: 3)]
				ifNotNil: 
					[GEOCartesianFrame2 
						refFrame: refFrame
						rFfF: (refFrame rfpffromrOpO: guideFrame rOfO)
						aAFf: (refFrame aAOf transpose timesFullMatrix: guideFrame aAOf)].
	geoMarker guideFrame: newGuideFrame.
	markers add: geoMarker
]

{ #category : #accessing }
GEOAnyPart >> addMarkersIn: set [ 
	set addAll: markers
]

{ #category : #accessing }
GEOAnyPart >> addRefCurves: array [
	array do: 
			[:refCurve |
			refCurve markers do: 
					[:marker |
					| curveMarker eqnCurveFrame |
					curveMarker := GEOCurveMarker new.
					curveMarker name: marker name.
					curveMarker rFfFCurve rfpfEqn: refCurve rfCurvef copy.
					curveMarker s: marker s.
					curveMarker container: self.
					eqnCurveFrame := GEOCartesianFrame2
								refFrame: refFrame
								rFfF: refCurve refFrame rFfF
								aAFf: refCurve refFrame aAFf.
					curveMarker rFfFCurve refFrame: eqnCurveFrame.
					curveMarker refFrame refFrame: eqnCurveFrame.
					markers add: curveMarker.].].
]

{ #category : #accessing }
GEOAnyPart >> addRefPoints: array [
	array do: 
			[:refPoint |
			refPoint markers do: 
					[:marker |
					| geoMarker newGuideFrame newMarkerFrame |
					geoMarker := GEOMarker new.
					geoMarker name: marker name.
					geoMarker container: self.
					newGuideFrame := GEOCartesianFrame2
								refFrame: refFrame
								rFfF: refPoint refFrame rFfF
								aAFf: refPoint refFrame aAFf.
					geoMarker guideFrame: newGuideFrame.
					newMarkerFrame := GEOCartesianFrame2
								refFrame: refFrame
								rFfF: (newGuideFrame rFfF
										plusFullColumn: (newGuideFrame aAFf timesFullColumn: marker refFrame rFfF))
								aAFf: (newGuideFrame aAFf timesFullMatrix: marker refFrame aAFf).
					geoMarker refFrame: newMarkerFrame.
					markers add: geoMarker.].].
]

{ #category : #accessing }
GEOAnyPart >> addRefSurfaces: array [ 
	"Do nothing for now."
]

{ #category : #accessing }
GEOAnyPart >> anyPart [
	^self
]

{ #category : #accessing }
GEOAnyPart >> asTreeNode [
	| answer |
	answer := super asTreeNode.
	answer children add: (self treeNodesBlock value: markers value: 'Markers').
	^answer
]

{ #category : #accessing }
GEOAnyPart >> asTreeNode1 [
	| answer children child list |
	answer := GEOTreeNode new.
	answer geoItem: self.
	children := OrderedCollection new.
	child := GEOTreeNode new.
	child geoItem: markers.
	list := List new: markers size.
	markers do: [:marker | list add: marker asTreeNode].
	list sortWith: [:node1 :node2 | node1 geoItem name <= node2 geoItem name].
	child children: list.
	child displayString: 'Markers'.
	children add: child.
	answer children: children.
	answer displayString: self name.
	^answer
]

{ #category : #accessing }
GEOAnyPart >> cMarker [
	^markers
]

{ #category : #DYN }
GEOAnyPart >> canUpdateForFrame: integer [ 
	^[(self dataSeries at: integer) notNil]
		on: Object subscriptOutOfBoundsSignal do: [:ex | ex return: false]
]

{ #category : #DYN }
GEOAnyPart >> createMbD [
	"MbDMarkers are created on demand by joints, forces, etc."

	| mbdUnits part |
	self dataSeries: OrderedCollection new.
	self discontinuities: OrderedCollection new.
	mbdUnits := self mbdUnits.
	part := MbDPart new.
	self mbdObject: part.
	part name: self fullName.
	part m: self mass / mbdUnits mass.
	part aJ: self mJpp / mbdUnits aJ.
	part qX: self rOcmO / mbdUnits length.
	part qE: self qEp.
	part qXdot: self vOcmO / mbdUnits velocity.
	part omeOpO: self omeOpO / mbdUnits omega.
	part qXddot: (FullColumn zero: 3).
	part qEddot: (FullColumn zero: 4).
	part submitToSystem
]

{ #category : #accessing }
GEOAnyPart >> cutMarker: geoMarker [ 
	markers remove: geoMarker
]

{ #category : #DYN }
GEOAnyPart >> dataFromCurrentState [
	| answer |
	answer := GEOPosVelAccData new.
	answer rOfO: refFrame rOfO.
	answer aAOf: refFrame aAOf.
	answer vOfO: refFrame vOfO.
	answer omeOfO: refFrame omeOfO.
	answer aOfO: refFrame aOfO.
	answer alpOfO: refFrame alpOfO.
	^answer
]

{ #category : #DYN }
GEOAnyPart >> dataFromMbD [
	"
	P := part frame. 
	p := principal frame at cm. 
	rOcmO := rOPO + aAOP*rPcmP. 
	aAOp := aAOP*aAPp. 
	vOcmO := vOPO + aAdotOP*rPcmP 
	:= vOPO + (omeOPO cross: aAOP*rPcmP). 
	omeOpO := omeOPO. 
	aOcmO := aOPO + aAddotOP*rPcmP 
	:= aOPO + (alpOPO cross: aAOP*rPcmP) + (omeOPO cross: (omeOPO cross: aAOP*rPcmP)). 
	alpOpO := alpOPO. 
	
	Therefore 
	aAOP := aAOp*aAPpT 
	rOPO := rOcmO - aAOP*rPcmP. 
	omeOPO := omeOpO. 
	vOPO	:= vOcmO - (omeOPO cross: aAOP*rPcmP). 
	alpOPO := alpOpO. 
	aOPO	:= aOcmO - (alpOPO cross: aAOP*rPcmP) - (omeOPO cross: (omeOPO cross: 
	aAOP*rPcmP)). 
	"

	| mbdUnits mbdPart rOcmO aAOp vOcmO omeOPO aOcmO alpOPO rPcmP aAPp aAOP rPcmO rOPO vOPO aOPO answer |
	mbdUnits := self mbdUnits.
	mbdPart := self mbdObject.
	rOcmO := mbdPart qX * mbdUnits length.
	aAOp := mbdPart aA.
	vOcmO := mbdPart qXdot * mbdUnits velocity.
	omeOPO := mbdPart omeOpO * mbdUnits omega.
	aOcmO := mbdPart qXddot * mbdUnits acceleration.
	alpOPO := mbdPart alpOpO * mbdUnits alpha.
	rPcmP := self rPcmP.
	aAPp := self aAPp.
	aAOP := aAOp timesFullMatrix: aAPp transpose.
	rPcmO := aAOP timesFullColumn: rPcmP.
	rOPO := rOcmO - rPcmO.
	vOPO := vOcmO - (omeOPO cross: rPcmO).
	aOPO := aOcmO - (alpOPO cross: rPcmO) - (omeOPO cross: (omeOPO cross: rPcmO)).
	answer := GEOPosVelAccData new.
	answer rOfO: rOPO.
	answer aAOf: aAOP.
	answer vOfO: vOPO.
	answer omeOfO: omeOPO.
	answer aOfO: aOPO.
	answer alpOfO: alpOPO.
	^answer
]

{ #category : #DYN }
GEOAnyPart >> deleteMbD [
	self mbdObject: nil
]

{ #category : #accessing }
GEOAnyPart >> findMarkerNamed: nameComponents [ 
	^self name = (nameComponents at: 1)
		ifTrue: [markers detect: [:marker | marker name = (nameComponents at: 2)]
				ifNone: nil]
		ifFalse: [nil]
]

{ #category : #accessing }
GEOAnyPart >> generateUniqueMarkerName [
	| aString aItemList nameList count newName |
	aString := 'Marker'.
	aItemList := self markerList.
	nameList := aItemList collect: 
					[:aItem | 
					(aItem name isKindOf: String) ifTrue: [aItem name asSymbol] ifFalse: [#'']].
	count := 0.
	
	[count := count + 1.
	newName := aString , count printString.
	nameList includes: newName asSymbol] 
			whileTrue.
	^newName
]

{ #category : #accessing }
GEOAnyPart >> getRefPoints [

	| answer |
	answer := self triggerEvent: #getRefPoints.
	answer == nil ifTrue: [ 
		answer := StCAD_Misc_OrderedSet new. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
		self refPoints: answer ].
	^ answer
]

{ #category : #accessing }
GEOAnyPart >> inPlaneFrame [
	^self interface projectionFrame
]

{ #category : #'initialize-release' }
GEOAnyPart >> initialize [

	super initialize.
	markers := StCAD_Misc_OrderedSet new "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
]

{ #category : #accessing }
GEOAnyPart >> mJpp [
	^DiagonalMatrix
		with: 0.0d
		with: 0.0d
		with: 0.0d
]

{ #category : #accessing }
GEOAnyPart >> markerList [
	^markers asSortedCollection: [:a :b | a name <= b name]
]

{ #category : #accessing }
GEOAnyPart >> markerList: collection [ 
	collection addAll: markers
]

{ #category : #accessing }
GEOAnyPart >> markers [
	^markers
]

{ #category : #accessing }
GEOAnyPart >> mass [
	^0.0d
]

{ #category : #PDMS }
GEOAnyPart >> mosesFrame [

	^ markers detect: [ :marker | 
		  marker isMemberOf: StCAD_UI_MOSES_Frame "VW_TRANSLATION:StCAD.UI.MOSES.Frame:StCAD_UI_MOSES_Frame" ]
]

{ #category : #accessing }
GEOAnyPart >> omeOpO [
	^FullColumn zero: 3
]

{ #category : #PDMS }
GEOAnyPart >> pdmsFrame [

	^ markers detect: [ :marker | 
		  marker isMemberOf: StCAD_UI_PDMS_Frame "VW_TRANSLATION:StCAD.UI.PDMS.Frame:StCAD_UI_PDMS_Frame" ]
]

{ #category : #copying }
GEOAnyPart >> postCopy [
	| originalMarkers |
	super postCopy.
	originalMarkers := markers.
	markers := originalMarkers class new.
	originalMarkers do: [:marker | self addMarker: marker copy]
]

{ #category : #PDMS }
GEOAnyPart >> povrayFrame [

	^ markers detect: [ :marker | 
		  marker isMemberOf: StCAD_UI_POVRay_Frame "VW_TRANSLATION:StCAD.UI.POVRay.Frame:StCAD_UI_POVRay_Frame" ]
]

{ #category : #copying }
GEOAnyPart >> preSave [
	super preSave.
	markers do: [:marker | marker preSave]
]

{ #category : #accessing }
GEOAnyPart >> qEp [
	^refFrame aAOf mbdEulerParameters
]

{ #category : #accessing }
GEOAnyPart >> rOcmO [
	^refFrame rOpOfromrfpf: self rPcmP
]

{ #category : #accessing }
GEOAnyPart >> refCurves [
	^self markerList select: [:marker | marker isMemberOf: GEOCurveMarker.].
]

{ #category : #accessing }
GEOAnyPart >> refPoints [
	^self markerList
		select: [:marker | (marker isMemberOf: GEOCurveMarker) not.].
]

{ #category : #accessing }
GEOAnyPart >> refPoints: refPoints [ 
	self removeActionsForEvent: #getRefPoints.
	refPoints notNil ifTrue: [self
			when: #getRefPoints
			ask: refPoints
			perform: #yourself]
]

{ #category : #accessing }
GEOAnyPart >> refSurfaces [
	^Array new
]

{ #category : #'initialize-release' }
GEOAnyPart >> release [
	markers do: [:marker | marker release].
	super release
]

{ #category : #accessing }
GEOAnyPart >> removeDXFBLOCK: aaDXFBLOCK [ 
	^self aDXFBLOCK == aaDXFBLOCK 
		ifTrue: 
			[self removeActionsForEvent: #getDXFBLOCK.
			aaDXFBLOCK aSup: nil.
			aaDXFBLOCK]
		ifFalse: [self halt: 'check this']
]

{ #category : #accessing }
GEOAnyPart >> removeNMT: aaNMT [ 
	^self aNMT == aaNMT 
		ifTrue: 
			[self removeActionsForEvent: #getNMT.
			aaNMT aSup: nil.
			aaNMT]
		ifFalse: [self halt: 'check this']
]

{ #category : #DYN }
GEOAnyPart >> storeInputFromMbD [
	"Do nothing."
]

{ #category : #DYN }
GEOAnyPart >> storeInputState [
	| data |
	data := self dataFromCurrentState.
	self inputData: data.
	markers do: [:marker | marker storeInputState]
]

{ #category : #printing }
GEOAnyPart >> storePOVTimeSeriesOn: aStream [
	| dataSeries fullNamePOV series |
	dataSeries := self dataSeries.
	fullNamePOV := self fullNamePOV.
	series := dataSeries collect: [:data | data rOfO.].
	aStream storePOVTitle: fullNamePOV , '_X'
		series: (series collect: [:data | data at: 1.]).
	aStream storePOVTitle: fullNamePOV , '_Y'
		series: (series collect: [:data | data at: 2.]).
	aStream storePOVTitle: fullNamePOV , '_Z'
		series: (series collect: [:data | data at: 3.]).
	series := dataSeries
				collect: [:data | GEOEulerAngleszyx fromA: data aAOf.].
	aStream storePOVTitle: fullNamePOV , '_RotX'
		series: (series collect: [:data | (data at: 3) radiansToDegrees.]).
	aStream storePOVTitle: fullNamePOV , '_RotY'
		series: (series collect: [:data | (data at: 2) radiansToDegrees.]).
	aStream storePOVTitle: fullNamePOV , '_RotZ'
		series: (series collect: [:data | (data at: 1) radiansToDegrees.]).
	series := dataSeries collect: [:data | data vOfO.].
	aStream storePOVTitle: fullNamePOV , '_VX'
		series: (series collect: [:data | data at: 1.]).
	aStream storePOVTitle: fullNamePOV , '_VY'
		series: (series collect: [:data | data at: 2.]).
	aStream storePOVTitle: fullNamePOV , '_VZ'
		series: (series collect: [:data | data at: 3.]).
	series := dataSeries collect: [:data | data omeOfO.].
	aStream storePOVTitle: fullNamePOV , '_OmegaX'
		series: (series collect: [:data | (data at: 1) radiansToDegrees.]).
	aStream storePOVTitle: fullNamePOV , '_OmegaY'
		series: (series collect: [:data | (data at: 2) radiansToDegrees.]).
	aStream storePOVTitle: fullNamePOV , '_OmegaZ'
		series: (series collect: [:data | (data at: 3) radiansToDegrees.]).
	series := dataSeries collect: [:data | data aOfO.].
	aStream storePOVTitle: fullNamePOV , '_AX'
		series: (series collect: [:data | data at: 1.]).
	aStream storePOVTitle: fullNamePOV , '_AY'
		series: (series collect: [:data | data at: 2.]).
	aStream storePOVTitle: fullNamePOV , '_AZ'
		series: (series collect: [:data | data at: 3.]).
	series := dataSeries collect: [:data | data alpOfO.].
	aStream storePOVTitle: fullNamePOV , '_AlphaX'
		series: (series collect: [:data | (data at: 1) radiansToDegrees.]).
	aStream storePOVTitle: fullNamePOV , '_AlphaY'
		series: (series collect: [:data | (data at: 2) radiansToDegrees.]).
	aStream storePOVTitle: fullNamePOV , '_AlphaZ'
		series: (series collect: [:data | (data at: 3) radiansToDegrees.]).
	markers do: [:item | item storePOVTimeSeriesOn: aStream.].
]

{ #category : #printing }
GEOAnyPart >> storePOVdatCurrentOn: aStream [
	| dataSeries fullNamePOV series |
	dataSeries := Array with: self dataFromCurrentState.
	fullNamePOV := self fullNamePOV.
	series := dataSeries collect: [:data | data rOfO.].
	aStream storePOVTitle: fullNamePOV , '_X'
		series: (series collect: [:data | data at: 1.]).
	aStream storePOVTitle: fullNamePOV , '_Y'
		series: (series collect: [:data | data at: 2.]).
	aStream storePOVTitle: fullNamePOV , '_Z'
		series: (series collect: [:data | data at: 3.]).
	series := dataSeries
				collect: [:data | GEOEulerAngleszyx fromA: data aAOf.].
	aStream storePOVTitle: fullNamePOV , '_RotX'
		series: (series collect: [:data | (data at: 3) radiansToDegrees.]).
	aStream storePOVTitle: fullNamePOV , '_RotY'
		series: (series collect: [:data | (data at: 2) radiansToDegrees.]).
	aStream storePOVTitle: fullNamePOV , '_RotZ'
		series: (series collect: [:data | (data at: 1) radiansToDegrees.]).
	series := dataSeries collect: [:data | data vOfO.].
	aStream storePOVTitle: fullNamePOV , '_VX'
		series: (series collect: [:data | data at: 1.]).
	aStream storePOVTitle: fullNamePOV , '_VY'
		series: (series collect: [:data | data at: 2.]).
	aStream storePOVTitle: fullNamePOV , '_VZ'
		series: (series collect: [:data | data at: 3.]).
	series := dataSeries collect: [:data | data omeOfO.].
	aStream storePOVTitle: fullNamePOV , '_OmegaX'
		series: (series collect: [:data | (data at: 1) radiansToDegrees.]).
	aStream storePOVTitle: fullNamePOV , '_OmegaY'
		series: (series collect: [:data | (data at: 2) radiansToDegrees.]).
	aStream storePOVTitle: fullNamePOV , '_OmegaZ'
		series: (series collect: [:data | (data at: 3) radiansToDegrees.]).
	series := dataSeries collect: [:data | data aOfO.].
	aStream storePOVTitle: fullNamePOV , '_AX'
		series: (series collect: [:data | data at: 1.]).
	aStream storePOVTitle: fullNamePOV , '_AY'
		series: (series collect: [:data | data at: 2.]).
	aStream storePOVTitle: fullNamePOV , '_AZ'
		series: (series collect: [:data | data at: 3.]).
	series := dataSeries collect: [:data | data alpOfO.].
	aStream storePOVTitle: fullNamePOV , '_AlphaX'
		series: (series collect: [:data | (data at: 1) radiansToDegrees.]).
	aStream storePOVTitle: fullNamePOV , '_AlphaY'
		series: (series collect: [:data | (data at: 2) radiansToDegrees.]).
	aStream storePOVTitle: fullNamePOV , '_AlphaZ'
		series: (series collect: [:data | (data at: 3) radiansToDegrees.]).
	markers do: [:item | item storePOVdatCurrentOn: aStream.].
]

{ #category : #printing }
GEOAnyPart >> storeTimeSeriesOn: aStream [ 
	| inputData dataSeries series |
	aStream nextPutAll: self nameString; nextPutAll: 'Series'; space; nextPutAll: self fullName; cr.
	inputData := self inputData.
	dataSeries := self dataSeries.
	series := dataSeries collect: [:data | data rOfO].
	aStream
		storeTitle: 'X'
		input: (inputData rOfO at: 1)
		series: (series collect: [:data | data at: 1]).
	aStream
		storeTitle: 'Y'
		input: (inputData rOfO at: 2)
		series: (series collect: [:data | data at: 2]).
	aStream
		storeTitle: 'Z'
		input: (inputData rOfO at: 3)
		series: (series collect: [:data | data at: 3]).
	series := dataSeries collect: [:data | data aAOf bryantAngles].
	aStream
		storeTitle: 'Bryantx'
		input: (inputData aAOf bryantAngles at: 1)
		series: (series collect: [:data | data at: 1]).
	aStream
		storeTitle: 'Bryanty'
		input: (inputData aAOf bryantAngles at: 2)
		series: (series collect: [:data | data at: 2]).
	aStream
		storeTitle: 'Bryantz'
		input: (inputData aAOf bryantAngles at: 3)
		series: (series collect: [:data | data at: 3]).
	series := dataSeries collect: [:data | data vOfO].
	aStream
		storeTitle: 'VX'
		input: (inputData vOfO at: 1)
		series: (series collect: [:data | data at: 1]).
	aStream
		storeTitle: 'VY'
		input: (inputData vOfO at: 2)
		series: (series collect: [:data | data at: 2]).
	aStream
		storeTitle: 'VZ'
		input: (inputData vOfO at: 3)
		series: (series collect: [:data | data at: 3]).
	series := dataSeries collect: [:data | data omeOfO].
	aStream
		storeTitle: 'OmegaX'
		input: (inputData omeOfO at: 1)
		series: (series collect: [:data | data at: 1]).
	aStream
		storeTitle: 'OmegaY'
		input: (inputData omeOfO at: 2)
		series: (series collect: [:data | data at: 2]).
	aStream
		storeTitle: 'OmegaZ'
		input: (inputData omeOfO at: 3)
		series: (series collect: [:data | data at: 3]).
	series := dataSeries collect: [:data | data aOfO].
	aStream
		storeTitle: 'AX'
		input: 0
		series: (series collect: [:data | data at: 1]).
	aStream
		storeTitle: 'AY'
		input: 0
		series: (series collect: [:data | data at: 2]).
	aStream
		storeTitle: 'AZ'
		input: 0
		series: (series collect: [:data | data at: 3]).
	series := dataSeries collect: [:data | data alpOfO].
	aStream
		storeTitle: 'AlphaX'
		input: 0
		series: (series collect: [:data | data at: 1]).
	aStream
		storeTitle: 'AlphaY'
		input: 0
		series: (series collect: [:data | data at: 2]).
	aStream
		storeTitle: 'AlphaZ'
		input: 0
		series: (series collect: [:data | data at: 3])
]

{ #category : #accessing }
GEOAnyPart >> uncutMarker: geoMarker [ 
	markers add: geoMarker
]

{ #category : #DYN }
GEOAnyPart >> updateForFrame1: integer [ 
	| data |
	data := self dataSeries at: integer.
	refFrame quietlyrOfO: data rOfO aAOf: data aAOf.
	refFrame quietlyvOfO: data vOfO omeOfO: data omeOfO
]

{ #category : #DYN }
GEOAnyPart >> updateForFrame: integer [ 
	| data |
	data := self dataSeries at: integer.
	refFrame quietlyrOfO: data rOfO aAOf: data aAOf.
	refFrame quietlyvOfO: data vOfO omeOfO: data omeOfO
]

{ #category : #DYN }
GEOAnyPart >> updateFromInitiallyAssembledState [
	| dataSeries data |
	dataSeries := self dataSeries.
	(dataSeries notNil and: [dataSeries isEmpty not])
		ifTrue: 
			[data := dataSeries at: 1.
			data notNil
				ifTrue: 
					[refFrame quietlyrOfO: data rOfO aAOf: data aAOf.
					refFrame quietlyvOfO: data vOfO omeOfO: data omeOfO]]
]

{ #category : #DYN }
GEOAnyPart >> updateFromInputState [
	| data |
	data := self inputData.
	data notNil 
		ifTrue: 
			[refFrame quietlyrOfO: data rOfO aAOf: data aAOf.
			refFrame quietlyvOfO: data vOfO omeOfO: data omeOfO].
	markers do: [:marker | marker updateFromInputState]
]

{ #category : #DYN }
GEOAnyPart >> updateFromMbD [
	| data |
	data := self dataFromMbD.
	self dataSeries add: data.
	refFrame quietlyrOfO: data rOfO aAOf: data aAOf.
	refFrame quietlyvOfO: data vOfO omeOfO: data omeOfO
]

{ #category : #accessing }
GEOAnyPart >> vOcmO [
	^FullColumn zero: 3
]
