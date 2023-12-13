Class {
	#name : #GEOCVCVJoint,
	#superclass : #GEOJoint,
	#instVars : [
		'coeffRestitution'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'instance creation' }
GEOCVCVJoint class >> faceI: facei faceJ: facej [ 
	^super new faceI: facei faceJ: facej
]

{ #category : #accessing }
GEOCVCVJoint class >> mbdClass [
	^MbDFullySeparatedCVCVJoint
]

{ #category : #accessing }
GEOCVCVJoint class >> nameString [
	^'CurveCurveContact'
]

{ #category : #'VisualWorks metadata' }
GEOCVCVJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #DYN }
GEOCVCVJoint >> canUpdateForFrame: integer [ 
	(super canUpdateForFrame: integer)
		ifFalse: [^false].
	(markerI canUpdateForFrame: integer)
		ifFalse: [^false].
	(markerJ canUpdateForFrame: integer)
		ifFalse: [^false].
	^true
]

{ #category : #accessing }
GEOCVCVJoint >> coeffRestitution [
	^coeffRestitution
]

{ #category : #accessing }
GEOCVCVJoint >> coeffRestitution: double [ 
	coeffRestitution := double
]

{ #category : #DYN }
GEOCVCVJoint >> createMbD [
	| mbdCVCVJoint |
	super createMbD.
	mbdCVCVJoint := self mbdObject.
	mbdCVCVJoint coeffRestitution: coeffRestitution
]

{ #category : #accessing }
GEOCVCVJoint >> cut [
	markerI cut.
	markerJ cut.
	super cut
]

{ #category : #DYN }
GEOCVCVJoint >> dataFromMbD [
	"
	MbD returns aFIeO and aTIeO.
	GEO needs aFImO and aTImO.
	For CVCV geoIm = mbdIe.
	aFImO := aFIeO.
	aTImO := aTIeO.
	"

	| mbdUnits mbdItem answer aFIeO aTIeO |
	mbdUnits := self mbdUnits.
	mbdItem := self mbdObject.
	answer := GEOForceTorqueData new.
	aFIeO := mbdItem aFX * mbdUnits force.
	aTIeO := mbdItem aTX * mbdUnits torque.
	answer aFIO: aFIeO.
	answer aTIO: aTIeO.
	^answer
]

{ #category : #accessing }
GEOCVCVJoint >> faceI: facei faceJ: facej [ 
	markerI := GEOCurveMarker newOnFace: facei.
	markerJ := GEOCurveMarker newOnFace: facej
]

{ #category : #printing }
GEOCVCVJoint >> storeOn: aStream level: level [ 
	super storeOn: aStream level: level.
	aStream
		storeLevel: level + 1
		title: 'coeffRestitution'
		object: coeffRestitution
]

{ #category : #printing }
GEOCVCVJoint >> storeTimeSeriesOn: aStream [ 
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
GEOCVCVJoint >> uncut [
	markerI uncut.
	markerJ uncut.
	super uncut
]

{ #category : #DYN }
GEOCVCVJoint >> updateForFrame: integer [ 
	super updateForFrame: integer.
	markerI updateForFrame: integer.
	markerJ updateForFrame: integer
]

{ #category : #DYN }
GEOCVCVJoint >> updateFromInitiallyAssembledState [
	super updateFromInitiallyAssembledState.
	markerI updateFromInitiallyAssembledState.
	markerJ updateFromInitiallyAssembledState
]

{ #category : #DYN }
GEOCVCVJoint >> updateFromInputState [
	super updateFromInputState.
	markerI updateFromInputState.
	markerJ updateFromInputState
]

{ #category : #DYN }
GEOCVCVJoint >> updateFromMbD [
	super updateFromMbD.
	markerI updateFromMbD.
	markerJ updateFromMbD
]
