Class {
	#name : #RelativeConstraintSet,
	#superclass : #RelativeConstraint,
	#instVars : [
		'constraints'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Constraint'
}

{ #category : #'instance creation' }
RelativeConstraintSet class >> aEndI: aEndi aEndJ: aEndj [ 
	^super new aEndI: aEndi aEndJ: aEndj
]

{ #category : #'instance creation' }
RelativeConstraintSet class >> markerI: markeri markerJ: markerj [ 
	^super new markerI: markeri markerJ: markerj
]

{ #category : #'VisualWorks metadata' }
RelativeConstraintSet class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
RelativeConstraintSet >> aEndI: aEndi aEndJ: aEndj [ 
	markerI := aEndi.
	markerJ := aEndj
]

{ #category : #accessing }
RelativeConstraintSet >> aMarkerI [
	^markerI
]

{ #category : #accessing }
RelativeConstraintSet >> aMarkerI: markeri [ 
	markerI := markeri
]

{ #category : #accessing }
RelativeConstraintSet >> aMarkerJ [
	^markerJ
]

{ #category : #accessing }
RelativeConstraintSet >> aMarkerJ: markerj [ 
	markerJ := markerj
]

{ #category : #accessing }
RelativeConstraintSet >> addCurrentStateToDataSeries [
	super addCurrentStateToDataSeries.
	markerI addCurrentStateToDataSeries.
	markerJ addCurrentStateToDataSeries
]

{ #category : #accessing }
RelativeConstraintSet >> connectorList: collection [ 
	collection add: self
]

{ #category : #DYN }
RelativeConstraintSet >> createMbD [
	| oodsJt |
	self dataSeries: OrderedCollection new.
	self discontinuities: OrderedCollection new.
	oodsJt := self mbdClass new.
	oodsJt name: self fullName.
	oodsJt connectsI: markerI mbdObject toJ: markerJ mbdObject.
	oodsJt submitToSystem.
	self mbdObject: oodsJt
]

{ #category : #accessing }
RelativeConstraintSet >> dataClass [
	^GEOKineIForceIKineJ.
]

{ #category : #accessing }
RelativeConstraintSet >> dataIntersectLine: geoLine tolerance: tol [ 
	| jointLine answer |
	jointLine := Line start: markerI refFrame rOfO end: markerJ refFrame rOfO.
	jointLine refFrame: self interface worldFrame.
	answer := jointLine dataIntersectLine: geoLine tolerance: tol.
	jointLine release.
	^answer
]

{ #category : #accessing }
RelativeConstraintSet >> dataSeriesForChart [
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
RelativeConstraintSet >> dataTypes [
	^self dataClass new dataTypes
]

{ #category : #DYN }
RelativeConstraintSet >> deleteMbD [
	self mbdObject: nil.
	markerI deleteMbD.
	markerJ deleteMbD
]

{ #category : #testing }
RelativeConstraintSet >> isConnectedTo: markerList [ 
	^(markerList includes: markerI)
		or: [markerList includes: markerJ]
]

{ #category : #accessing }
RelativeConstraintSet >> markerI: markeri markerJ: markerj [ 
	markerI := markeri.
	markerJ := markerj
]

{ #category : #accessing }
RelativeConstraintSet >> newDataSeries [
	super newDataSeries.
	markerI newDataSeries.
	markerJ newDataSeries
]

{ #category : #accessing }
RelativeConstraintSet >> positionMemento [

	| aMemento |
	aMemento := Polymorphic_GFMemento originator: self. "VW_TRANSLATION:Polymorphic.GFMemento:Polymorphic_GFMemento"
	aMemento addActionSelector: #yourself arguments: Array new.
	^ aMemento
]

{ #category : #DYN }
RelativeConstraintSet >> storeInputState [
	markerI storeInputState.
	markerJ storeInputState
]

{ #category : #printing }
RelativeConstraintSet >> storeOn: aStream level: level [ 
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
RelativeConstraintSet >> storePOVOn: aStream level: level [ 
	aStream storePOVLevel: level
		title: ('// <1s>' expandMacrosWith: self fullNamePOV)
]

{ #category : #printing }
RelativeConstraintSet >> storePOVTimeSeriesOn: aStream [ 
	| dataSeries fullNamePOV series |
	dataSeries := self dataSeries.
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
RelativeConstraintSet >> storePOVdatCurrentOn: aStream [ 
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
RelativeConstraintSet >> storeTimeSeriesOn: aStream [ 
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
