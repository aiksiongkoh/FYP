Class {
	#name : #'REPRESENTATION_RELATIONSHIP_WITH_TRANSFORMATION',
	#superclass : #'REPRESENTATION_RELATIONSHIP',
	#instVars : [
		'transformation_operator'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
REPRESENTATION_RELATIONSHIP_WITH_TRANSFORMATION class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
REPRESENTATION_RELATIONSHIP_WITH_TRANSFORMATION >> aAFf [
	^transformation_operator aAFf
]

{ #category : #accessing }
REPRESENTATION_RELATIONSHIP_WITH_TRANSFORMATION >> rFfF [
	^transformation_operator rFfF
]

{ #category : #accessing }
REPRESENTATION_RELATIONSHIP_WITH_TRANSFORMATION >> transformation_operator [
	^transformation_operator
]

{ #category : #accessing }
REPRESENTATION_RELATIONSHIP_WITH_TRANSFORMATION >> transformation_operator: anObject [
	transformation_operator := anObject
]
