Class {
	#name : #CONIC,
	#superclass : #CURVE,
	#instVars : [
		'position'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
CONIC class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
CONIC >> position [
	^position
]

{ #category : #accessing }
CONIC >> position: anObject [
	position := anObject
]
