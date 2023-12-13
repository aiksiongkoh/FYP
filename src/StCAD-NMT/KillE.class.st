Class {
	#name : #KillE,
	#superclass : #EulerOperator,
	#instVars : [
		'aEdge'
	],
	#category : #'StCAD-NMT-StCAD-NMT-Operator'
}

{ #category : #'VisualWorks metadata' }
KillE class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
KillE >> aEdge [
	^aEdge
]

{ #category : #accessing }
KillE >> aEdge: anObject [
	aEdge := anObject
]
