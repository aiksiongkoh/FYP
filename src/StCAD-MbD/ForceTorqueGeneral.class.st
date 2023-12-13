Class {
	#name : #ForceTorqueGeneral,
	#superclass : #ForceTorqueItem,
	#instVars : [
		'forceVector',
		'torqueVector'
	],
	#category : #'StCAD-MbD-MbDForce'
}

{ #category : #'instance creation' }
ForceTorqueGeneral class >> onFrmI: efrmI andFrmJ: efrmJ [ 
	^self new onFrmI: efrmI andFrmJ: efrmJ
]

{ #category : #'instance creation' }
ForceTorqueGeneral class >> onFrmI: efrmI andFrmJ: efrmJ wrtFrmK: efrmK [ 
	^self new
		onFrmI: efrmI
		andFrmJ: efrmJ
		wrtFrmK: efrmK
]

{ #category : #'VisualWorks metadata' }
ForceTorqueGeneral class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
ForceTorqueGeneral >> aFX [
	^forceVector aFTIeO
]

{ #category : #accessing }
ForceTorqueGeneral >> aTX [
	^torqueVector aFTIeO
]

{ #category : #accIC }
ForceTorqueGeneral >> fillAccICIterError: col [ 
	forceVector fillAccICIterError: col .
	torqueVector fillAccICIterError: col
]

{ #category : #accIC }
ForceTorqueGeneral >> fillAccICIterJacob: mat [ 
	forceVector fillAccICIterJacob: mat .
	torqueVector fillAccICIterJacob: mat
]

{ #category : #dynamic }
ForceTorqueGeneral >> fillDynError: col [
	forceVector fillDynError: col.
	torqueVector fillDynError: col
]

{ #category : #posIC }
ForceTorqueGeneral >> fillPosICError: col [ 
	forceVector fillPosICError: col.
	torqueVector fillPosICError: col
]

{ #category : #posIC }
ForceTorqueGeneral >> fillPosICJacob: mat [ 
	forceVector fillPosICJacob: mat.
	torqueVector fillPosICJacob: mat
]

{ #category : #static }
ForceTorqueGeneral >> fillStaticError: col [
	forceVector fillStaticError: col.
	torqueVector fillStaticError: col
]

{ #category : #static }
ForceTorqueGeneral >> fillStaticJacob: mat [
	forceVector fillStaticJacob: mat.
	torqueVector fillStaticJacob: mat
]

{ #category : #dynamic }
ForceTorqueGeneral >> fillpFpy: mat [
	forceVector fillpFpy: mat.
	torqueVector fillpFpy: mat
]

{ #category : #dynamic }
ForceTorqueGeneral >> fillpFpydot: mat [
	forceVector fillpFpydot: mat.
	torqueVector fillpFpydot: mat
]

{ #category : #accessing }
ForceTorqueGeneral >> forceFunctions: col [ 
	forceVector functions: col
]

{ #category : #'initialize-release' }
ForceTorqueGeneral >> initializeGlobally [
	forceVector initializeGlobally.
	torqueVector initializeGlobally
]

{ #category : #'initialize-release' }
ForceTorqueGeneral >> initializeLocally [
	forceVector initializeLocally.
	torqueVector initializeLocally
]

{ #category : #'initialize-release' }
ForceTorqueGeneral >> onFrmI: efrmI andFrmJ: efrmJ [ 
	forceVector := ForceVector onFrmI: efrmI andFrmJ: efrmJ.
	torqueVector := TorqueVector onFrmI: efrmI andFrmJ: efrmJ
]

{ #category : #'initialize-release' }
ForceTorqueGeneral >> onFrmI: efrmI andFrmJ: efrmJ wrtFrmK: efrmK [ 
	forceVector := ForceVector
				onFrmI: efrmI
				andFrmJ: efrmJ
				wrtFrmK: efrmK.
	torqueVector := TorqueVector
				onFrmI: efrmI
				andFrmJ: efrmJ
				wrtFrmK: efrmK
]

{ #category : #accIC }
ForceTorqueGeneral >> postAccICIteration [
	forceVector postAccICIteration.
	torqueVector postAccICIteration
]

{ #category : #collision }
ForceTorqueGeneral >> postCollisionCorrectorIteration [
	forceVector postCollisionCorrectorIteration.
	torqueVector postCollisionCorrectorIteration
]

{ #category : #collision }
ForceTorqueGeneral >> postCollisionPredictor [
	forceVector postCollisionPredictor.
	torqueVector postCollisionPredictor
]

{ #category : #dynamic }
ForceTorqueGeneral >> postDynCorrectorIteration [
	forceVector postDynCorrectorIteration.
	torqueVector postDynCorrectorIteration
]

{ #category : #dynamic }
ForceTorqueGeneral >> postDynOutput [
	forceVector postDynOutput.
	torqueVector postDynOutput
]

{ #category : #dynamic }
ForceTorqueGeneral >> postDynPredictor [
	forceVector postDynPredictor.
	torqueVector postDynPredictor
]

{ #category : #'input-output' }
ForceTorqueGeneral >> postInput [
	forceVector postInput.
	torqueVector postInput
]

{ #category : #static }
ForceTorqueGeneral >> postStaticIteration [
	forceVector postStaticIteration.
	torqueVector postStaticIteration
]

{ #category : #accIC }
ForceTorqueGeneral >> preAccIC [
	forceVector preAccIC.
	torqueVector preAccIC
]

{ #category : #dynamic }
ForceTorqueGeneral >> preDynOutput [
	forceVector preDynOutput.
	torqueVector preDynOutput
]

{ #category : #static }
ForceTorqueGeneral >> preStatic [
	forceVector preStatic.
	torqueVector preStatic
]

{ #category : #dynamic }
ForceTorqueGeneral >> simUpdateAll [
	forceVector simUpdateAll.
	torqueVector simUpdateAll
]

{ #category : #'initialize-release' }
ForceTorqueGeneral >> submitToSystem [
	self registerName.
	TheMbDSystem forcesTorques add: self
]

{ #category : #accessing }
ForceTorqueGeneral >> torqueFunctions: col [ 
	torqueVector functions: col
]

{ #category : #'initialize-release' }
ForceTorqueGeneral >> useEquationNumbers [
	forceVector useEquationNumbers.
	torqueVector useEquationNumbers
]
