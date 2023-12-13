Class {
	#name : #'SHAPE_DEFINITION_REPRESENTATION',
	#superclass : #'PROPERTY_DEFINITION_REPRESENTATION',
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
SHAPE_DEFINITION_REPRESENTATION class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
SHAPE_DEFINITION_REPRESENTATION >> aPart [
	^used_representation aPart
]

{ #category : #accessing }
SHAPE_DEFINITION_REPRESENTATION >> cPart [
	^used_representation cPart
]
