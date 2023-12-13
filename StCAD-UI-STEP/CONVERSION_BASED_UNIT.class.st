Class {
	#name : #'CONVERSION_BASED_UNIT',
	#superclass : #'NAMED_UNIT',
	#instVars : [
		'conversion_factor'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
CONVERSION_BASED_UNIT class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
CONVERSION_BASED_UNIT >> angleFactor [
	^super angleFactor ifNil: [conversion_factor angleFactor]
]

{ #category : #accessing }
CONVERSION_BASED_UNIT >> conversion_factor [
	^conversion_factor
]

{ #category : #accessing }
CONVERSION_BASED_UNIT >> conversion_factor: anObject [
	conversion_factor := anObject
]

{ #category : #accessing }
CONVERSION_BASED_UNIT >> lengthFactor [
	^super lengthFactor ifNil: [conversion_factor lengthFactor]
]
