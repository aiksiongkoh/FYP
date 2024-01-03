Class {
	#name : #'LENGTH_MEASURE_WITH_UNIT',
	#superclass : #'MEASURE_WITH_UNIT',
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
LENGTH_MEASURE_WITH_UNIT >> angleFactor [

	^nil
]

{ #category : #accessing }
LENGTH_MEASURE_WITH_UNIT >> lengthFactor [
	| unitFactor |
	unitFactor := (unit_component detect: [:aa | aa lengthFactor notNil]) 
				lengthFactor.
	^value_component lengthFactor * unitFactor
]
