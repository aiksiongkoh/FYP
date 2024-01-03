Class {
	#name : #ForTorAction,
	#superclass : #ForceTorqueItem,
	#instVars : [
		'forTorBasicI',
		'forTorFunction'
	],
	#category : #'StCAD-MbD-MbDForce'
}

{ #category : #accessing }
ForTorAction >> forTorFunction [
	^forTorFunction
]

{ #category : #accessing }
ForTorAction >> forTorFunction: function [ 
	forTorFunction function: function
]

{ #category : #'initialize-release' }
ForTorAction >> initialize [
	forTorFunction := ForTorFunction new
]

{ #category : #'initialize-release' }
ForTorAction >> initializeGlobally [
	forTorFunction initializeGlobally.
	forTorBasicI initializeGlobally
]

{ #category : #'initialize-release' }
ForTorAction >> initializeLocally [
	forTorFunction initializeLocally.
	forTorBasicI initializeLocally
]

{ #category : #accIC }
ForTorAction >> postAccICIteration [
	forTorFunction postAccICIteration.
	forTorBasicI postAccICIteration.
	super postAccICIteration
]

{ #category : #collision }
ForTorAction >> postCollisionCorrectorIteration [
	forTorFunction postCollisionCorrectorIteration.
	forTorBasicI postCollisionCorrectorIteration.
	super postCollisionCorrectorIteration
]

{ #category : #collision }
ForTorAction >> postCollisionPredictor [
	forTorFunction postCollisionPredictor.
	forTorBasicI postCollisionPredictor.
	super postCollisionPredictor
]

{ #category : #dynamic }
ForTorAction >> postDynCorrectorIteration [
	forTorFunction postDynCorrectorIteration.
	forTorBasicI postDynCorrectorIteration.
	super postDynCorrectorIteration
]

{ #category : #dynamic }
ForTorAction >> postDynOutput [
	forTorFunction postDynOutput.
	forTorBasicI postDynOutput.
	super postDynOutput
]

{ #category : #dynamic }
ForTorAction >> postDynPredictor [
	forTorFunction postDynPredictor.
	forTorBasicI postDynPredictor.
	super postDynPredictor
]

{ #category : #'input-output' }
ForTorAction >> postInput [
	forTorFunction postInput.
	forTorBasicI postInput.
	super postInput
]

{ #category : #static }
ForTorAction >> postStaticIteration [
	forTorFunction postStaticIteration.
	forTorBasicI postStaticIteration.
	super postStaticIteration
]

{ #category : #accIC }
ForTorAction >> preAccIC [
	forTorFunction preAccIC.
	forTorBasicI preAccIC.
	super preAccIC
]

{ #category : #dynamic }
ForTorAction >> preDynOutput [
	forTorFunction preDynOutput.
	forTorBasicI preDynOutput.
	super preDynOutput
]

{ #category : #static }
ForTorAction >> preStatic [
	forTorFunction preStatic.
	forTorBasicI preStatic.
	super preStatic
]

{ #category : #dynamic }
ForTorAction >> simUpdateAll [
	forTorFunction simUpdateAll.
	forTorBasicI simUpdateAll.
	super simUpdateAll
]

{ #category : #'initialize-release' }
ForTorAction >> useEquationNumbers [
	forTorFunction useEquationNumbers.
	forTorBasicI useEquationNumbers
]
