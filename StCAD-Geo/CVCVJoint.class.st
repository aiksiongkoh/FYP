Class {
	#name : #CVCVJoint,
	#superclass : #Joint,
	#instVars : [
		'coeffRestitution'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Constraint'
}

{ #category : #'instance creation' }
CVCVJoint class >> faceI: facei faceJ: facej [ 
	^super new faceI: facei faceJ: facej
]

{ #category : #accessing }
CVCVJoint class >> mbdClass [
	^MbDFullySeparatedCVCVJoint
]

{ #category : #accessing }
CVCVJoint class >> nameString [
	^'CurveCurveContact'
]

{ #category : #'VisualWorks metadata' }
CVCVJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #DYN }
CVCVJoint >> canUpdateForFrame: integer [ 
	(super canUpdateForFrame: integer)
		ifFalse: [^false].
	(markerI canUpdateForFrame: integer)
		ifFalse: [^false].
	(markerJ canUpdateForFrame: integer)
		ifFalse: [^false].
	^true
]

{ #category : #accessing }
CVCVJoint >> coeffRestitution [
	^coeffRestitution
]

{ #category : #accessing }
CVCVJoint >> coeffRestitution: double [ 
	coeffRestitution := double
]

{ #category : #DYN }
CVCVJoint >> createMbD [
	| mbdCVCVJoint |
	super createMbD.
	mbdCVCVJoint := self mbdObject.
	mbdCVCVJoint coeffRestitution: coeffRestitution
]

{ #category : #accessing }
CVCVJoint >> cut [
	markerI cut.
	markerJ cut.
	super cut
]

{ #category : #DYN }
CVCVJoint >> dataFromMbD [
	"
	MbD returns aFIeO and aTIeO.
	 needs aFImO and aTImO.
	For CVCV geoIm = mbdIe.
	aFImO := aFIeO.
	aTImO := aTIeO.
	"

	| mbdUnits mbdItem answer aFIeO aTIeO |
	mbdUnits := self mbdUnits.
	mbdItem := self mbdObject.
	answer := DataForceTorque new.
	aFIeO := mbdItem aFX * mbdUnits force.
	aTIeO := mbdItem aTX * mbdUnits torque.
	answer aFIO: aFIeO.
	answer aTIO: aTIeO.
	^answer
]

{ #category : #accessing }
CVCVJoint >> faceI: facei faceJ: facej [ 
	markerI := CurveMarker newOnFace: facei.
	markerJ := CurveMarker newOnFace: facej
]

{ #category : #printing }
CVCVJoint >> storeOn: aStream level: level [ 
	super storeOn: aStream level: level.
	aStream
		storeLevel: level + 1
		title: 'coeffRestitution'
		object: coeffRestitution
]

{ #category : #printing }
CVCVJoint >> storeTimeSeriesOn: aStream [ 
	| dataSeries series |
	super storeTimeSeriesOn: aStream.
	dataSeries := markerI dataSeries.
	series := dataSeries collect: [:data | data s].
	aStream
		storeTitle: 'sI'
		input: 0
		series: (series collect: [:data | data at: 1]).
	series := dataSeries collect: [:data | data sdot].
	aStream
		storeTitle: 'sdotI'
		input: 0
		series: (series collect: [:data | data at: 1]).
	series := dataSeries collect: [:data | data sddot].
	aStream
		storeTitle: 'sddotI'
		input: 0
		series: (series collect: [:data | data at: 1]).
	dataSeries := markerJ dataSeries.
	series := dataSeries collect: [:data | data s].
	aStream
		storeTitle: 'sJ'
		input: 0
		series: (series collect: [:data | data at: 1]).
	series := dataSeries collect: [:data | data sdot].
	aStream
		storeTitle: 'sdotJ'
		input: 0
		series: (series collect: [:data | data at: 1]).
	series := dataSeries collect: [:data | data sddot].
	aStream
		storeTitle: 'sddotJ'
		input: 0
		series: (series collect: [:data | data at: 1])
]

{ #category : #accessing }
CVCVJoint >> uncut [
	markerI uncut.
	markerJ uncut.
	super uncut
]

{ #category : #DYN }
CVCVJoint >> updateForFrame: integer [ 
	super updateForFrame: integer.
	markerI updateForFrame: integer.
	markerJ updateForFrame: integer
]

{ #category : #DYN }
CVCVJoint >> updateFromInitiallyAssembledState [
	super updateFromInitiallyAssembledState.
	markerI updateFromInitiallyAssembledState.
	markerJ updateFromInitiallyAssembledState
]

{ #category : #DYN }
CVCVJoint >> updateFromInputState [
	super updateFromInputState.
	markerI updateFromInputState.
	markerJ updateFromInputState
]

{ #category : #DYN }
CVCVJoint >> updateFromMbD [
	super updateFromMbD.
	markerI updateFromMbD.
	markerJ updateFromMbD
]
