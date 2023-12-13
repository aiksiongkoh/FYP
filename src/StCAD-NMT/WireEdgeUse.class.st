Class {
	#name : #WireEdgeUse,
	#superclass : #EdgeUse,
	#category : #'StCAD-NMT-StCAD-NMT-Basic'
}

{ #category : #'VisualWorks metadata' }
WireEdgeUse class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
WireEdgeUse >> aFaceEdgeUse [
	^self
]

{ #category : #testing }
WireEdgeUse >> isWireframe [
	^true
]
