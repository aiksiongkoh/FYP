Class {
	#name : #ForTorActionComp,
	#superclass : #ForTorAction,
	#instVars : [
		'axis'
	],
	#category : #'StCAD-MbD-MbDForce'
}

{ #category : #'VisualWorks metadata' }
ForTorActionComp class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
ForTorActionComp >> axis [
	^axis
]
