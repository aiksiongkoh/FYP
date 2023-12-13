Class {
	#name : #ForTorActReactComp,
	#superclass : #ForTorActReact,
	#category : #'StCAD-MbD-MbDForce'
}

{ #category : #'VisualWorks metadata' }
ForTorActReactComp class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
ForTorActReactComp >> axis [
	^forTorAction axis
]
