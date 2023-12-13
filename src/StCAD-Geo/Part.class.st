Class {
	#name : #Part,
	#superclass : #AnyPart,
	#instVars : [
		'aMassMarker',
		'cMarker',
		'aNMT'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
Part class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
Part >> aMassMarker [
	^aMassMarker
]

{ #category : #accessing }
Part >> aMassMarker: argMassMarker [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	argMassMarker removeSup.
	super addRefFrame: argMassMarker aRefFrame.
	aMassMarker := argMassMarker.
	argMassMarker aSup: self.
	self calcBoundingBox.
	^argMassMarker
]

{ #category : #accessing }
Part >> aNMT: argNMT [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	argNMT removeSup.
	aNMT := argNMT.
	argNMT aSup: self.
	^argNMT
]

{ #category : #accessing }
Part >> addFeature: aFeature [ 
	aNMT addFeature: aFeature
]

{ #category : #accessing }
Part >> addFeatureOrder: cFeature [ 
	cFeature do: [:aFeature | aNMT addFeature: aFeature]
]

{ #category : #accessing }
Part >> addRefCurve: aRefCurve [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	aRefCurve removeSup.
	super addRefFrame: aRefCurve aRefFrame.
	cMarker add: aRefCurve.
	aRefCurve aSup: self.
	self calcBoundingBox.
	^aRefCurve
]

{ #category : #accessing }
Part >> addRefCurves: cRefCurve [ 
	cRefCurve do: [:aRefCurve | self addRefCurve: aRefCurve]
]

{ #category : #accessing }
Part >> addRefPoint: aRefPoint [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	aRefPoint removeSup.
	super addRefFrame: aRefPoint aRefFrame.
	cMarker add: aRefPoint.
	aRefPoint aSup: self.
	self calcBoundingBox.
	^aRefPoint
]

{ #category : #accessing }
Part >> addRefPoints: cRefPoint [ 
	cRefPoint do: [:aRefPoint | self addRefPoint: aRefPoint]
]

{ #category : #accessing }
Part >> addRefSurface: aRefSurface [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	aRefSurface removeSup.
	super addRefFrame: aRefSurface aRefFrame.
	cMarker add: aRefSurface.
	aRefSurface aSup: self.
	self calcBoundingBox.
	^aRefSurface
]

{ #category : #accessing }
Part >> addRefSurfaces: cRefSurface [ 
	cRefSurface do: [:aRefSurface | self addRefSurface: aRefSurface]
]

{ #category : #accessing }
Part >> asTreeNode [
	^(super asTreeNode)
		addCollection: aNMT cFeature name: 'Features';
		addCollection: cMarker name: 'Markers';
		addChild: aMassMarker;
		yourself
]

{ #category : #calc }
Part >> cItemWithBoundingBox [
	^(OrderedCollection new: 1 + cMarker size + 1)
		add: aMassMarker;
		addAll: cMarker;
		add: aNMT;
		yourself
]

{ #category : #accessing }
Part >> findMarkerNamed: nameComponents [ 
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
Part >> findMarkerNamedOld: nameComponents [ 
	| cShortenedNameComponent answer |
	self name = (nameComponents at: 1) ifFalse: [^nil].
	cShortenedNameComponent := nameComponents copyFrom: 2
				to: nameComponents size.
	cMarker do: 
			[:aMarker | 
			(answer := aMarker findMarkerNamedOld: cShortenedNameComponent) 
				ifNotNil: [^answer]].
	^answer
]

{ #category : #'initialize-release' }
Part >> initialize [

	super initialize.
	cMarker := StCAD_Misc_OrderedSet new. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	self aNMT: StCAD_NMT_Model new "VW_TRANSLATION:StCAD.NMT.Model:StCAD_NMT_Model"
]

{ #category : #NMT }
Part >> privateBuildSolidModel [
	aNMT privateBuildSolidModel
]

{ #category : #accessing }
Part >> removeSup [
	aSup ifNotNil: [:aaSup | aaSup removePart: self]
]

{ #category : #displaying }
Part >> renderOn: aRenderingContext [ 
	aRenderingContext 
		pushName: self name
		transformation: aRefFrame aMFf
		while: [aNMT renderOn: aRenderingContext]
]
