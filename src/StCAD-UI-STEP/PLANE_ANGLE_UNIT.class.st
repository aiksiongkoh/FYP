Class {
	#name : #'PLANE_ANGLE_UNIT',
	#superclass : #'NAMED_UNIT',
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
PLANE_ANGLE_UNIT class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
PLANE_ANGLE_UNIT >> dimensions [
	^dimensions
]

{ #category : #accessing }
PLANE_ANGLE_UNIT >> dimensions: anObject [
	dimensions := anObject
]

{ #category : #accessing }
PLANE_ANGLE_UNIT >> lengthFactor [
	^nil
]
