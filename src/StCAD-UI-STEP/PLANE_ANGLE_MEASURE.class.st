Class {
	#name : #'PLANE_ANGLE_MEASURE',
	#superclass : #'MEASURE_VALUE',
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
PLANE_ANGLE_MEASURE class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #'As yet unclassified' }
PLANE_ANGLE_MEASURE >> angleFactor [
	^value
]
