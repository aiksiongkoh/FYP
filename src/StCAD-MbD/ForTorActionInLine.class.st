Class {
	#name : #ForTorActionInLine,
	#superclass : #ForTorAction,
	#instVars : [
		'distIeJe',
		'aFTIeO'
	],
	#category : #'StCAD-MbD-MbDForce'
}

{ #category : #accessing }
ForTorActionInLine >> aFTIeO [
	^aFTIeO
]

{ #category : #calc }
ForTorActionInLine >> calcPostDynCorrectorIteration [
	| uIeJeO tension |
	uIeJeO := distIeJe uIeJeO.
	tension := forTorFunction forTor.
	aFTIeO := uIeJeO times: tension
]

{ #category : #accessing }
ForTorActionInLine >> distIeJe [
	^distIeJe
]

{ #category : #accIC }
ForTorActionInLine >> fillAccICIterError: col [ 
	forTorBasicI fillAccICIterError: col aFTO: aFTIeO
]

{ #category : #accIC }
ForTorActionInLine >> fillAccICIterJacob: mat [ 
	forTorBasicI fillAccICIterJacob: mat
]

{ #category : #dynamic }
ForTorActionInLine >> fillDynError: col [ 
	forTorBasicI fillDynError: col aFTO: aFTIeO
]

{ #category : #dynamic }
ForTorActionInLine >> fillpFpy: mat [ 
	| forTor block |
	forTor := forTorFunction forTor.
	forTorBasicI fillpFpy: mat aFTO: aFTIeO.
	block := [:puIeJeOpXi :puIeJeOpEi :partFramei | forTorBasicI
				fillpFpy: mat
				pFTOpXj: (puIeJeOpXi times: forTor)
				pFTOpEj: (puIeJeOpEi times: forTor)
				partj: partFramei].
	block
		value: distIeJe puIeJeOpXI
		value: distIeJe puIeJeOpEI
		value: distIeJe partFrameI.
	block
		value: distIeJe puIeJeOpXJ
		value: distIeJe puIeJeOpEJ
		value: distIeJe partFrameJ.
	block := [:functions :pFTpfunctions | 1 to: functions size do: [:i | self
					fillpFpy: mat
					pFTpfunction: (pFTpfunctions at: i)
					function: (functions at: i)]].
	block value: forTorFunction kineIJs value: forTorFunction pFTpkineIJs.
	block value: forTorFunction kinedotIJs value: forTorFunction pFTpkinedotIJs.
	block value: forTorFunction jointActions value: forTorFunction pFTpJtActs
]

{ #category : #dynamic }
ForTorActionInLine >> fillpFpy: mat pFTpfunction: pFTpfunction function: function [ 
	| uIeJeO block |
	uIeJeO := distIeJe uIeJeO.
	block := [:pvaluepXi :pvaluepEi :partFramei | pvaluepXi == nil
				ifTrue: [pvaluepEi == nil ifFalse: [forTorBasicI
							fillpFpy: mat
							pFTOpEj: (uIeJeO timesFullRow: pvaluepEi times: pFTpfunction)
							partj: partFramei]]
				ifFalse: [pvaluepEi == nil
						ifTrue: [forTorBasicI
								fillpFpy: mat
								pFTOpXj: (uIeJeO timesFullRow: pvaluepXi times: pFTpfunction)
								partj: partFramei]
						ifFalse: [forTorBasicI
								fillpFpy: mat
								pFTOpXj: (uIeJeO timesFullRow: pvaluepXi times: pFTpfunction)
								pFTOpEj: (uIeJeO timesFullRow: pvaluepEi times: pFTpfunction)
								partj: partFramei]]].
	block
		value: function pvaluepXI
		value: function pvaluepEI
		value: function partFrameI.
	block
		value: function pvaluepXJ
		value: function pvaluepEJ
		value: function partFrameJ.
	block
		value: function pvaluepXK
		value: function pvaluepEK
		value: function partFrameK
]

{ #category : #dynamic }
ForTorActionInLine >> fillpFpydot: mat [ 
	| uIeJeO kinedotIJs jointActions pFTpkinedotIJs pFTpJtActs |
	uIeJeO := distIeJe uIeJeO.
	kinedotIJs := forTorFunction kinedotIJs.
	jointActions := forTorFunction jointActions.
	pFTpkinedotIJs := forTorFunction pFTpkinedotIJs.
	pFTpJtActs := forTorFunction pFTpJtActs.
	1 to: kinedotIJs size do: [:i | self
			fillpFpydot: mat
			pFTpfunction: (pFTpkinedotIJs at: i)
			function: (kinedotIJs at: i)].
	1 to: jointActions size do: [:i | forTorBasicI fillpFpydot: mat pFTOpmudot: (uIeJeO timesSparseRow: (jointActions at: i) pvalueplam times: (pFTpJtActs at: i))]
]

{ #category : #dynamic }
ForTorActionInLine >> fillpFpydot: mat pFTpfunction: pFTpfunction function: function [ 
	| uIeJeO block |
	uIeJeO := distIeJe uIeJeO.
	block := [:pvaluepXdoti :pvaluepEdoti :partFramei | pvaluepXdoti == nil
				ifTrue: [pvaluepEdoti == nil ifFalse: [forTorBasicI
							fillpFpydot: mat
							pFTOpEdotj: (uIeJeO timesFullRow: pvaluepEdoti times: pFTpfunction)
							partj: partFramei]]
				ifFalse: [pvaluepEdoti == nil
						ifTrue: [forTorBasicI
								fillpFpydot: mat
								pFTOpXdotj: (uIeJeO timesFullRow: pvaluepXdoti times: pFTpfunction)
								partj: partFramei]
						ifFalse: [forTorBasicI
								fillpFpydot: mat
								pFTOpXdotj: (uIeJeO timesFullRow: pvaluepXdoti times: pFTpfunction)
								pFTOpEdotj: (uIeJeO timesFullRow: pvaluepEdoti times: pFTpfunction)
								partj: partFramei]]].
	block
		value: function pvaluepXdotI
		value: function pvaluepEdotI
		value: function partFrameI.
	block
		value: function pvaluepXdotJ
		value: function pvaluepEdotJ
		value: function partFrameJ.
	block
		value: function pvaluepXdotK
		value: function pvaluepEdotK
		value: function partFrameK
]

{ #category : #'initialize-release' }
ForTorActionInLine >> forceOnFrmI: efrmi andFrmJ: efrmj [ 
	forTorBasicI := ForceBasicqcVector new.
	forTorBasicI parent: self.
	forTorBasicI endFrame: efrmi.
	distIeJe withFrmI: efrmi frmJ: efrmj
]

{ #category : #'initialize-release' }
ForTorActionInLine >> initialize [
	distIeJe := MbDDistIeqcJeqc new.
	forTorFunction := ForTorFunction new
]

{ #category : #'initialize-release' }
ForTorActionInLine >> initializeGlobally [
	distIeJe initializeGlobally.
	forTorFunction initializeGlobally.
	forTorBasicI initializeGlobally
]

{ #category : #'initialize-release' }
ForTorActionInLine >> initializeLocally [
	distIeJe initializeLocally.
	forTorFunction initializeLocally.
	forTorBasicI initializeLocally
]

{ #category : #accIC }
ForTorActionInLine >> postAccICIteration [
	distIeJe postAccICIteration.
	forTorFunction postAccICIteration.
	forTorBasicI postAccICIteration.
	super postAccICIteration
]

{ #category : #collision }
ForTorActionInLine >> postCollisionCorrectorIteration [
	distIeJe postCollisionCorrectorIteration.
	forTorFunction postCollisionCorrectorIteration.
	forTorBasicI postCollisionCorrectorIteration.
	super postCollisionCorrectorIteration
]

{ #category : #collision }
ForTorActionInLine >> postCollisionPredictor [
	distIeJe postCollisionPredictor.
	forTorFunction postCollisionPredictor.
	forTorBasicI postCollisionPredictor.
	super postCollisionPredictor
]

{ #category : #dynamic }
ForTorActionInLine >> postDynCorrectorIteration [
	distIeJe postDynCorrectorIteration.
	forTorFunction postDynCorrectorIteration.
	forTorBasicI postDynCorrectorIteration.
	super postDynCorrectorIteration
]

{ #category : #dynamic }
ForTorActionInLine >> postDynOutput [
	distIeJe postDynOutput.
	forTorFunction postDynOutput.
	forTorBasicI postDynOutput.
	super postDynOutput
]

{ #category : #dynamic }
ForTorActionInLine >> postDynPredictor [
	distIeJe postDynPredictor.
	forTorFunction postDynPredictor.
	forTorBasicI postDynPredictor.
	super postDynPredictor
]

{ #category : #'input-output' }
ForTorActionInLine >> postInput [
	distIeJe postInput.
	forTorFunction postInput.
	forTorBasicI postInput.
	super postInput
]

{ #category : #static }
ForTorActionInLine >> postStaticIteration [
	distIeJe postStaticIteration.
	forTorFunction postStaticIteration.
	forTorBasicI postStaticIteration.
	super postStaticIteration
]

{ #category : #accIC }
ForTorActionInLine >> preAccIC [
	distIeJe preAccIC.
	forTorFunction preAccIC.
	forTorBasicI preAccIC.
	super preAccIC
]

{ #category : #dynamic }
ForTorActionInLine >> preDynOutput [
	distIeJe preDynOutput.
	forTorFunction preDynOutput.
	forTorBasicI preDynOutput.
	super preDynOutput
]

{ #category : #static }
ForTorActionInLine >> preStatic [
	distIeJe preStatic.
	forTorFunction preStatic.
	forTorBasicI preStatic.
	super preStatic
]

{ #category : #dynamic }
ForTorActionInLine >> simUpdateAll [
	distIeJe simUpdateAll.
	forTorFunction simUpdateAll.
	forTorBasicI simUpdateAll.
	super simUpdateAll
]

{ #category : #accessing }
ForTorActionInLine >> tension [
	^forTorFunction
]

{ #category : #'initialize-release' }
ForTorActionInLine >> torqueOnFrmI: efrmi andFrmJ: efrmj [ 
	forTorBasicI := TorqueBasicVector new.
	forTorBasicI parent: self.
	forTorBasicI endFrame: efrmi.
	distIeJe withFrmI: efrmi frmJ: efrmj
]

{ #category : #accessing }
ForTorActionInLine >> uIeJeO [
	^distIeJe uIeJeO
]

{ #category : #'initialize-release' }
ForTorActionInLine >> useEquationNumbers [
	distIeJe useEquationNumbers.
	forTorFunction useEquationNumbers.
	forTorBasicI useEquationNumbers
]
