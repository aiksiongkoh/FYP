Class {
	#name : #'BREP_WITH_VOIDS',
	#superclass : #'MANIFOLD_SOLID_BREP',
	#instVars : [
		'voids'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
BREP_WITH_VOIDS class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
BREP_WITH_VOIDS >> voids [
	^voids
]

{ #category : #accessing }
BREP_WITH_VOIDS >> voids: anObject [
	voids := anObject
]
