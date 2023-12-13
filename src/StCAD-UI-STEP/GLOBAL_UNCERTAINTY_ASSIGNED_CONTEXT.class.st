Class {
	#name : #'GLOBAL_UNCERTAINTY_ASSIGNED_CONTEXT',
	#superclass : #'REPRESENTATION_CONTEXT',
	#instVars : [
		'uncertainty'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
GLOBAL_UNCERTAINTY_ASSIGNED_CONTEXT class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
GLOBAL_UNCERTAINTY_ASSIGNED_CONTEXT >> uncertainty [
	^uncertainty
]

{ #category : #accessing }
GLOBAL_UNCERTAINTY_ASSIGNED_CONTEXT >> uncertainty: anObject [
	uncertainty := anObject
]
