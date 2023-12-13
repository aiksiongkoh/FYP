Class {
	#name : #Assembly,
	#superclass : #AnyPart,
	#instVars : [
		'cAnyPart',
		'cConstraintSet',
		'cForceTorque',
		'cField',
		'cSensor',
		'cVariable',
		'hasChanged',
		'aSolver'
	],
	#category : #'StCAD-MbD-StCAD-MbD-Basic'
}

{ #category : #accessing }
Assembly class >> aRefFrameClass [
	^AssemblyFrame
]

{ #category : #'VisualWorks metadata' }
Assembly class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
Assembly >> addAnyPart: aAnyPart [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	aAnyPart removeSup.
	super addRefFrame: aAnyPart aRefFrame.
	cAnyPart add: aAnyPart.
	aAnyPart aSup: self.
	^aAnyPart
]

{ #category : #accessing }
Assembly >> addAnyParts: arrayAnyPart [ 
	arrayAnyPart do: [:aAnyPart | self addAnyPart: aAnyPart]
]

{ #category : #accessing }
Assembly >> addForceTorque: aForceTorque [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	aForceTorque removeSup.
	cForceTorque add: aForceTorque.
	aForceTorque aSup: self.
	^aForceTorque
]

{ #category : #accessing }
Assembly >> addForceTorques: arrayForceTorque [ 
	arrayForceTorque do: [:aForceTorque | self addForceTorque: aForceTorque]
]

{ #category : #accessing }
Assembly >> addKinematicIJ: aKinematicIJ [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	aKinematicIJ removeSup.
	cConstraintSet add: aKinematicIJ.
	aKinematicIJ aSup: self.
	^aKinematicIJ
]

{ #category : #'initialize-release' }
Assembly >> initialize [

	super initialize.
	cAnyPart := StCAD_Misc_OrderedSet new. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	cConstraintSet := StCAD_Misc_OrderedSet new.
	cForceTorque := StCAD_Misc_OrderedSet new.
	cField := StCAD_Misc_OrderedSet new.
	cVariable := StCAD_Misc_OrderedSet new
]
