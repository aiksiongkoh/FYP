Class {
	#name : #GEOForceTorqueItem,
	#superclass : #GEOContainedItem,
	#instVars : [
		'markerI',
		'markerJ'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOForceTorqueItem >> aMarkerI [
	^markerI
]

{ #category : #accessing }
GEOForceTorqueItem >> aMarkerI: markeri [ 
	markerI := markeri
]

{ #category : #accessing }
GEOForceTorqueItem >> aMarkerJ [
	^markerJ
]

{ #category : #accessing }
GEOForceTorqueItem >> aMarkerJ: markerj [ 
	markerJ := markerj
]

{ #category : #DYN }
GEOForceTorqueItem >> canUpdateForFrame: integer [ 
	^true
]

{ #category : #accessing }
GEOForceTorqueItem >> connectorList: collection [ 
	collection add: self
]

{ #category : #DYN }
GEOForceTorqueItem >> createMbD [
	self dataSeries: OrderedCollection new.
	self discontinuities: OrderedCollection new
]

{ #category : #accessing }
GEOForceTorqueItem >> dataClass [
	^GEOKineIForceIKineJ
]

{ #category : #DYN }
GEOForceTorqueItem >> dataFromCurrentState [
	| answer |
	answer := GEOForceTorqueData new.
	answer aFIO: (FullColumn zero: 3).
	answer aTIO: (FullColumn zero: 3).
	^answer
]

{ #category : #DYN }
GEOForceTorqueItem >> dataFromMbD [
	| mbdUnits mbdItem answer |
	mbdUnits := self mbdUnits.
	mbdItem := self mbdObject.
	answer := GEOForceTorqueData new.
	answer aFIO: mbdItem aFX * mbdUnits force.
	answer aTIO: mbdItem aTX * mbdUnits torque.
	^answer
]

{ #category : #DYN }
GEOForceTorqueItem >> dataIntersectLine: geoLine tolerance: tol [ 
	| forceLine answer |
	forceLine := GEOLine start: markerI refFrame rOfO end: markerJ refFrame rOfO.
	forceLine refFrame: self interface worldFrame.
	answer := forceLine dataIntersectLine: geoLine tolerance: tol.
	forceLine release.
	^answer
]

{ #category : #accessing }
GEOForceTorqueItem >> dataSeriesForChart [
	| kineIs kineJs forceIs index kineIforceIkineJ |
	kineIs := markerI dataSeriesForChart.
	kineJs := markerJ dataSeriesForChart.
	forceIs := self dataSeries.
	^(kineIs isSequenceable and: [kineJs isSequenceable and: [forceIs isSequenceable]])
		ifTrue: 
			[index := 0.
			kineIs
				collect: 
					[:kineI | 
					index := index + 1.
					kineIforceIkineJ := self dataClass new.
					kineIforceIkineJ kineI: (kineIs at: index).
					kineIforceIkineJ forceI: (forceIs at: index).
					kineIforceIkineJ kineJ: (kineJs at: index).
					kineIforceIkineJ]]
		ifFalse: 
			[Dialog warn: 'Simulation data is incomplete. Rerun a simulation.'.
			Array new]
]

{ #category : #accessing }
GEOForceTorqueItem >> dataTypes [
	^self dataClass new dataTypes
]

{ #category : #DYN }
GEOForceTorqueItem >> deleteMbD [
	self mbdObject: nil.
	markerI deleteMbD.
	markerJ deleteMbD
]

{ #category : #accessing }
GEOForceTorqueItem >> functionParser [
	| parser |
	parser := ForceFunctionParser new.
	parser container: self.
	parser initVariables.
	parser initgeoIJs.
	^parser
]

{ #category : #testing }
GEOForceTorqueItem >> isConnectedTo: markerList [ 
	^(markerList includes: markerI)
		or: [markerList includes: markerJ]
]

{ #category : #accessing }
GEOForceTorqueItem >> markerI: markeri markerJ: markerj [ 
	markerI := markeri.
	markerJ := markerj
]

{ #category : #rendering }
GEOForceTorqueItem >> renderOn: aRenderingContext [

	aRenderingContext lineWidth: 2.
	aRenderingContext paint: Polymorphic_Color black. "VW_TRANSLATION:Polymorphic.Color:Polymorphic_Color"
	aRenderingContext displayLine:
		(Array with: markerI rOfO with: markerJ rOfO)
]

{ #category : #DYN }
GEOForceTorqueItem >> storeInputFromMbD [
	"Do nothing."
]

{ #category : #DYN }
GEOForceTorqueItem >> storeInputState [
	"Do nothing."
]

{ #category : #printing }
GEOForceTorqueItem >> storeOn: aStream level: level [ 
	aStream storeLevel: level title: self nameString.
	aStream
		storeLevel: level + 1
		title: 'Name'
		object: self name.
	aStream
		storeLevel: level + 1
		title: 'MarkerI'
		object: markerI fullName.
	aStream
		storeLevel: level + 1
		title: 'MarkerJ'
		object: markerJ fullName
]

{ #category : #printing }
GEOForceTorqueItem >> storePOVOn: aStream level: level [ 
	aStream storePOVLevel: level
		title: ('// <1s>' expandMacrosWith: self fullNamePOV)
]

{ #category : #printing }
GEOForceTorqueItem >> storePOVTimeSeriesOn: aStream [ 
	| dataSeries fullNamePOV series |
	dataSeries := self dataSeries.
	fullNamePOV := self fullNamePOV.
	series := dataSeries collect: [:data | data aFIO].
	aStream storePOVTitle: fullNamePOV , '_FXonI'
		series: (series collect: [:data | (data at: 1) ]).
	aStream storePOVTitle: fullNamePOV , '_FYonI'
		series: (series collect: [:data | (data at: 2) ]).
	aStream storePOVTitle: fullNamePOV , '_FZonI'
		series: (series collect: [:data | (data at: 3) ]).
	series := dataSeries collect: [:data | data aTIO].
	aStream storePOVTitle: fullNamePOV , '_TXonI'
		series: (series collect: [:data | (data at: 1) ]).
	aStream storePOVTitle: fullNamePOV , '_TYonI'
		series: (series collect: [:data | (data at: 2) ]).
	aStream storePOVTitle: fullNamePOV , '_TZonI'
		series: (series collect: [:data | (data at: 3) ])
]

{ #category : #printing }
GEOForceTorqueItem >> storePOVdatCurrentOn: aStream [ 
	| dataSeries fullNamePOV series |
	dataSeries := Array with: self dataFromCurrentState.
	fullNamePOV := self fullNamePOV.
	series := dataSeries collect: [:data | data aFIO].
	aStream storePOVTitle: fullNamePOV , '_FXonI'
		series: (series collect: [:data | data at: 1]).
	aStream storePOVTitle: fullNamePOV , '_FYonI'
		series: (series collect: [:data | data at: 2]).
	aStream storePOVTitle: fullNamePOV , '_FZonI'
		series: (series collect: [:data | data at: 3]).
	series := dataSeries collect: [:data | data aTIO].
	aStream storePOVTitle: fullNamePOV , '_TXonI'
		series: (series collect: [:data | data at: 1]).
	aStream storePOVTitle: fullNamePOV , '_TYonI'
		series: (series collect: [:data | data at: 2]).
	aStream storePOVTitle: fullNamePOV , '_TZonI'
		series: (series collect: [:data | data at: 3])
]

{ #category : #printing }
GEOForceTorqueItem >> storeTimeSeriesOn: aStream [ 
	| dataSeries series |
	aStream nextPutAll: self nameString; nextPutAll: 'Series'; space; nextPutAll: self fullName; cr.
	dataSeries := self dataSeries.
	series := dataSeries collect: [:data | data aFIO].
	aStream
		storeTitle: 'FXonI'
		input: 0
		series: (series collect: [:data | data at: 1]).
	aStream
		storeTitle: 'FYonI'
		input: 0
		series: (series collect: [:data | data at: 2]).
	aStream
		storeTitle: 'FZonI'
		input: 0
		series: (series collect: [:data | data at: 3]).
	series := dataSeries collect: [:data | data aTIO].
	aStream
		storeTitle: 'TXonI'
		input: 0
		series: (series collect: [:data | data at: 1]).
	aStream
		storeTitle: 'TYonI'
		input: 0
		series: (series collect: [:data | data at: 2]).
	aStream
		storeTitle: 'TZonI'
		input: 0
		series: (series collect: [:data | data at: 3])
]

{ #category : #DYN }
GEOForceTorqueItem >> updateForFrame1: integer [ 
	"Do nothing."
]

{ #category : #DYN }
GEOForceTorqueItem >> updateForFrame: integer [ 
	"Do nothing."
]

{ #category : #DYN }
GEOForceTorqueItem >> updateFromInitiallyAssembledState [
	"Do nothing."
]

{ #category : #DYN }
GEOForceTorqueItem >> updateFromInputState [
	"Do nothing."
]

{ #category : #DYN }
GEOForceTorqueItem >> updateFromMbD [
	| data |
	data := self dataFromMbD.
	self dataSeries add: data
]
