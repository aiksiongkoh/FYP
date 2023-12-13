Class {
	#name : #'PLANE_ANGLE_MEASURE_WITH_UNIT',
	#superclass : #'MEASURE_WITH_UNIT',
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
PLANE_ANGLE_MEASURE_WITH_UNIT class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #'As yet unclassified' }
PLANE_ANGLE_MEASURE_WITH_UNIT >> angleFactor [
	^value_component angleFactor
]

{ #category : #'As yet unclassified' }
PLANE_ANGLE_MEASURE_WITH_UNIT >> lengthFactor [
	^nil
]
