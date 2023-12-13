Class {
	#name : #GEORelativeConstraintSet,
	#superclass : #GEOConstraintSet,
	#instVars : [
		'markerI',
		'markerJ'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'instance creation' }
GEORelativeConstraintSet class >> markerI: markeri markerJ: markerj [ 
	^super new markerI: markeri markerJ: markerj
]

{ #category : #'VisualWorks metadata' }
GEORelativeConstraintSet class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
GEORelativeConstraintSet >> aMarkerI [
	^markerI
]

{ #category : #accessing }
GEORelativeConstraintSet >> aMarkerI: markeri [ 
	markerI := markeri
]

{ #category : #accessing }
GEORelativeConstraintSet >> aMarkerJ [
	^markerJ
]

{ #category : #accessing }
GEORelativeConstraintSet >> aMarkerJ: markerj [ 
	markerJ := markerj
]

{ #category : #accessing }
GEORelativeConstraintSet >> addCurrentStateToDataSeries [
	super addCurrentStateToDataSeries.
	markerI addCurrentStateToDataSeries.
	markerJ addCurrentStateToDataSeries
]

{ #category : #accessing }
GEORelativeConstraintSet >> connectorList: collection [ 
	collection add: self
]

{ #category : #DYN }
GEORelativeConstraintSet >> createMbD [
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
GEORelativeConstraintSet >> dataClass [
	^GEOKineIForceIKineJ
]

{ #category : #accessing }
GEORelativeConstraintSet >> dataIntersectLine: geoLine tolerance: tol [ 
	| jointLine answer |
	jointLine := GEOLine start: markerI refFrame rOfO end: markerJ refFrame rOfO.
	jointLine refFrame: self interface worldFrame.
	answer := jointLine dataIntersectLine: geoLine tolerance: tol.
	jointLine release.
	^answer
]

{ #category : #accessing }
GEORelativeConstraintSet >> dataSeriesForChart [
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
GEORelativeConstraintSet >> dataTypes [
	^self dataClass new dataTypes
]

{ #category : #DYN }
GEORelativeConstraintSet >> deleteMbD [
	self mbdObject: nil.
	markerI deleteMbD.
	markerJ deleteMbD
]

{ #category : #testing }
GEORelativeConstraintSet >> isConnectedTo: markerList [ 
	^(markerList includes: markerI)
		or: [markerList includes: markerJ]
]

{ #category : #accessing }
GEORelativeConstraintSet >> markerI: markeri markerJ: markerj [ 
	markerI := markeri.
	markerJ := markerj
]

{ #category : #accessing }
GEORelativeConstraintSet >> newDataSeries [
	super newDataSeries.
	markerI newDataSeries.
	markerJ newDataSeries
]

{ #category : #accessing }
GEORelativeConstraintSet >> positionMemento [

	| aMemento |
	aMemento := Polymorphic_GFMemento originator: self. "VW_TRANSLATION:Polymorphic.GFMemento:Polymorphic_GFMemento"
	aMemento addActionSelector: #yourself arguments: Array new.
	^ aMemento
]

{ #category : #rendering }
GEORelativeConstraintSet >> renderOn: aRenderingContext [

	aRenderingContext lineWidth: 1.
	aRenderingContext paint: Polymorphic_Color black. "VW_TRANSLATION:Polymorphic.Color:Polymorphic_Color"
	aRenderingContext displayLine:
		(Array with: markerI rOfO with: markerJ rOfO)
]

{ #category : #DYN }
GEORelativeConstraintSet >> storeInputState [
	markerI storeInputState.
	markerJ storeInputState
]

{ #category : #printing }
GEORelativeConstraintSet >> storeOn: aStream level: level [ 
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
GEORelativeConstraintSet >> storePOVOn: aStream level: level [ 
	aStream storePOVLevel: level
		title: ('// <1s>' expandMacrosWith: self fullNamePOV)
]

{ #category : #printing }
GEORelativeConstraintSet >> storePOVTimeSeriesOn: aStream [ 
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
GEORelativeConstraintSet >> storePOVdatCurrentOn: aStream [ 
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
GEORelativeConstraintSet >> storeTimeSeriesOn: aStream [ 
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
