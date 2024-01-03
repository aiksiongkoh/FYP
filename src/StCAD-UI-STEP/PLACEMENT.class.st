Class {
	#name : #PLACEMENT,
	#superclass : #'GEOMETRIC_REPRESENTATION_ITEM',
	#instVars : [
		'location'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
PLACEMENT >> location [
	^location
]

{ #category : #accessing }
PLACEMENT >> location: anObject [
	location := anObject
]

{ #category : #accessing }
PLACEMENT >> rFfF [

	^ location
		  ifNil: [ 
			  StCAD_Math_FullColumn with: 0.0 d with: 0.0 d with: 0.0 d "VW_TRANSLATION:StCAD.Math.FullColumn:StCAD_Math_FullColumn" ]
		  ifNotNil: [ location aPoint ]
]
