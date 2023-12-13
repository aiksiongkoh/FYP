Class {
	#name : #MakeEV,
	#superclass : #EulerOperator,
	#instVars : [
		'aRegion',
		'aVertex',
		'aPoint',
		'aCurve',
		'newEdge',
		'newVertex'
	],
	#category : #'StCAD-NMT-StCAD-NMT-Operator'
}

{ #category : #accessing }
MakeEV class >> inRegion: aRegion fromVertex: aVertex toPoint: aPoint aCurve: aCurve [ 
	| aMMakeEV |
	aMMakeEV := self new.
	aMMakeEV aRegion: aRegion.
	aMMakeEV aVertex: aVertex.
	aMMakeEV aPoint: aPoint.
	aMMakeEV aCurve: aCurve.
	^aMMakeEV
]

{ #category : #'VisualWorks metadata' }
MakeEV class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
MakeEV >> aCurve [
	^aCurve
]

{ #category : #accessing }
MakeEV >> aCurve: anObject [
	aCurve := anObject
]

{ #category : #accessing }
MakeEV >> aPoint [
	^aPoint
]

{ #category : #accessing }
MakeEV >> aPoint: anObject [
	aPoint := anObject
]

{ #category : #accessing }
MakeEV >> aRegion [
	^aRegion
]

{ #category : #accessing }
MakeEV >> aRegion: anObject [
	aRegion := anObject
]

{ #category : #accessing }
MakeEV >> aVertex [
	^aVertex
]

{ #category : #accessing }
MakeEV >> aVertex: anObject [
	aVertex := anObject
]

{ #category : #executing }
MakeEV >> execute [

	| aMakeE |
	newVertex := (aRegion selectVertex: [ :aaVertex | 
		              aaVertex aPoint = aPoint ]) soleItem.
	newVertex
		ifNil: [ 
			| aModel aShellUse outEdgeUse inEdgeUse |
			aModel := aRegion aModel.
			newVertex := aModel newVertex: aPoint.
			newEdge := aModel
				           newEdgeWith: aVertex
				           and: newVertex
				           aCurve: aCurve.
			outEdgeUse := newEdge newUse
				              aVertexUse: aVertex newUse;
				              isSameSense: true;
				              yourself.
			inEdgeUse := newEdge newUse
				             aVertexUse: newVertex newUse;
				             isSameSense: false;
				             yourself.
			outEdgeUse mate: inEdgeUse.
			aShellUse := (aRegion selectShellUse: [ :aaShellUse | 
				              aaShellUse includesVertex: aVertex ]) soleItem.
			aShellUse addEdgeUse: outEdgeUse.
			aShellUse addEdgeUse: inEdgeUse ]
		ifNotNil: [ 
			aMakeE := StCAD_NMT_MakeE
				          inRegion: aRegion
				          fromVertex: aVertex
				          toVertex: newVertex
				          aCurve: aCurve. "VW_TRANSLATION:StCAD.NMT.MakeE:StCAD_NMT_MakeE"
			aMakeE do.
			newEdge := aMakeE newEdge ]
]

{ #category : #accessing }
MakeEV >> newEdge [
	^newEdge
]

{ #category : #accessing }
MakeEV >> newEdge: anObject [
	newEdge := anObject
]

{ #category : #accessing }
MakeEV >> newVertex [
	^newVertex
]

{ #category : #accessing }
MakeEV >> newVertex: anObject [
	newVertex := anObject
]
