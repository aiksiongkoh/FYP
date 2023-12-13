"
RefGeo is for part to store markers for MbD.


"
Class {
	#name : #RefGeo,
	#superclass : #SpatialItem,
	#instVars : [
		'cMarker'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
RefGeo class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
RefGeo >> addMarker: aMarker [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	aMarker removeSup.
	super addRefFrame: aMarker aRefFrame.
	cMarker add: aMarker.
	aMarker aSup: self.
	self calcBoundingBox.
	^aMarker
]

{ #category : #accessing }
RefGeo >> addMarkers: array [ 
	array do: [:marker | self addMarker: marker]
]

{ #category : #calc }
RefGeo >> cItemWithBoundingBox [
	^(OrderedCollection new: cMarker size)
		addAll: cMarker;
		yourself
]

{ #category : #accessing }
RefGeo >> findMarkerNamed: nameComponents [ 
	| cShortenedNameComponent answer |
	self name = (nameComponents at: 1) ifFalse: [^nil].
	cShortenedNameComponent := nameComponents copyFrom: 2
				to: nameComponents size.
	cMarker do: 
			[:aMarker | 
			(answer := aMarker findMarkerNamed: cShortenedNameComponent) 
				ifNotNil: [^answer]].
	^answer
]

{ #category : #accessing }
RefGeo >> findMarkerNamedOld: nameComponents [ 
	| answer |
	cMarker do: 
			[:aMarker | 
			(answer := aMarker findMarkerNamedOld: nameComponents) ifNotNil: [^answer]].
	^answer
]

{ #category : #'initialize-release' }
RefGeo >> initialize [

	super initialize.
	cMarker := StCAD_Misc_OrderedSet new "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
]

{ #category : #accessing }
RefGeo >> markers [
	^cMarker
]
