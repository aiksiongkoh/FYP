Class {
	#name : #'TRIMMED_CURVE',
	#superclass : #'BOUNDED_CURVE',
	#instVars : [
		'basis_curve',
		'trim_1',
		'trim_2',
		'sense_agreement',
		'master_representation'
	],
	#category : #'StCAD-UI-STEP'
}

{ #category : #'VisualWorks metadata' }
TRIMMED_CURVE class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
TRIMMED_CURVE >> basis_curve [
	^basis_curve
]

{ #category : #accessing }
TRIMMED_CURVE >> basis_curve: anObject [
	basis_curve := anObject
]

{ #category : #accessing }
TRIMMED_CURVE >> master_representation [
	^master_representation
]

{ #category : #accessing }
TRIMMED_CURVE >> master_representation: anObject [
	master_representation := anObject
]

{ #category : #accessing }
TRIMMED_CURVE >> sense_agreement [
	^sense_agreement
]

{ #category : #accessing }
TRIMMED_CURVE >> sense_agreement: anObject [
	sense_agreement := anObject
]

{ #category : #accessing }
TRIMMED_CURVE >> trim_1 [
	^trim_1
]

{ #category : #accessing }
TRIMMED_CURVE >> trim_1: anObject [
	trim_1 := anObject
]

{ #category : #accessing }
TRIMMED_CURVE >> trim_2 [
	^trim_2
]

{ #category : #accessing }
TRIMMED_CURVE >> trim_2: anObject [
	trim_2 := anObject
]
