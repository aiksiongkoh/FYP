Class {
	#name : #VertexShellUse,
	#superclass : #ShellUse,
	#category : #'StCAD-NMT-StCAD-NMT-Basic'
}

{ #category : #'VisualWorks metadata' }
VertexShellUse class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
VertexShellUse >> addEdgeUse: aEdgeUse [ 
	self removeShellVertexUse.
	self changeClassToThatOf: ShellUse basicNew.
	^self addEdgeUse: aEdgeUse
]

{ #category : #accessing }
VertexShellUse >> removeShellVertexUse [
	| aShellVertexUse |
	aShellVertexUse := cItemUse first.
	aShellVertexUse die
]
