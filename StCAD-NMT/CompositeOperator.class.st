Class {
	#name : #CompositeOperator,
	#superclass : #AnyOperator,
	#instVars : [
		'cOperator'
	],
	#category : #'StCAD-NMT-StCAD-NMT-Operator'
}

{ #category : #'VisualWorks metadata' }
CompositeOperator class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #'initialize-release' }
CompositeOperator >> initialize [
	cOperator := OrderedCollection new
]
