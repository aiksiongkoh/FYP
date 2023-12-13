Class {
	#name : #Sketch,
	#superclass : #Plane,
	#instVars : [
		'cGraphic',
		'cSurface'
	],
	#category : #'StCAD-NMT-StCAD-NMT-Basic'
}

{ #category : #'VisualWorks metadata' }
Sketch class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
Sketch >> aLoopUse [

	| aLoop aLoopUse |
	aLoop := StCAD_NMT_Loop new. "VW_TRANSLATION:StCAD.NMT.Loop:StCAD_NMT_Loop"
	aLoopUse := aLoop newUse.
	self cEdgeUse do: [ :aEdgeUse | aLoopUse addEdgeUse: aEdgeUse ].
	^ aLoopUse
]

{ #category : #accessing }
Sketch >> aRectSurface [
	self privateCalcBoundingBox.
	aRectSurface aBoundingBox: aBoundingBox.
	^aRectSurface
]

{ #category : #accessing }
Sketch >> aSketch [
	^self
]

{ #category : #accessing }
Sketch >> aSketchFaceUse [

	"
	This faceuse does not belong to the part model.
	It is just convenient to use it to pass information to the operators to create the part model.
	"

	| aFace aFaceUse |
	aFace := StCAD_NMT_Face new. "VW_TRANSLATION:StCAD.NMT.Face:StCAD_NMT_Face"
	aFaceUse := aFace newUse.
	aFaceUse aSurface: self aRectSurface.
	aFaceUse isSameSense: true.
	self cLoopUse do: [ :aLoopUse | aFaceUse addLoopUse: aLoopUse ].
	^ aFaceUse
]

{ #category : #accessing }
Sketch >> aSketchRefFrame [
	^aRefFrame
]

{ #category : #accessing }
Sketch >> addGraphic: aGraphic [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	aGraphic removeSup.
	super addRefFrame: aGraphic aRefFrame.
	cGraphic add: aGraphic.
	aGraphic aSup: self.
	self calcBoundingBox.
	^aGraphic
]

{ #category : #accessing }
Sketch >> addGraphics: array [ 
	array do: [:graphic | self addGraphic: graphic]
]

{ #category : #accessing }
Sketch >> addSurface: aSurface [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	aSurface removeSup.
	super addRefFrame: aSurface aRefFrame.
	cSurface add: aSurface.
	aSurface aSup: self.
	^aSurface
]

{ #category : #accessing }
Sketch >> asPolylines [
	^cGraphic collect: [:aGraphic | aGraphic asPolyline]
]

{ #category : #accessing }
Sketch >> cEdgeUse [

	| cEdgeUse |
	cEdgeUse := StCAD_Misc_OrderedSet new: 10. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	cGraphic do: [ :aGraphic | cEdgeUse addAll: aGraphic cEdgeUse ].
	^ cEdgeUse
]

{ #category : #calc }
Sketch >> cItemWithBoundingBox [
	^cGraphic ifNil: [OrderedCollection new]
		ifNotNil: 
			[(OrderedCollection new: cGraphic size)
				addAll: cGraphic;
				yourself]
]

{ #category : #accessing }
Sketch >> cLoopUse [

	"Do for single loop for now. Extend to multiple loops later."

	| cLoopUse |
	cLoopUse := StCAD_Misc_OrderedSet new: 3. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	cLoopUse add: self aLoopUse.
	^ cLoopUse
]

{ #category : #'initialize-release' }
Sketch >> initialize [

	super initialize.
	cGraphic := StCAD_Misc_OrderedSet new. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	cSurface := StCAD_Misc_OrderedSet new
]
