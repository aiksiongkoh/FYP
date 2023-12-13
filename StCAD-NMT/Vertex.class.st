Class {
	#name : #Vertex,
	#superclass : #ManyUseItem,
	#instVars : [
		'aPoint'
	],
	#category : #'StCAD-NMT-StCAD-NMT-Basic'
}

{ #category : #'instance creation' }
Vertex class >> new: aPoint [ 
	| aVertex |
	aVertex := self new.
	aVertex aPoint: aPoint.
	^aVertex
]

{ #category : #'VisualWorks metadata' }
Vertex class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
Vertex >> aPoint [
	^aPoint
]

{ #category : #accessing }
Vertex >> aPoint: anObject [
	aPoint := anObject
]

{ #category : #accessing }
Vertex >> isSpatial [
	^true
]

{ #category : #accessing }
Vertex >> isStartOf: aEdge [ 
	| tol aCurve |
	tol := 1.0d-6 * aPoint length.
	aCurve := aEdge aCurve.
	^(aCurve rFstartF equal: aPoint tol: tol) 
		ifTrue: [true]
		ifFalse: 
			[self assert: [aCurve rFendF equal: aPoint tol: tol].
			false]
]

{ #category : #accessing }
Vertex >> magnifySelf: aDouble [ 
	aPoint magnifySelf: aDouble
]

{ #category : #printing }
Vertex >> printOn: aStream [ 
	aStream nextPutAll: 'aV'.
	aStream print: (self selectVertex: [:item | true]) size.
	aStream nextPutAll: ':VU'.
	aStream print: (self selectVertexUse: [:item | true]) size.
	aStream nextPutAll: ' ('.
	self aPoint do: [:element | element printOn: aStream]
		separatedBy: [aStream space].
	aStream nextPut: $)
]

{ #category : #accessing }
Vertex >> removeSup [
	aSup ifNotNil: [:aaSup | aaSup removeVertex: self]
]

{ #category : #enumerating }
Vertex >> selectVertex: aBlock into: aSet [ 
	(aBlock value: self) ifTrue: [aSet add: self]
]

{ #category : #enumerating }
Vertex >> selectVertexUse: aBlock into: aSet [ 
	cUse do: [:each | each selectVertexUse: aBlock into: aSet]
]

{ #category : #accessing }
Vertex >> useClass [

	^ StCAD_NMT_VertexUse "VW_TRANSLATION:StCAD.NMT.VertexUse:StCAD_NMT_VertexUse"
]
