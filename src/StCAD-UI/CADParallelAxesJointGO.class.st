Class {
	#name : #CADParallelAxesJointGO,
	#superclass : #CADJointGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #accessing }
CADParallelAxesJointGO class >> geoClass [
	^GEOParallelAxesJoint
]

{ #category : #'VisualWorks metadata' }
CADParallelAxesJointGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #handles }
CADParallelAxesJointGO >> handleLabel [
	^self handleLabel: 'prl'
]
