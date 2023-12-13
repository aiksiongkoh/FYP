Class {
	#name : #DIRECTION,
	#superclass : #Item,
	#instVars : [
		'direction_ratios'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
DIRECTION class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
DIRECTION >> aDir [
	^direction_ratios
]

{ #category : #accessing }
DIRECTION >> direction_ratios [
	^direction_ratios
]

{ #category : #accessing }
DIRECTION >> direction_ratios: anObject [
	direction_ratios := anObject
]

{ #category : #printing }
DIRECTION >> printVerboseOn: aStream [ 
	aStream print: direction_ratios
]
