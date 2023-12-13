Class {
	#name : #ForceTorqueInLine,
	#superclass : #ForceTorqueItem,
	#instVars : [
		'forceInLine',
		'torqueInLine'
	],
	#category : #'StCAD-MbD-MbDForce'
}

{ #category : #'instance creation' }
ForceTorqueInLine class >> onFrmI: efrmI andFrmJ: efrmJ [ 
	^self new onFrmI: efrmI andFrmJ: efrmJ
]

{ #category : #'VisualWorks metadata' }
ForceTorqueInLine class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
ForceTorqueInLine >> aFX [
	^forceInLine aFTIeO
]

{ #category : #accessing }
ForceTorqueInLine >> aTX [
	^torqueInLine aFTIeO
]

{ #category : #accIC }
ForceTorqueInLine >> fillAccICIterError: col [
	forceInLine fillAccICIterError: col.
	torqueInLine fillAccICIterError: col
]

{ #category : #accIC }
ForceTorqueInLine >> fillAccICIterJacob: mat [
	forceInLine fillAccICIterJacob: mat.
	torqueInLine fillAccICIterJacob: mat
]

{ #category : #dynamic }
ForceTorqueInLine >> fillDynError: col [
	forceInLine fillDynError: col.
	torqueInLine fillDynError: col
]

{ #category : #posIC }
ForceTorqueInLine >> fillPosICError: col [
	forceInLine fillPosICError: col.
	torqueInLine fillPosICError: col
]

{ #category : #posIC }
ForceTorqueInLine >> fillPosICJacob: mat [
	forceInLine fillPosICJacob: mat.
	torqueInLine fillPosICJacob: mat
]

{ #category : #static }
ForceTorqueInLine >> fillStaticError: col [
	forceInLine fillStaticError: col.
	torqueInLine fillStaticError: col
]

{ #category : #static }
ForceTorqueInLine >> fillStaticJacob: mat [
	forceInLine fillStaticJacob: mat.
	torqueInLine fillStaticJacob: mat
]

{ #category : #dynamic }
ForceTorqueInLine >> fillpFpy: mat [
	forceInLine fillpFpy: mat.
	torqueInLine fillpFpy: mat
]

{ #category : #dynamic }
ForceTorqueInLine >> fillpFpydot: mat [
	forceInLine fillpFpydot: mat.
	torqueInLine fillpFpydot: mat
]

{ #category : #'initialize-release' }
ForceTorqueInLine >> initializeGlobally [
	forceInLine initializeGlobally.
	torqueInLine initializeGlobally
]

{ #category : #'initialize-release' }
ForceTorqueInLine >> initializeLocally [
	forceInLine initializeLocally.
	torqueInLine initializeLocally
]

{ #category : #'initialize-release' }
ForceTorqueInLine >> onFrmI: efrmI andFrmJ: efrmJ [ 
	forceInLine := ForTorActReactInLine forceOnFrmI: efrmI andFrmJ: efrmJ.
	torqueInLine := ForTorActReactInLine torqueOnFrmI: efrmI andFrmJ: efrmJ
]

{ #category : #accIC }
ForceTorqueInLine >> postAccICIteration [
	forceInLine postAccICIteration.
	torqueInLine postAccICIteration
]

{ #category : #collision }
ForceTorqueInLine >> postCollisionCorrectorIteration [
	forceInLine postCollisionCorrectorIteration.
	torqueInLine postCollisionCorrectorIteration
]

{ #category : #collision }
ForceTorqueInLine >> postCollisionPredictor [
	forceInLine postCollisionPredictor.
	torqueInLine postCollisionPredictor
]

{ #category : #dynamic }
ForceTorqueInLine >> postDynCorrectorIteration [
	forceInLine postDynCorrectorIteration.
	torqueInLine postDynCorrectorIteration
]

{ #category : #dynamic }
ForceTorqueInLine >> postDynOutput [
	forceInLine postDynOutput.
	torqueInLine postDynOutput
]

{ #category : #dynamic }
ForceTorqueInLine >> postDynPredictor [
	forceInLine postDynPredictor.
	torqueInLine postDynPredictor
]

{ #category : #'input-output' }
ForceTorqueInLine >> postInput [
	forceInLine postInput.
	torqueInLine postInput
]

{ #category : #static }
ForceTorqueInLine >> postStaticIteration [
	forceInLine postStaticIteration.
	torqueInLine postStaticIteration
]

{ #category : #accIC }
ForceTorqueInLine >> preAccIC [
	forceInLine preAccIC.
	torqueInLine preAccIC
]

{ #category : #dynamic }
ForceTorqueInLine >> preDynOutput [
	forceInLine preDynOutput.
	torqueInLine preDynOutput
]

{ #category : #static }
ForceTorqueInLine >> preStatic [
	forceInLine preStatic.
	torqueInLine preStatic
]

{ #category : #dynamic }
ForceTorqueInLine >> simUpdateAll [
	forceInLine simUpdateAll.
	torqueInLine simUpdateAll
]

{ #category : #'initialize-release' }
ForceTorqueInLine >> submitToSystem [
	self registerName.
	TheMbDSystem forcesTorques add: self
]

{ #category : #accessing }
ForceTorqueInLine >> tension: func [ 
	(func notNil and: [func isZero not])
		ifTrue: [forceInLine forTorFunction formula: func]
		ifFalse: [forceInLine := ForTorZero new]
]

{ #category : #accessing }
ForceTorqueInLine >> twist: func [ 
	(func notNil and: [func isZero not])
		ifTrue: [torqueInLine forTorFunction formula: func]
		ifFalse: [torqueInLine := ForTorZero new]
]

{ #category : #'initialize-release' }
ForceTorqueInLine >> useEquationNumbers [
	forceInLine useEquationNumbers.
	torqueInLine useEquationNumbers
]
