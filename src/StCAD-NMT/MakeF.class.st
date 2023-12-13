Class {
	#name : #MakeF,
	#superclass : #EulerOperator,
	#instVars : [
		'aRegion',
		'cEdge',
		'newLoop',
		'newFace',
		'newShell',
		'newRegion'
	],
	#category : #'StCAD-NMT-StCAD-NMT-Operator'
}

{ #category : #'instance creation' }
MakeF class >> inRegion: aRegion cEdge: cEdge [ 
	| aMakeF |
	aMakeF := self new.
	aMakeF aRegion: aRegion.
	aMakeF cEdge: cEdge.
	^aMakeF
]

{ #category : #'VisualWorks metadata' }
MakeF class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
MakeF >> aRegion [
	^aRegion
]

{ #category : #accessing }
MakeF >> aRegion: anObject [
	aRegion := anObject
]

{ #category : #accessing }
MakeF >> cEdge [
	^cEdge
]

{ #category : #accessing }
MakeF >> cEdge: anObject [
	cEdge := anObject
]

{ #category : #executing }
MakeF >> execute [

	MakeFU := StCAD_NMT_MakeFU withEdgeUse: self cEdgeUse. "VW_TRANSLATION:StCAD.NMT.MakeFU:StCAD_NMT_MakeFU"
	MakeFU do
]

{ #category : #accessing }
MakeF >> newFace [
	^newFace
]

{ #category : #accessing }
MakeF >> newFace: anObject [
	newFace := anObject
]

{ #category : #accessing }
MakeF >> newLoop [
	^newLoop
]

{ #category : #accessing }
MakeF >> newLoop: anObject [
	newLoop := anObject
]

{ #category : #accessing }
MakeF >> newRegion [
	^newRegion
]

{ #category : #accessing }
MakeF >> newRegion: anObject [
	newRegion := anObject
]

{ #category : #accessing }
MakeF >> newShell [
	^newShell
]

{ #category : #accessing }
MakeF >> newShell: anObject [
	newShell := anObject
]
