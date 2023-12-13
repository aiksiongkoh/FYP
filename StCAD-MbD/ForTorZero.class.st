Class {
	#name : #ForTorZero,
	#superclass : #ForceTorqueItem,
	#category : #'StCAD-MbD-MbDForce'
}

{ #category : #'VisualWorks metadata' }
ForTorZero class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'input-output' }
ForTorZero >> aFTIeO [
	^(FullColumn zero: 3)
]

{ #category : #'input-output' }
ForTorZero >> calcPostDynCorrectorIteration [
	"Do nothing."
]
