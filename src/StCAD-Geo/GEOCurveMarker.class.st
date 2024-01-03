Class {
	#name : #GEOCurveMarker,
	#superclass : #GEOAnyMarker,
	#instVars : [
		's',
		'rFfFCurve'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOCurveMarker >> aAeqnfat: col [ 
	| prmemps tem1 te1 iem iem1 iem2 aAme |
	prmemps := rFfFCurve rfpfEqn pvalueps: col.
	tem1 := prmemps column: 1.
	te1 := tem1 length.
	iem := tem1 times: 1.0d / te1.
	iem1 := iem at: 1.
	iem2 := iem at: 2.
	aAme := FullMatrix new: 3 by: 3.
	(aAme at: 1) at: 1 put: iem1; at: 2 put: 0.0d; at: 3 put: iem2.
	(aAme at: 2) at: 1 put: iem2; at: 2 put: 0.0d; at: 3 put: iem1 negated.
	(aAme at: 3) at: 1 put: 0.0d; at: 2 put: 1.0d; at: 3 put: 0.0d.
	^aAme
]

{ #category : #accessing }
GEOCurveMarker >> aApm [
	| aAPp aAPm |
	aAPp := self anyPart aAPp.
	aAPm := refFrame refFrame aAFf.
	^aAPp transposeTimesFullMatrix: aAPm
]

{ #category : #rendering }
GEOCurveMarker >> basicRenderOn: aRenderingContext [ 
	super renderOn: aRenderingContext
]

{ #category : #DYN }
GEOCurveMarker >> canUpdateForFrame: integer [ 
	^[(self dataSeries at: integer) notNil]
		on: Object subscriptOutOfBoundsSignal do: [:ex | ex return: false]
]

{ #category : #DYN }
GEOCurveMarker >> createMbD [
	| mkr eFrm |
	self dataSeries: OrderedCollection new.
	self discontinuities: OrderedCollection new.
	mkr := MbDMarkerFrame new.
	mkr isOn: self anyPart mbdObject partFrame.
	mkr rpmp: self rpmp / self mbdUnits length.
	mkr aApm: self aApm.
	eFrm := MbDEndFrameqcs new.
	eFrm name: self fullName.
	eFrm isOn: mkr.
	eFrm rmemBlk: rFfFCurve rfpfEqn / self mbdUnits length.
	eFrm sSize: 1.
	eFrm s: (FullColumn with: 0.0d).
	eFrm sdot: (FullColumn with: 0.0d).
	eFrm submitToSystem.
	self mbdObject: eFrm
]

{ #category : #accessing }
GEOCurveMarker >> cut [
	container cutMarker: self.
	rFfFCurve refFrame cut.
	self triggerEvent: #release
]

{ #category : #accessing }
GEOCurveMarker >> dataClass [
	^GEORelPosVelAccData
]

{ #category : #DYN }
GEOCurveMarker >> dataFromCurrentState [
	| answer |
	answer := GEOSSdotSddotData new.
	answer s: (Array with: s).
	answer sdot: (Array with: 0.0d).
	answer sddot: (Array with: 0.0d).
	^answer
]

{ #category : #printing }
GEOCurveMarker >> dataFromCurrentStatePOV [
	"
	reqnfeqn := eqn y: s.
	rPfP := rPeqnP + aAPeqn*reqnfeqn.
	rOfO := rOPO + aAOP*rPfP.
	aAeqnf := self aAeqnf.
	aAPf := aAPeqn * aAeqnf.
	aAOf := aAOP * aAPf.
	"

	| markerFrame eqnFrame partFrame rPeqnP aAPeqn partData markerData rOPO aAOP vOPO omeOPO aOPO alpOPO reqnfeqn aAeqnf rPfP aAPf rPfO scol |
	markerFrame := self refFrame.
	eqnFrame := markerFrame refFrame.
	partFrame := eqnFrame refFrame.
	rPeqnP := eqnFrame rFfF.
	aAPeqn := eqnFrame aAFf.
	partData := partFrame body dataFromCurrentState.
	markerData := self dataClass new.
	markerData time: self geoTime value.
	rOPO := partData rOfO.
	aAOP := partData aAOf.
	vOPO := partData vOfO.
	omeOPO := partData omeOfO.
	aOPO := partData aOfO.
	alpOPO := partData alpOfO.
	scol := FullColumn with: s.
	reqnfeqn := self rFfFat: scol.
	aAeqnf := self aAeqnfat: scol.
	rPfP := rPeqnP + (aAPeqn timesFullColumn: reqnfeqn).
	aAPf := aAPeqn timesFullMatrix: aAeqnf.
	rPfO := aAOP timesFullColumn: rPfP.
	markerData rOfO: rOPO + rPfO.
	markerData aAOf: (aAOP timesFullMatrix: aAPf).
	markerData vOfO: vOPO + (omeOPO cross: rPfO).
	markerData omeOfO: omeOPO.
	markerData 
		aOfO: aOPO + (alpOPO cross: rPfO) + (omeOPO cross: (omeOPO cross: rPfO)).
	markerData alpOfO: alpOPO.
	^markerData
]

{ #category : #DYN }
GEOCurveMarker >> dataFromMbD [
	| mbdTime mbdItem answer |
	mbdTime := self mbdUnits time.
	mbdItem := self mbdObject.
	answer := GEOSSdotSddotData new.
	answer s: mbdItem s copy.
	answer sdot: mbdItem sdot copy / mbdTime.
	answer sddot: mbdItem sddot copy / (mbdTime * mbdTime).
	^answer
]

{ #category : #accessing }
GEOCurveMarker >> dataSeriesForChart [
	"
	reqnfeqn := eqn y: s.
	rPfP := rPeqnP + aAPeqn*reqnfeqn.
	rOfO := rOPO + aAOP*rPfP.
	aAeqnf := self aAeqnf.
	aAPf := aAPeqn * aAeqnf.
	aAOf := aAOP * aAPf.
	Only the material point velocity and accelerations are calculated. Not the contact point in space.
	"

	| markerFrame eqnFrame rPeqnP aAPeqn timeSeries partDataSeries dataSeries index markerData rOPO aAOP vOPO omeOPO aOPO alpOPO reqnfeqn aAeqnf rPfP aAPf rPfO zero |
	markerFrame := self refFrame.
	eqnFrame := markerFrame refFrame.
	rPeqnP := eqnFrame rFfF.
	aAPeqn := eqnFrame aAFf.
	timeSeries := self interface timeSeries.
	^timeSeries notNil 
		ifTrue: 
			[partDataSeries := container dataSeries.
			dataSeries := self dataSeries.
			index := 0.
			partDataSeries collect: 
					[:partData | 
					index := index + 1.
					markerData := self dataClass new.
					markerData time: (timeSeries at: index).
					rOPO := partData rOfO.
					aAOP := partData aAOf.
					vOPO := partData vOfO.
					omeOPO := partData omeOfO.
					aOPO := partData aOfO.
					alpOPO := partData alpOfO.
					reqnfeqn := self rFfFat: (dataSeries at: index) s.
					aAeqnf := self aAeqnfat: (dataSeries at: index) s.
					rPfP := rPeqnP + (aAPeqn timesFullColumn: reqnfeqn).
					aAPf := aAPeqn timesFullMatrix: aAeqnf.
					rPfO := aAOP timesFullColumn: rPfP.
					markerData rFfF: reqnfeqn.
					markerData aAFf: aAeqnf.
					zero := (FullColumn zero: 3).
					markerData vFfF: zero.
					markerData omeFfF: zero.
					markerData aFfF: zero.
					markerData alpFfF: zero.
					markerData rOfO: rOPO + rPfO.
					markerData aAOf: (aAOP timesFullMatrix: aAPf).
					markerData vOfO: vOPO + (omeOPO cross: rPfO).
					markerData omeOfO: omeOPO.
					markerData 
						aOfO: aOPO + (alpOPO cross: rPfO) + (omeOPO cross: (omeOPO cross: rPfO)).
					markerData alpOfO: alpOPO]]
		ifFalse: [Array new]
]

{ #category : #accessing }
GEOCurveMarker >> face: face [ 
	| interface name polyline rFpointsF sSeries |
	interface := face interface.
	name := interface promptUserForMarkerNameIn: face part.
	self name: name.
	polyline := face polyline.
	rFpointsF := polyline rfpointsf.
	sSeries := Interval
				from: -1.0d
				to: 1.0d
				by: 2.0d / (rFpointsF size - 1).
	rFfFCurve rfpfEqn: (GeneralSpline
			with: IndependentVariable new
			order: 5
			xs: sSeries
			ys: rFpointsF).
	self s: -1.0d.
	face addCurveMarker: self.
	interface createUpdateSelectGOfor: self
]

{ #category : #'initialize-release' }
GEOCurveMarker >> initialize [
	super initialize.
	rFfFCurve := GEOEquationCurve new.
	rFfFCurve container: self
]

{ #category : #testing }
GEOCurveMarker >> isCutable [
	^false
]

{ #category : #'initialize-release' }
GEOCurveMarker >> preSave [
	super preSave.
	rFfFCurve preSave
]

{ #category : #accessing }
GEOCurveMarker >> rFfFCurve [
	^rFfFCurve
]

{ #category : #accessing }
GEOCurveMarker >> rFfFat: col [ 
	^rFfFCurve rfpfEqn value: col
]

{ #category : #rendering }
GEOCurveMarker >> renderOn: aRenderingContext [ 
	rFfFCurve renderOn: aRenderingContext withCurveMarker: self
]

{ #category : #accessing }
GEOCurveMarker >> rpmp [
	| anyPart rPmP rPpP aAPp |
	anyPart := self anyPart.
	rPmP := refFrame refFrame rFfF.
	rPpP := anyPart rPcmP.
	aAPp := anyPart aAPp.
	^aAPp transposeTimesFullColumn: (rPmP minusFullColumn: rPpP)
]

{ #category : #accessing }
GEOCurveMarker >> s [
	^s
]

{ #category : #accessing }
GEOCurveMarker >> s: double [ 
	| rFfFEqn aAFf1 aAFf2 aAFf3 aAFf rFfF |
	s := double.
	rFfFEqn := rFfFCurve rfpfEqn.
	rFfF := rFfFEqn y: s.
	aAFf1 := (rFfFEqn dydx: s) normalizeSelf.
	aAFf2 := FullColumn
				with: 0.0d
				with: 0.0d
				with: 1.0d.
	aAFf3 := aAFf1 cross: aAFf2.
	aAFf := FullMatrix new: 3 by: 3.
	aAFf
		at: 1
		and: 1
		putFullColumn: aAFf1.
	aAFf
		at: 1
		and: 2
		putFullColumn: aAFf2.
	aAFf
		at: 1
		and: 3
		putFullColumn: aAFf3.
	refFrame quietlyrFfF: rFfF aAFf: aAFf
]

{ #category : #accessing }
GEOCurveMarker >> sets: double [ 
	s := double
]

{ #category : #DYN }
GEOCurveMarker >> storeInputState [
	| data |
	data := self dataFromCurrentState.
	self inputData: data
]

{ #category : #printing }
GEOCurveMarker >> storeOn: aStream level: level [ 
	aStream storeLevel: level title: 'RefCurve'.
	rFfFCurve refFrame storeOn: aStream level: level + 1.
	rFfFCurve rfpfEqn storeOn: aStream level: level + 1.
	aStream storeLevel: level + 1 title: 'CurveMarkers'.
	aStream storeLevel: level + 2 title: 'CurveMarker'.
	aStream
		storeLevel: level + 3
		title: 'Name'
		object: self name.
	aStream
		storeLevel: level + 3
		title: 's'
		object: s
]

{ #category : #printing }
GEOCurveMarker >> storePOVdatCurrentOn: aStream [
	| dataSeries fullNamePOV series |
	dataSeries := Array with: self dataFromCurrentStatePOV.
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
]

{ #category : #accessing }
GEOCurveMarker >> uncut [
	rFfFCurve refFrame uncut.
	container uncutMarker: self
]

{ #category : #DYN }
GEOCurveMarker >> updateForFrame: integer [ 
	| data |
	data := self dataSeries at: integer.
	self s: (data s at: 1)
]

{ #category : #DYN }
GEOCurveMarker >> updateFromInitiallyAssembledState [
	| dataSeries data |
	dataSeries := self dataSeries.
	dataSeries notNil
		ifTrue: 
			[data := dataSeries at: 1.
			data notNil ifTrue: [self s: (data s at: 1)]]
]

{ #category : #DYN }
GEOCurveMarker >> updateFromInputState [
	| data |
	data := self inputData.
	data notNil ifTrue: [self s: (data s at: 1)]
]

{ #category : #DYN }
GEOCurveMarker >> updateFromMbD [
	| data |
	data := self dataFromMbD.
	self dataSeries add: data.
	self s: (data s at: 1)
]
