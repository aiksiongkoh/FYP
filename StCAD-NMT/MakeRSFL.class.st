Class {
	#name : #MakeRSFL,
	#superclass : #EulerOperator,
	#instVars : [
		'aRegion',
		'aVertex',
		'newRegion',
		'newShell',
		'newFace',
		'newLoop'
	],
	#category : #'StCAD-NMT-StCAD-NMT-Operator'
}

{ #category : #'instance creation' }
MakeRSFL class >> inRegion: aRegion aVertex: aVertex [ 
	| aMakeRSFL |
	aMakeRSFL := self new.
	aMakeRSFL aRegion: aRegion.
	aMakeRSFL aVertex: aVertex.
	^aMakeRSFL
]

{ #category : #'VisualWorks metadata' }
MakeRSFL class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
MakeRSFL >> aRegion [
	^aRegion
]

{ #category : #accessing }
MakeRSFL >> aRegion: anObject [
	aRegion := anObject
]

{ #category : #accessing }
MakeRSFL >> aVertex [
	^aVertex
]

{ #category : #accessing }
MakeRSFL >> aVertex: anObject [
	aVertex := anObject
]

{ #category : #executing }
MakeRSFL >> execute [
	| aModel aShellUse aVertexUse newFaceUse1 newLoopUse1 newShellUse newFaceUse2 newLoopUse2 newVertexUse |
	aModel := aRegion aModel.
	aShellUse := (aRegion 
				selectShellUse: [:aaShellUse | aaShellUse includesVertex: aVertex]) 
					soleItem.
	aVertexUse := (aShellUse 
				selectVertexUse: [:aaVertexUse | aaVertexUse aNMTItem == aVertex]) soleItem.
	newFace := aModel newFace.	"Positive face point outside."
	newFaceUse1 := newFace newUse.
	aShellUse addFaceUse: newFaceUse1.
	newLoop := aModel newLoop.
	newLoopUse1 := newLoop newUse.
	newFaceUse1 addLoopUse: newLoopUse1.
	newLoopUse1 addVertexUse: aVertexUse.
	newRegion := aModel newRegion.	"Inside region."
	newShell := aModel newShell.
	newShellUse := newShell newUse.
	newRegion addShellUse: newShellUse.
	newFaceUse2 := newFace newUse.
	newShellUse addFaceUse: newFaceUse2.
	newLoopUse2 := newLoop newUse.
	newFaceUse2 addLoopUse: newLoopUse2.
	newVertexUse := aVertex newUse.
	newLoopUse2 addVertexUse: newVertexUse.
	newFaceUse1 mate: newFaceUse2.
	newLoopUse1 mate: newLoopUse2
]

{ #category : #accessing }
MakeRSFL >> newEdge [
	^nil
]

{ #category : #accessing }
MakeRSFL >> newFace [
	^newFace
]

{ #category : #accessing }
MakeRSFL >> newLoop [
	^newLoop
]

{ #category : #accessing }
MakeRSFL >> newRegion [
	^newRegion
]

{ #category : #accessing }
MakeRSFL >> newShell [
	^newShell
]
