Class {
	#name : #ConcreteNMT,
	#superclass : #AnyNMT,
	#category : #'StCAD-NMT-StCAD-NMT-Basic'
}

{ #category : #'VisualWorks metadata' }
ConcreteNMT class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
ConcreteNMT >> die [
	self removeSup
]
