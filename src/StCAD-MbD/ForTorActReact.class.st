Class {
	#name : #ForTorActReact,
	#superclass : #ForceTorqueItem,
	#instVars : [
		'forTorAction',
		'forTorBasicJ'
	],
	#category : #'StCAD-MbD-MbDForce'
}

{ #category : #accessing }
ForTorActReact >> aFTIeO [
	^forTorAction aFTIeO
]

{ #category : #accessing }
ForTorActReact >> forTorFunction [
	^forTorAction forTorFunction
]

{ #category : #accessing }
ForTorActReact >> forTorFunction: formula [ 
	forTorAction forTorFunction: formula
]

{ #category : #'initialize-release' }
ForTorActReact >> initializeGlobally [
	forTorAction initializeGlobally.
	forTorBasicJ initializeGlobally
]

{ #category : #'initialize-release' }
ForTorActReact >> initializeLocally [
	forTorAction initializeLocally.
	forTorBasicJ initializeLocally
]

{ #category : #accIC }
ForTorActReact >> postAccICIteration [
	forTorAction postAccICIteration.
	forTorBasicJ postAccICIteration.
	super postAccICIteration
]

{ #category : #collision }
ForTorActReact >> postCollisionCorrectorIteration [
	forTorAction postCollisionCorrectorIteration.
	forTorBasicJ postCollisionCorrectorIteration.
	super postCollisionCorrectorIteration
]

{ #category : #collision }
ForTorActReact >> postCollisionPredictor [
	forTorAction postCollisionPredictor.
	forTorBasicJ postCollisionPredictor.
	super postCollisionPredictor
]

{ #category : #dynamic }
ForTorActReact >> postDynCorrectorIteration [
	forTorAction postDynCorrectorIteration.
	forTorBasicJ postDynCorrectorIteration.
	super postDynCorrectorIteration
]

{ #category : #dynamic }
ForTorActReact >> postDynOutput [
	forTorAction postDynOutput.
	forTorBasicJ postDynOutput.
	super postDynOutput
]

{ #category : #dynamic }
ForTorActReact >> postDynPredictor [
	forTorAction postDynPredictor.
	forTorBasicJ postDynPredictor.
	super postDynPredictor
]

{ #category : #'input-output' }
ForTorActReact >> postInput [
	forTorAction postInput.
	forTorBasicJ postInput.
	super postInput
]

{ #category : #static }
ForTorActReact >> postStaticIteration [
	forTorAction postStaticIteration.
	forTorBasicJ postStaticIteration.
	super postStaticIteration
]

{ #category : #accIC }
ForTorActReact >> preAccIC [
	forTorAction preAccIC.
	forTorBasicJ preAccIC.
	super preAccIC
]

{ #category : #dynamic }
ForTorActReact >> preDynOutput [
	forTorAction preDynOutput.
	forTorBasicJ preDynOutput.
	super preDynOutput
]

{ #category : #static }
ForTorActReact >> preStatic [
	forTorAction preStatic.
	forTorBasicJ preStatic.
	super preStatic
]

{ #category : #dynamic }
ForTorActReact >> simUpdateAll [
	forTorAction simUpdateAll.
	forTorBasicJ simUpdateAll.
	super simUpdateAll
]

{ #category : #'initialize-release' }
ForTorActReact >> useEquationNumbers [
	forTorAction useEquationNumbers.
	forTorBasicJ useEquationNumbers
]
