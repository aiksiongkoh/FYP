Class {
	#name : #'LENGTH_UNIT',
	#superclass : #'NAMED_UNIT',
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
LENGTH_UNIT class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #'As yet unclassified' }
LENGTH_UNIT >> angleFactor [
	^nil
]

{ #category : #accessing }
LENGTH_UNIT >> lengthFactor [
	^dimensions
]
