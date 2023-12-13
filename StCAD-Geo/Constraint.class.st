Class {
	#name : #Constraint,
	#superclass : #SubItem,
	#instVars : [
		'name'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Constraint'
}

{ #category : #'VisualWorks metadata' }
Constraint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
	)

]

{ #category : #DYN }
Constraint >> canUpdateForFrame: integer [ 
	^true
]

{ #category : #DYN }
Constraint >> dataFromCurrentState [
	| answer |
	answer := DataForceTorque new.
	answer aFIO: (FullColumn zero: 3).
	answer aTIO: (FullColumn zero: 3).
	^answer
]

{ #category : #DYN }
Constraint >> dataFromMbD [
	"
	MbD returns aFIeO and aTIeO.
	 needs aFImO and aTImO.
	For Motion rImIeO is not zero and is changing.
	aFImO := aFIeO.
	aTImO := aTIeO + (rImIeO cross: aFIeO).
	"

	| mbdUnits mbdItem answer aFIeO aTIeO rImIeO |
	mbdUnits := self mbdUnits.
	mbdItem := self mbdObject.
	answer := DataForceTorque new.
	aFIeO := mbdItem aFX * mbdUnits force.
	aTIeO := mbdItem aTX * mbdUnits torque.
	rImIeO := mbdItem frmI rmeO * mbdUnits length.
	answer aFIO: aFIeO.
	answer aTIO: aTIeO + (rImIeO cross: aFIeO).
	^answer
]

{ #category : #accessing }
Constraint >> name [
	^name
]

{ #category : #accessing }
Constraint >> name: anObject [ 
	name := anObject asSymbol
]

{ #category : #DYN }
Constraint >> storeInputFromMbD [
	"Do nothing."
]

{ #category : #DYN }
Constraint >> storeInputState [
	"Do nothing."
]

{ #category : #DYN }
Constraint >> updateForFrame1: integer [ 
	"Do nothing."
]

{ #category : #DYN }
Constraint >> updateForFrame: integer [ 
	"Do nothing."
]

{ #category : #DYN }
Constraint >> updateFromInitiallyAssembledState [
	"Do nothing."
]

{ #category : #DYN }
Constraint >> updateFromInputState [
	"Do nothing."
]

{ #category : #DYN }
Constraint >> updateFromMbD [
	| data |
	data := self dataFromMbD.
	self dataSeries add: data
]

{ #category : #DYN }
Constraint >> validateFormulas [
	"Do nothing."
]
