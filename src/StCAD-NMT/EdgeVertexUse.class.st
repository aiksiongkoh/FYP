Class {
	#name : #EdgeVertexUse,
	#superclass : #VertexUse,
	#category : #'StCAD-NMT-StCAD-NMT-Basic'
}

{ #category : #'VisualWorks metadata' }
EdgeVertexUse class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
EdgeVertexUse >> isStartOf: aEdge [ 
	^aNMTItem isStartOf: aEdge
]
