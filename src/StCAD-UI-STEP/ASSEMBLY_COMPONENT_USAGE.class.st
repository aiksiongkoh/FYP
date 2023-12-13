Class {
	#name : #'ASSEMBLY_COMPONENT_USAGE',
	#superclass : #'PRODUCT_DEFINITION_USAGE',
	#instVars : [
		'reference_designator'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
ASSEMBLY_COMPONENT_USAGE class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
ASSEMBLY_COMPONENT_USAGE >> reference_designator [
	^reference_designator
]

{ #category : #accessing }
ASSEMBLY_COMPONENT_USAGE >> reference_designator: anObject [
	reference_designator := anObject
]
