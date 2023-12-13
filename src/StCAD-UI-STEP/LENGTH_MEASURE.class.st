Class {
	#name : #'LENGTH_MEASURE',
	#superclass : #'MEASURE_VALUE',
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
LENGTH_MEASURE class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
LENGTH_MEASURE >> lengthFactor [
	^value
]
