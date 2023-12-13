Class {
	#name : #MakeE,
	#superclass : #EulerOperator,
	#instVars : [
		'aRegion',
		'aVertex1',
		'aVertex2',
		'aCurve',
		'newEdge'
	],
	#category : #'StCAD-NMT-StCAD-NMT-Operator'
}

{ #category : #'instance creation' }
MakeE class >> inRegion: aRegion fromVertex: aVertex1 toVertex: aVertex2 aCurve: aCurve [ 
	| aShellUse aMakeESub |
	aShellUse := (aRegion selectShellUse: 
					[:aaShellUse | 
					(aaShellUse includesVertex: aVertex1) 
						and: [aaShellUse includesVertex: aVertex2]]) 
				soleItem.
	aMakeESub := aShellUse ifNotNil: [self new] ifNil: [MakeEKillS new].
	aMakeESub aRegion: aRegion.
	aMakeESub aVertex1: aVertex1.
	aMakeESub aVertex2: aVertex2.
	aMakeESub aCurve: aCurve.
	^aMakeESub
]

{ #category : #'VisualWorks metadata' }
MakeE class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
MakeE >> aCurve [
	^aCurve
]

{ #category : #accessing }
MakeE >> aCurve: anObject [
	aCurve := anObject
]

{ #category : #accessing }
MakeE >> aRegion [
	^aRegion
]

{ #category : #accessing }
MakeE >> aRegion: anObject [
	aRegion := anObject
]

{ #category : #accessing }
MakeE >> aVertex [
	^aVertex1
]

{ #category : #accessing }
MakeE >> aVertex1 [
	^aVertex1
]

{ #category : #accessing }
MakeE >> aVertex1: anObject [
	aVertex1 := anObject
]

{ #category : #accessing }
MakeE >> aVertex2 [
	^aVertex2
]

{ #category : #accessing }
MakeE >> aVertex2: anObject [
	aVertex2 := anObject
]

{ #category : #executing }
MakeE >> execute [

	| acVertex |
	newEdge := (aRegion selectEdge: 
					[:aaEdge |
					acVertex := aaEdge cVertex.
					(acVertex includes: aVertex1) and: 
							[(acVertex includes: aVertex2) and: 
									[(aaEdge aCurve equal: aCurve ltol: 1.0d-9)
										or: [aaEdge aCurve equal: aCurve reverse ltol: 1.0d-9]]]])
				soleItem.
	newEdge
		ifNil: 
			[| aModel aShellUse outEdgeUse inEdgeUse |
			aModel := aRegion aModel.
			newEdge := aModel newEdgeWith: aVertex1 and: aVertex2 aCurve: aCurve.
			outEdgeUse := (newEdge newUse)
						aVertexUse: aVertex1 newUse;
						isSameSense: true;
						yourself.
			inEdgeUse := (newEdge newUse)
						aVertexUse: aVertex2 newUse;
						isSameSense: false;
						yourself.
			outEdgeUse mate: inEdgeUse.
			aShellUse := (aRegion selectShellUse: 
							[:aaShellUse |
							(aaShellUse includesVertex: aVertex1)
								and: [aaShellUse includesVertex: aVertex2]])
						soleItem.
			aShellUse addEdgeUse: outEdgeUse.
			aShellUse addEdgeUse: inEdgeUse]
]

{ #category : #accessing }
MakeE >> newEdge [
	^newEdge
]

{ #category : #accessing }
MakeE >> newEdge: anObject [
	newEdge := anObject
]
