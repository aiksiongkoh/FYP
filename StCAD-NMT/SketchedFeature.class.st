Class {
	#name : #SketchedFeature,
	#superclass : #Feature,
	#instVars : [
		'aSketch',
		'aModel'
	],
	#category : #'StCAD-NMT-StCAD-NMT-Basic'
}

{ #category : #'VisualWorks metadata' }
SketchedFeature class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
SketchedFeature >> aModel [
	^aModel ifNil: 
			[self createModel.
			aModel]
]

{ #category : #accessing }
SketchedFeature >> aModel: argModel [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	argModel removeSup.
	aModel := argModel.
	argModel aSup: self.
	^argModel
]

{ #category : #accessing }
SketchedFeature >> aRefFrame [
	^aSketch aRefFrame
]

{ #category : #accessing }
SketchedFeature >> aSketch [
	^aSketch
]

{ #category : #accessing }
SketchedFeature >> aSketch: argSketch [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	argSketch removeSup.
	aSketch := argSketch.
	argSketch aSup: self.
	^argSketch
]
