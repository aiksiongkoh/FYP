Class {
	#name : #ForTorActReactInLine,
	#superclass : #ForTorActReact,
	#instVars : [
		'aFTJeO'
	],
	#category : #'StCAD-MbD-MbDForce'
}

{ #category : #'instance creation' }
ForTorActReactInLine class >> forceOnFrmI: aFrmI andFrmJ: aFrmJ [ 
	^super new forceOnFrmI: aFrmI andFrmJ: aFrmJ
]

{ #category : #'instance creation' }
ForTorActReactInLine class >> torqueOnFrmI: aFrmI andFrmJ: aFrmJ [ 
	^super new torqueOnFrmI: aFrmI andFrmJ: aFrmJ
]

{ #category : #'VisualWorks metadata' }
ForTorActReactInLine class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #calc }
ForTorActReactInLine >> calcPostDynCorrectorIteration [
	aFTJeO := forTorAction aFTIeO negated
]

{ #category : #accIC }
ForTorActReactInLine >> fillAccICIterError: col [ 
	forTorAction fillAccICIterError: col.
	forTorBasicJ fillAccICIterError: col aFTO: aFTJeO
]

{ #category : #accIC }
ForTorActReactInLine >> fillAccICIterJacob: mat [ 
	forTorAction fillAccICIterJacob: mat.
	forTorBasicJ fillAccICIterJacob: mat
]

{ #category : #dynamic }
ForTorActReactInLine >> fillDynError: col [ 
	forTorAction fillDynError: col.
	forTorBasicJ fillDynError: col aFTO: aFTJeO
]

{ #category : #dynamic }
ForTorActReactInLine >> fillpFpy1: mat [ 
	| kineIJs tension kinedotIJs jointActions forTor pFTpkineIJs pFTpkinedotIJs pFTpJtActs uIeJeO distIeJe mforTor kineIJ mpFTpkineIJ kinedotIJ mpFTpkinedotIJ jointAction mpFTpJtAct |
	forTorAction fillpFpy: mat.
	distIeJe := forTorAction distIeJe.
	uIeJeO := distIeJe uIeJeO.
	tension := forTorAction tension.
	kineIJs := tension kineIJs.
	kinedotIJs := tension kinedotIJs.
	jointActions := tension jointActions.
	forTor := tension forTor.
	pFTpkineIJs := tension pFTpkineIJs.
	pFTpkinedotIJs := tension pFTpkinedotIJs.
	pFTpJtActs := tension pFTpJtActs.
	mforTor := 0.0d - forTor.
	forTorBasicJ fillpFpy: mat aFTO: aFTJeO.
	forTorBasicJ
		fillpFpy: mat
		pFTOpXj: (distIeJe puIeJeOpXI times: mforTor)
		pFTOpEj: (distIeJe puIeJeOpEI times: mforTor)
		partj: distIeJe partFrameI.
	forTorBasicJ
		fillpFpy: mat
		pFTOpXj: (distIeJe puIeJeOpXJ times: mforTor)
		pFTOpEj: (distIeJe puIeJeOpEJ times: mforTor)
		partj: distIeJe partFrameJ.
	1 to: kineIJs size
		do: 
			[:i | 
			kineIJ := kineIJs at: i.
			mpFTpkineIJ := 0.0d - (pFTpkineIJs at: i).
			forTorBasicJ
				fillpFpy: mat
				pFTOpXj: (uIeJeO timesFullRow: kineIJ pvaluepXI times: mpFTpkineIJ)
				pFTOpEj: (uIeJeO timesFullRow: kineIJ pvaluepEI times: mpFTpkineIJ)
				partj: kineIJ partFrameI.
			forTorBasicJ
				fillpFpy: mat
				pFTOpXj: (uIeJeO timesFullRow: kineIJ pvaluepXJ times: mpFTpkineIJ)
				pFTOpEj: (uIeJeO timesFullRow: kineIJ pvaluepEJ times: mpFTpkineIJ)
				partj: kineIJ partFrameJ].
	1 to: kinedotIJs size
		do: 
			[:i | 
			kinedotIJ := kinedotIJs at: i.
			mpFTpkinedotIJ := 0.0d - (pFTpkinedotIJs at: i).
			forTorBasicJ
				fillpFpy: mat
				pFTOpXj: (uIeJeO timesFullRow: kinedotIJ pvaluepXI times: mpFTpkinedotIJ)
				pFTOpEj: (uIeJeO timesFullRow: kinedotIJ pvaluepEI times: mpFTpkinedotIJ)
				partj: kinedotIJ partFrameI.
			forTorBasicJ
				fillpFpy: mat
				pFTOpXj: (uIeJeO timesFullRow: kinedotIJ pvaluepXJ times: mpFTpkinedotIJ)
				pFTOpEj: (uIeJeO timesFullRow: kinedotIJ pvaluepEJ times: mpFTpkinedotIJ)
				partj: kinedotIJ partFrameJ].
	1 to: jointActions size
		do: 
			[:i | 
			jointAction := jointActions at: i.
			mpFTpJtAct := 0.0d - (pFTpJtActs at: i).
			forTorBasicJ
				fillpFpy: mat
				pFTOpXj: (uIeJeO timesFullRow: jointAction pvaluepXI times: mpFTpJtAct)
				pFTOpEj: (uIeJeO timesFullRow: jointAction pvaluepEI times: mpFTpJtAct)
				partj: jointAction partFrameI.
			forTorBasicJ
				fillpFpy: mat
				pFTOpXj: (uIeJeO timesFullRow: jointAction pvaluepXJ times: mpFTpJtAct)
				pFTOpEj: (uIeJeO timesFullRow: jointAction pvaluepEJ times: mpFTpJtAct)
				partj: jointAction partFrameJ]
]

{ #category : #dynamic }
ForTorActReactInLine >> fillpFpy: mat [ 
	| distIeJe tension mforTor block |
	forTorAction fillpFpy: mat.
	distIeJe := forTorAction distIeJe.
	tension := forTorAction tension.
	mforTor := 0.0d - tension forTor.
	forTorBasicJ fillpFpy: mat aFTO: aFTJeO.
	block := [:puIeJeOpXi :puIeJeOpEi :partFramei | forTorBasicJ
				fillpFpy: mat
				pFTOpXj: (puIeJeOpXi times: mforTor)
				pFTOpEj: (puIeJeOpEi times: mforTor)
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
					pFTpfunction: (pFTpfunctions at: i) negated
					function: (functions at: i)]].
	block value: tension kineIJs value: tension pFTpkineIJs.
	block value: tension kinedotIJs value: tension pFTpkinedotIJs.
	block value: tension jointActions value: tension pFTpJtActs
]

{ #category : #dynamic }
ForTorActReactInLine >> fillpFpy: mat pFTpfunction: pFTpfunction function: function [ 
	| uIeJeO block |
	uIeJeO := forTorAction uIeJeO.
	block := [:pvaluepXi :pvaluepEi :partFramei | pvaluepXi == nil
				ifTrue: [pvaluepEi == nil ifFalse: [forTorBasicJ
							fillpFpy: mat
							pFTOpEj: (uIeJeO timesFullRow: pvaluepEi times: pFTpfunction)
							partj: partFramei]]
				ifFalse: [pvaluepEi == nil
						ifTrue: [forTorBasicJ
								fillpFpy: mat
								pFTOpXj: (uIeJeO timesFullRow: pvaluepXi times: pFTpfunction)
								partj: partFramei]
						ifFalse: [forTorBasicJ
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
ForTorActReactInLine >> fillpFpydot1: mat [ 
	| distIeJe uIeJeO tension kinedotIJs jointActions pFTpkinedotIJs pFTpJtActs kinedotIJ mpFTpkinedotIJ jointAction mpFTpJtAct |
	forTorAction fillpFpydot: mat.
	distIeJe := forTorAction distIeJe.
	uIeJeO := distIeJe uIeJeO.
	tension := forTorAction tension.
	kinedotIJs := tension kinedotIJs.
	jointActions := tension jointActions.
	pFTpkinedotIJs := tension pFTpkinedotIJs.
	pFTpJtActs := tension pFTpJtActs.
	1 to: kinedotIJs size
		do: 
			[:i | 
			kinedotIJ := kinedotIJs at: i.
			mpFTpkinedotIJ := 0.0d - (pFTpkinedotIJs at: i).
			forTorBasicJ
				fillpFpydot: mat
				pFTOpXdotj: (uIeJeO timesFullRow: kinedotIJ pvaluepXdotI times: mpFTpkinedotIJ)
				pFTOpEdotj: (uIeJeO timesFullRow: kinedotIJ pvaluepEdotI times: mpFTpkinedotIJ)
				partj: kinedotIJ partFrameI.
			forTorBasicJ
				fillpFpydot: mat
				pFTOpXdotj: (uIeJeO timesFullRow: kinedotIJ pvaluepXdotJ times: mpFTpkinedotIJ)
				pFTOpEdotj: (uIeJeO timesFullRow: kinedotIJ pvaluepEdotJ times: mpFTpkinedotIJ)
				partj: kinedotIJ partFrameJ].
	1 to: jointActions size
		do: 
			[:i | 
			jointAction := jointActions at: i.
			mpFTpJtAct := 0.0d - (pFTpJtActs at: i).
			forTorBasicJ fillpFpydot: mat pFTOpmudot: (uIeJeO timesSparseRow: jointAction pvalueplam times: mpFTpJtAct)]
]

{ #category : #dynamic }
ForTorActReactInLine >> fillpFpydot: mat [ 
	| distIeJe uIeJeO tension kinedotIJs jointActions pFTpkinedotIJs pFTpJtActs |
	forTorAction fillpFpydot: mat.
	distIeJe := forTorAction distIeJe.
	uIeJeO := distIeJe uIeJeO.
	tension := forTorAction tension.
	kinedotIJs := tension kinedotIJs.
	jointActions := tension jointActions.
	pFTpkinedotIJs := tension pFTpkinedotIJs.
	pFTpJtActs := tension pFTpJtActs.
	1 to: kinedotIJs size do: [:i | self
			fillpFpydot: mat
			pFTpfunction: (pFTpkinedotIJs at: i) negated
			function: (kinedotIJs at: i)].
	1 to: jointActions size do: [:i | forTorBasicJ fillpFpydot: mat pFTOpmudot: (uIeJeO timesSparseRow: (jointActions at: i) pvalueplam times: (pFTpJtActs at: i) negated)]
]

{ #category : #dynamic }
ForTorActReactInLine >> fillpFpydot: mat pFTpfunction: pFTpfunction function: function [ 
	| uIeJeO block |
	uIeJeO := forTorAction uIeJeO.
	block := [:pvaluepXdoti :pvaluepEdoti :partFramei | pvaluepXdoti == nil
				ifTrue: [pvaluepEdoti == nil ifFalse: [forTorBasicJ
							fillpFpydot: mat
							pFTOpEdotj: (uIeJeO timesFullRow: pvaluepEdoti times: pFTpfunction)
							partj: partFramei]]
				ifFalse: [pvaluepEdoti == nil
						ifTrue: [forTorBasicJ
								fillpFpydot: mat
								pFTOpXdotj: (uIeJeO timesFullRow: pvaluepXdoti times: pFTpfunction)
								partj: partFramei]
						ifFalse: [forTorBasicJ
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
ForTorActReactInLine >> forceOnFrmI: aFrmI andFrmJ: aFrmJ [ 
	forTorAction forceOnFrmI: aFrmI andFrmJ: aFrmJ.
	forTorBasicJ := ForceBasicqcVector new.
	forTorBasicJ parent: self.
	forTorBasicJ endFrame: aFrmJ
]

{ #category : #'initialize-release' }
ForTorActReactInLine >> initialize [
	forTorAction := ForTorActionInLine new
]

{ #category : #'initialize-release' }
ForTorActReactInLine >> initializeGlobally [
	forTorAction initializeGlobally.
	forTorBasicJ initializeGlobally
]

{ #category : #'initialize-release' }
ForTorActReactInLine >> initializeLocally [
	forTorAction initializeLocally.
	forTorBasicJ initializeLocally
]

{ #category : #accIC }
ForTorActReactInLine >> postAccICIteration [
	forTorAction postAccICIteration.
	forTorBasicJ postAccICIteration.
	super postAccICIteration
]

{ #category : #collision }
ForTorActReactInLine >> postCollisionCorrectorIteration [
	forTorAction postCollisionCorrectorIteration.
	forTorBasicJ postCollisionCorrectorIteration.
	super postCollisionCorrectorIteration
]

{ #category : #collision }
ForTorActReactInLine >> postCollisionPredictor [
	forTorAction postCollisionPredictor.
	forTorBasicJ postCollisionPredictor.
	super postCollisionPredictor
]

{ #category : #dynamic }
ForTorActReactInLine >> postDynCorrectorIteration [
	forTorAction postDynCorrectorIteration.
	forTorBasicJ postDynCorrectorIteration.
	super postDynCorrectorIteration
]

{ #category : #dynamic }
ForTorActReactInLine >> postDynOutput [
	forTorAction postDynOutput.
	forTorBasicJ postDynOutput.
	super postDynOutput
]

{ #category : #dynamic }
ForTorActReactInLine >> postDynPredictor [
	forTorAction postDynPredictor.
	forTorBasicJ postDynPredictor.
	super postDynPredictor
]

{ #category : #'input-output' }
ForTorActReactInLine >> postInput [
	forTorAction postInput.
	forTorBasicJ postInput.
	super postInput
]

{ #category : #static }
ForTorActReactInLine >> postStaticIteration [
	forTorAction postStaticIteration.
	forTorBasicJ postStaticIteration.
	super postStaticIteration
]

{ #category : #accIC }
ForTorActReactInLine >> preAccIC [
	forTorAction preAccIC.
	forTorBasicJ preAccIC.
	super preAccIC
]

{ #category : #dynamic }
ForTorActReactInLine >> preDynOutput [
	forTorAction preDynOutput.
	forTorBasicJ preDynOutput.
	super preDynOutput
]

{ #category : #static }
ForTorActReactInLine >> preStatic [
	forTorAction preStatic.
	forTorBasicJ preStatic.
	super preStatic
]

{ #category : #dynamic }
ForTorActReactInLine >> simUpdateAll [
	forTorAction simUpdateAll.
	forTorBasicJ simUpdateAll.
	super simUpdateAll
]

{ #category : #'initialize-release' }
ForTorActReactInLine >> torqueOnFrmI: aFrmI andFrmJ: aFrmJ [ 
	forTorAction torqueOnFrmI: aFrmI andFrmJ: aFrmJ.
	forTorBasicJ := TorqueBasicVector new.
	forTorBasicJ parent: self.
	forTorBasicJ endFrame: aFrmJ
]
