Class {
	#name : #ForTorVector,
	#superclass : #ForceTorqueItem,
	#instVars : [
		'components'
	],
	#category : #'StCAD-MbD-MbDForce'
}

{ #category : #accessing }
ForTorVector >> aFTIeO [
	^components inject: (FullColumn zero: 3) into: [:aFTIeO :comp | aFTIeO + comp aFTIeO]
]

{ #category : #accIC }
ForTorVector >> fillAccICIterError: col [ 
	components do: [:comp | comp fillAccICIterError: col]
]

{ #category : #accIC }
ForTorVector >> fillAccICIterJacob: mat [ 
	components do: [:comp | comp fillAccICIterJacob: mat]
]

{ #category : #dynamic }
ForTorVector >> fillDynError: col [ 
	components do: [:comp | comp fillDynError: col]
]

{ #category : #dynamic }
ForTorVector >> fillpFpy: mat [ 
	components do: [:comp | comp fillpFpy: mat]
]

{ #category : #dynamic }
ForTorVector >> fillpFpydot: mat [ 
	components do: [:comp | comp fillpFpydot: mat]
]

{ #category : #accessing }
ForTorVector >> functions: col [ 
	| collection funci compi |
	collection := OrderedCollection new.
	1 to: 3
		do: 
			[:i | 
			compi := components at: i.
			compi forTorFunction formula isNil ifFalse: [self error: #'StM: ForceTorque function can only be initialized once.'].
			funci := col at: i.
			(funci notNil and: [funci isZero not])
				ifTrue: 
					[compi forTorFunction formula: (col at: i).
					collection add: compi]].
	components := collection
]

{ #category : #'initialize-release' }
ForTorVector >> initializeGlobally [
	components do: [:comp | comp initializeGlobally]
]

{ #category : #'initialize-release' }
ForTorVector >> initializeLocally [
	components do: [:comp | comp initializeLocally]
]

{ #category : #accIC }
ForTorVector >> postAccICIteration [ 
	components do: [:comp | comp postAccICIteration]
]

{ #category : #collision }
ForTorVector >> postCollisionCorrectorIteration [
	components do: [:comp | comp postCollisionCorrectorIteration]
]

{ #category : #collision }
ForTorVector >> postCollisionPredictor [
	components do: [:comp | comp postCollisionPredictor]
]

{ #category : #dynamic }
ForTorVector >> postDynCorrectorIteration [
	components do: [:comp | comp postDynCorrectorIteration]
]

{ #category : #dynamic }
ForTorVector >> postDynOutput [
	components do: [:comp | comp postDynOutput]
]

{ #category : #dynamic }
ForTorVector >> postDynPredictor [
	components do: [:comp | comp postDynPredictor]
]

{ #category : #'input-output' }
ForTorVector >> postInput [
	components do: [:comp | comp postInput]
]

{ #category : #static }
ForTorVector >> postStaticIteration [
	components do: [:comp | comp postStaticIteration]
]

{ #category : #accIC }
ForTorVector >> preAccIC [ 
	components do: [:comp | comp preAccIC]
]

{ #category : #dynamic }
ForTorVector >> preDynOutput [
	components do: [:comp | comp preDynOutput]
]

{ #category : #static }
ForTorVector >> preStatic [
	components do: [:comp | comp preStatic]
]

{ #category : #dynamic }
ForTorVector >> simUpdateAll [
	components do: [:comp | comp simUpdateAll]
]

{ #category : #'initialize-release' }
ForTorVector >> useEquationNumbers [
	components do: [:comp | comp useEquationNumbers]
]
