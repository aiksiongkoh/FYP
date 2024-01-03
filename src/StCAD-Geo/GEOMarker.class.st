Class {
	#name : #GEOMarker,
	#superclass : #GEOAnyMarker,
	#instVars : [
		'guideFrame'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOMarker >> aApm [
	| aAPp aAPm |
	aAPp := self anyPart aAPp.
	aAPm := refFrame aAFf.
	^aAPp transposeTimesFullMatrix: aAPm
]

{ #category : #accessing }
GEOMarker >> aPVADataFromPartPVAData: partData [ 
	| rPfP aAPf markerData rOPO aAOP vOPO omeOPO aOPO alpOPO rPfO |
	rPfP := refFrame rFfF.
	aAPf := refFrame aAFf.
	markerData := partData class new.
	rOPO := partData rOfO.
	aAOP := partData aAOf.
	vOPO := partData vOfO.
	omeOPO := partData omeOfO.
	aOPO := partData aOfO.
	alpOPO := partData alpOfO.
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

{ #category : #accessing }
GEOMarker >> addCurrentStateToDataSeries [
	"Do nothing."
]

{ #category : #DYN }
GEOMarker >> createMbD [
	| mkr eFrm |
	mkr := MbDMarkerFrame new.
	mkr isOn: self anyPart mbdObject partFrame.
	mkr rpmp: self rpmp / self mbdUnits length.
	mkr aApm: self aApm.
	eFrm := MbDEndFrameqc new.
	eFrm name: self fullName.
	eFrm isOn: mkr.
	eFrm submitToSystem.
	self mbdObject: eFrm
]

{ #category : #accessing }
GEOMarker >> cut [
	guideFrame cut.
	super cut
]

{ #category : #accessing }
GEOMarker >> dataFromCurrentState [
	| rPfP aAPf partData markerData rOPO aAOP vOPO omeOPO aOPO alpOPO rPfO |
	rPfP := refFrame rFfF.
	aAPf := refFrame aAFf.
	partData := container dataFromCurrentState.
	markerData := self dataClass new.
	markerData time: self geoTime value.
	rOPO := partData rOfO.
	aAOP := partData aAOf.
	vOPO := partData vOfO.
	omeOPO := partData omeOfO.
	aOPO := partData aOfO.
	alpOPO := partData alpOfO.
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

{ #category : #accessing }
GEOMarker >> dataSeriesForChart [
	| rPfP aAPf timeSeries partDataSeries index markerData rOPO aAOP vOPO omeOPO aOPO alpOPO rPfO dataSeries |
	rPfP := refFrame rFfF.
	aAPf := refFrame aAFf.
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
					(dataSeries notNil and: [dataSeries isEmpty not]) 
						ifTrue: 
							[rPfP := (dataSeries at: index) rOfO.
							aAPf := (dataSeries at: index) aAOf].
					rPfO := aAOP timesFullColumn: rPfP.
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
GEOMarker >> dataSeriesForChart1 [
	| rPfP aAPf timeSeries partDataSeries index markerData rOPO aAOP vOPO omeOPO aOPO alpOPO rPfO |
	rPfP := refFrame rFfF.
	aAPf := refFrame aAFf.
	timeSeries := self interface timeSeries.
	^timeSeries notNil
		ifTrue: 
			[partDataSeries := container dataSeries.
			index := 0.
			partDataSeries
				collect: 
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
					rPfO := aAOP timesFullColumn: rPfP.
					markerData rOfO: rOPO + rPfO.
					markerData aAOf: (aAOP timesFullMatrix: aAPf).
					markerData vOfO: vOPO + (omeOPO cross: rPfO).
					markerData omeOfO: omeOPO.
					markerData aOfO: aOPO + (alpOPO cross: rPfO) + (omeOPO cross: (omeOPO cross: rPfO)).
					markerData alpOfO: alpOPO]]
		ifFalse: [Array new]
]

{ #category : #accessing }
GEOMarker >> guideFrame [
	^guideFrame
]

{ #category : #accessing }
GEOMarker >> guideFrame: aFrame [ 
	"Do not initialize body since it complicates postCopy."

	guideFrame := aFrame
]

{ #category : #accessing }
GEOMarker >> inPlaneFrame [
	^guideFrame
]

{ #category : #accessing }
GEOMarker >> magnifySelf: aDouble [ 
	self aRefFrame magnifySelf: aDouble.
	guideFrame ~~ container aRefFrame 
		ifTrue: [guideFrame magnifySelf: aDouble]
]

{ #category : #accessing }
GEOMarker >> newDataSeries [
	"Do nothing."
]

{ #category : #copying }
GEOMarker >> postCopy [
	super postCopy.
	self guideFrame: guideFrame copy.
	self name: container generateUniqueMarkerName.
	container addMarker: self
]

{ #category : #copying }
GEOMarker >> preSave [
	super preSave.
	guideFrame preSave
]

{ #category : #copying }
GEOMarker >> release [
	guideFrame release.
	super release
]

{ #category : #accessing }
GEOMarker >> rpmp [
	| anyPart rPmP rPpP aAPp |
	anyPart := self anyPart.
	rPmP := refFrame rFfF.
	rPpP := anyPart rPcmP.
	aAPp := anyPart aAPp.
	^aAPp transposeTimesFullColumn: (rPmP minusFullColumn: rPpP)
]

{ #category : #printing }
GEOMarker >> storeOn: aStream level: level [ 
	| dummyEndFrame |
	aStream
		storeLevel: level
		title: 'RefPoint'
		object: guideFrame.
	aStream storeLevel: level + 1 title: 'Markers'.
	aStream storeLevel: level + 2 title: 'Marker'.
	aStream
		storeLevel: level + 3
		title: 'Name'
		object: self name.
	dummyEndFrame := GEOCartesianFrame2
				refFrame: nil
				rFfF: (guideFrame rfpffromrOpO: refFrame rOfO)
				aAFf: (guideFrame aAOf transpose timesFullMatrix: refFrame aAOf).
	dummyEndFrame storeOn: aStream level: level + 3
]

{ #category : #accessing }
GEOMarker >> translateBy: shiftXYZ [ 
	refFrame translateBy: shiftXYZ
]

{ #category : #accessing }
GEOMarker >> uncut [
	guideFrame uncut.
	super uncut
]

{ #category : #DYN }
GEOMarker >> updateForFrame: integer [ 
	| dataSeries data |
	dataSeries := self dataSeries.
	(dataSeries notNil and: [dataSeries isEmpty not]) 
		ifTrue: 
			[data := dataSeries at: integer.
			refFrame quietlyrOfO: data rOfO aAOf: data aAOf.
			refFrame quietlyvOfO: data vOfO omeOfO: data omeOfO]
]
