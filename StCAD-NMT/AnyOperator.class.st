Class {
	#name : #AnyOperator,
	#superclass : #NMTItem,
	#category : #'StCAD-NMT-StCAD-NMT-Operator'
}

{ #category : #'VisualWorks metadata' }
AnyOperator class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #executing }
AnyOperator >> do [
	self preExecute.
	self execute.
	self postExecute
]

{ #category : #executing }
AnyOperator >> postExecute [
	self postcondition ifFalse: [self error: 'Invalid operation']
]

{ #category : #executing }
AnyOperator >> postcondition [
	^true
]

{ #category : #executing }
AnyOperator >> preExecute [
	self precondition ifFalse: [self error: 'Precondition not met']
]

{ #category : #executing }
AnyOperator >> precondition [
	^true
]
