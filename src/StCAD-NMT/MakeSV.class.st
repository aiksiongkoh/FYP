Class {
	#name : #MakeSV,
	#superclass : #EulerOperator,
	#instVars : [
		'aRegion',
		'aPoint',
		'newShell',
		'newVertex'
	],
	#category : #'StCAD-NMT-StCAD-NMT-Operator'
}

{ #category : #'instance creation' }
MakeSV class >> inRegion: aRegion aPoint: aPoint [ 
	| aMakeSV |
	aMakeSV := self new.
	aMakeSV aRegion: aRegion.
	aMakeSV aPoint: aPoint.
	^aMakeSV
]

{ #category : #'VisualWorks metadata' }
MakeSV class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
MakeSV >> aPoint [
	^aPoint
]

{ #category : #accessing }
MakeSV >> aPoint: anObject [
	aPoint := anObject
]

{ #category : #accessing }
MakeSV >> aRegion [
	^aRegion
]

{ #category : #accessing }
MakeSV >> aRegion: anObject [
	aRegion := anObject
]

{ #category : #executing }
MakeSV >> execute [
	newVertex := (aRegion selectVertex: [:aVertex | aVertex aPoint = aPoint]) 
				soleItem.
	newVertex ifNil: 
			[| aModel newShellUse |
			aModel := aRegion aModel.
			newShell := aModel newShell.
			newShellUse := newShell newUse.
			newShellUse changeClassToThatOf: VertexShellUse basicNew.
			aRegion addShellUse: newShellUse.
			newVertex := aModel newVertex: aPoint.
			newShellUse addVertexUse: newVertex newUse]
		ifNotNil: 
			[newShell := (aRegion 
						selectShellUse: [:aShellUse | aShellUse includesVertex: newVertex]) 
							soleItem aNMTItem]
]

{ #category : #accessing }
MakeSV >> newShell [
	^newShell
]

{ #category : #accessing }
MakeSV >> newShell: anObject [
	newShell := anObject
]

{ #category : #accessing }
MakeSV >> newVertex [
	^newVertex
]

{ #category : #accessing }
MakeSV >> newVertex: anObject [
	newVertex := anObject
]
