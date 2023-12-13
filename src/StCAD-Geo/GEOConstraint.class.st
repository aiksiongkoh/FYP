Class {
	#name : #GEOConstraint,
	#superclass : #GEOContainedItem,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'VisualWorks metadata' }
GEOConstraint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #DYN }
GEOConstraint >> canUpdateForFrame: integer [ 
	^true
]

{ #category : #DYN }
GEOConstraint >> dataFromCurrentState [
	| answer |
	answer := GEOForceTorqueData new.
	answer aFIO: (FullColumn zero: 3).
	answer aTIO: (FullColumn zero: 3).
	^answer
]

{ #category : #DYN }
GEOConstraint >> dataFromMbD [
	"
	MbD returns aFIeO and aTIeO.
	GEO needs aFImO and aTImO.
	For Motion rImIeO is not zero and is changing.
	aFImO := aFIeO.
	aTImO := aTIeO + (rImIeO cross: aFIeO).
	"

	| mbdUnits mbdItem answer aFIeO aTIeO rImIeO |
	mbdUnits := self mbdUnits.
	mbdItem := self mbdObject.
	answer := GEOForceTorqueData new.
	aFIeO := mbdItem aFX * mbdUnits force.
	aTIeO := mbdItem aTX * mbdUnits torque.
	rImIeO := mbdItem frmI rmeO * mbdUnits length.
	answer aFIO: aFIeO.
	answer aTIO: aTIeO + (rImIeO cross: aFIeO).
	^answer
]

{ #category : #DYN }
GEOConstraint >> storeInputFromMbD [
	"Do nothing."
]

{ #category : #DYN }
GEOConstraint >> storeInputState [
	"Do nothing."
]

{ #category : #DYN }
GEOConstraint >> updateForFrame1: integer [ 
	"Do nothing."
]

{ #category : #DYN }
GEOConstraint >> updateForFrame: integer [ 
	"Do nothing."
]

{ #category : #DYN }
GEOConstraint >> updateFromInitiallyAssembledState [
	"Do nothing."
]

{ #category : #DYN }
GEOConstraint >> updateFromInputState [
	"Do nothing."
]

{ #category : #DYN }
GEOConstraint >> updateFromMbD [
	| data |
	data := self dataFromMbD.
	self dataSeries add: data
]

{ #category : #DYN }
GEOConstraint >> validateFormulas [
	"Do nothing."
]
