Class {
	#name : #'DIMENSIONAL_EXPONENTS',
	#superclass : #Item,
	#instVars : [
		'length_exponent',
		'mass_exponent',
		'time_exponent',
		'electric_current_exponent',
		'thermodynamic_temperature_exponent',
		'amount_of_substance_exponent',
		'luminous_intensity_exponent'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #accessing }
DIMENSIONAL_EXPONENTS >> amount_of_substance_exponent [
	^amount_of_substance_exponent
]

{ #category : #accessing }
DIMENSIONAL_EXPONENTS >> amount_of_substance_exponent: anObject [
	amount_of_substance_exponent := anObject
]

{ #category : #accessing }
DIMENSIONAL_EXPONENTS >> angleFactor [

	^nil
]

{ #category : #accessing }
DIMENSIONAL_EXPONENTS >> electric_current_exponent [
	^electric_current_exponent
]

{ #category : #accessing }
DIMENSIONAL_EXPONENTS >> electric_current_exponent: anObject [
	electric_current_exponent := anObject
]

{ #category : #'As yet unclassified' }
DIMENSIONAL_EXPONENTS >> lengthFactor [
	^nil
]

{ #category : #accessing }
DIMENSIONAL_EXPONENTS >> length_exponent [
	^length_exponent
]

{ #category : #accessing }
DIMENSIONAL_EXPONENTS >> length_exponent: anObject [
	length_exponent := anObject
]

{ #category : #accessing }
DIMENSIONAL_EXPONENTS >> luminous_intensity_exponent [
	^luminous_intensity_exponent
]

{ #category : #accessing }
DIMENSIONAL_EXPONENTS >> luminous_intensity_exponent: anObject [
	luminous_intensity_exponent := anObject
]

{ #category : #accessing }
DIMENSIONAL_EXPONENTS >> mass_exponent [
	^mass_exponent
]

{ #category : #accessing }
DIMENSIONAL_EXPONENTS >> mass_exponent: anObject [
	mass_exponent := anObject
]

{ #category : #accessing }
DIMENSIONAL_EXPONENTS >> thermodynamic_temperature_exponent [
	^thermodynamic_temperature_exponent
]

{ #category : #accessing }
DIMENSIONAL_EXPONENTS >> thermodynamic_temperature_exponent: anObject [
	thermodynamic_temperature_exponent := anObject
]

{ #category : #accessing }
DIMENSIONAL_EXPONENTS >> time_exponent [
	^time_exponent
]

{ #category : #accessing }
DIMENSIONAL_EXPONENTS >> time_exponent: anObject [
	time_exponent := anObject
]
