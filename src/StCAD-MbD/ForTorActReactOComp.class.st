Class {
	#name : #ForTorActReactOComp,
	#superclass : #ForTorActReactComp,
	#instVars : [
		'aFTJeOi'
	],
	#category : #'StCAD-MbD-MbDForce'
}

{ #category : #calc }
ForTorActReactOComp >> calcPostDynCorrectorIteration [
	aFTJeOi := forTorAction aFTIeOi negated
]

{ #category : #accIC }
ForTorActReactOComp >> fillAccICIterError: col [ 
	forTorAction fillAccICIterError: col.
	forTorBasicJ fillAccICIterError: col aFTOi: aFTJeOi
]

{ #category : #accIC }
ForTorActReactOComp >> fillAccICIterJacob: mat [ 
	| forTorFunction jointActions pFTpJtActs jointAction mpFTpJtAct |
	forTorAction fillAccICIterJacob: mat.
	forTorFunction := forTorAction forTorFunction.
	jointActions := forTorFunction jointActions.
	pFTpJtActs := forTorFunction pFTpJtActs.
	1 to: jointActions size
		do: 
			[:i | 
			jointAction := jointActions at: i.
			mpFTpJtAct := (pFTpJtActs at: i) negated.
			forTorBasicJ fillAccICIterJacob: mat pFTOiplam: (jointAction pvalueplam times: mpFTpJtAct)]
]

{ #category : #dynamic }
ForTorActReactOComp >> fillDynError: col [ 
	forTorAction fillDynError: col.
	forTorBasicJ fillDynError: col aFTOi: aFTJeOi
]

{ #category : #dynamic }
ForTorActReactOComp >> fillpFpy: mat [ 
	| forTorFunction kineIJs kinedotIJs jointActions pFTpkineIJs pFTpkinedotIJs pFTpJtActs kineIJ mpFTpkineIJ kinedotIJ mpFTpkinedotIJ jointAction mpFTpJtAct |
	forTorAction fillpFpy: mat.
	forTorFunction := forTorAction forTorFunction.
	kineIJs := forTorFunction kineIJs.
	kinedotIJs := forTorFunction kinedotIJs.
	jointActions := forTorFunction jointActions.
	pFTpkineIJs := forTorFunction pFTpkineIJs.
	pFTpkinedotIJs := forTorFunction pFTpkinedotIJs.
	pFTpJtActs := forTorFunction pFTpJtActs.
	forTorBasicJ fillpFpy: mat aFTOi: aFTJeOi.
	1 to: kineIJs size
		do: 
			[:i | 
			kineIJ := kineIJs at: i.
			mpFTpkineIJ := (pFTpkineIJs at: i) negated.
			self
				fillpFpy: mat
				pFTpfunction: mpFTpkineIJ
				function: kineIJ].
	1 to: kinedotIJs size
		do: 
			[:i | 
			kinedotIJ := kinedotIJs at: i.
			mpFTpkinedotIJ := (pFTpkinedotIJs at: i) negated.
			self
				fillpFpy: mat
				pFTpfunction: mpFTpkinedotIJ
				function: kinedotIJ].
	1 to: jointActions size
		do: 
			[:i | 
			jointAction := jointActions at: i.
			mpFTpJtAct := (pFTpJtActs at: i) negated.
			self
				fillpFpy: mat
				pFTpfunction: mpFTpJtAct
				function: jointAction]
]

{ #category : #dynamic }
ForTorActReactOComp >> fillpFpy: mat pFTpfunction: pFTpfunction function: function [ 
	"function is in a user defined function. Therefore it is a function of 
	its I,J,K which may be different 
	from the I,J,K of the holder."

	| pvaluepXI pvaluepEI partFrameI pvaluepXJ pvaluepEJ partFrameJ pvaluepXK pvaluepEK partFrameK |
	pvaluepXI := function pvaluepXI.
	pvaluepEI := function pvaluepEI.
	partFrameI := function partFrameI.
	pvaluepXI == nil
		ifTrue: [pvaluepEI == nil ifFalse: [forTorBasicJ
					fillpFpy: mat
					pFTOipEj: (pvaluepEI times: pFTpfunction)
					partj: partFrameI]]
		ifFalse: [pvaluepEI == nil
				ifTrue: [forTorBasicJ
						fillpFpy: mat
						pFTOipXj: (pvaluepXI times: pFTpfunction)
						partj: partFrameI]
				ifFalse: [forTorBasicJ
						fillpFpy: mat
						pFTOipXj: (pvaluepXI times: pFTpfunction)
						pFTOipEj: (pvaluepEI times: pFTpfunction)
						partj: partFrameI]].
	pvaluepXJ := function pvaluepXJ.
	pvaluepEJ := function pvaluepEJ.
	partFrameJ := function partFrameJ.
	pvaluepXJ == nil
		ifTrue: [pvaluepEJ == nil ifFalse: [forTorBasicJ
					fillpFpy: mat
					pFTOipEj: (pvaluepEJ times: pFTpfunction)
					partj: partFrameJ]]
		ifFalse: [pvaluepEJ == nil
				ifTrue: [forTorBasicJ
						fillpFpy: mat
						pFTOipXj: (pvaluepXJ times: pFTpfunction)
						partj: partFrameJ]
				ifFalse: [forTorBasicJ
						fillpFpy: mat
						pFTOipXj: (pvaluepXJ times: pFTpfunction)
						pFTOipEj: (pvaluepEJ times: pFTpfunction)
						partj: partFrameJ]].
	pvaluepXK := function pvaluepXK.
	pvaluepEK := function pvaluepEK.
	partFrameK := function partFrameK.
	pvaluepXK == nil
		ifTrue: [pvaluepEK == nil ifFalse: [forTorBasicJ
					fillpFpy: mat
					pFTOipEj: (pvaluepEK times: pFTpfunction)
					partj: partFrameK]]
		ifFalse: [pvaluepEK == nil
				ifTrue: [forTorBasicJ
						fillpFpy: mat
						pFTOipXj: (pvaluepXK times: pFTpfunction)
						partj: partFrameK]
				ifFalse: [forTorBasicJ
						fillpFpy: mat
						pFTOipXj: (pvaluepXK times: pFTpfunction)
						pFTOipEj: (pvaluepEK times: pFTpfunction)
						partj: partFrameK]]
]

{ #category : #dynamic }
ForTorActReactOComp >> fillpFpydot: mat [ 
	| forTorFunction kinedotIJs jointActions pFTpkinedotIJs pFTpJtActs kinedotIJ mpFTpkinedotIJ jointAction mpFTpJtAct |
	forTorAction fillpFpydot: mat.
	forTorFunction := forTorAction forTorFunction.
	kinedotIJs := forTorFunction kinedotIJs.
	jointActions := forTorFunction jointActions.
	pFTpkinedotIJs := forTorFunction pFTpkinedotIJs.
	pFTpJtActs := forTorFunction pFTpJtActs.
	1 to: kinedotIJs size
		do: 
			[:i | 
			kinedotIJ := kinedotIJs at: i.
			mpFTpkinedotIJ := (pFTpkinedotIJs at: i) negated.
			self
				fillpFpydot: mat
				pFTpfunction: mpFTpkinedotIJ
				function: kinedotIJ].
	1 to: jointActions size
		do: 
			[:i | 
			jointAction := jointActions at: i.
			mpFTpJtAct := (pFTpJtActs at: i) negated.
			forTorBasicJ fillpFpydot: mat pFTOipmudot: (jointAction pvalueplam times: mpFTpJtAct)]
]

{ #category : #dynamic }
ForTorActReactOComp >> fillpFpydot: mat pFTpfunction: pFTpfunction function: function [ 
	| pvaluepXdotI pvaluepEdotI partFrameI pvaluepXdotJ pvaluepEdotJ partFrameJ |
	pvaluepXdotI := function pvaluepXdotI.
	pvaluepEdotI := function pvaluepEdotI.
	partFrameI := function partFrameI.
	pvaluepXdotI == nil
		ifTrue: [pvaluepEdotI == nil ifFalse: [forTorBasicJ
					fillpFpydot: mat
					pFTOipEdotj: (pvaluepEdotI times: pFTpfunction)
					partj: partFrameI]]
		ifFalse: [pvaluepEdotI == nil
				ifTrue: [forTorBasicJ
						fillpFpydot: mat
						pFTOipXdotj: (pvaluepXdotI times: pFTpfunction)
						partj: partFrameI]
				ifFalse: [forTorBasicJ
						fillpFpydot: mat
						pFTOipXdotj: (pvaluepXdotI times: pFTpfunction)
						pFTOipEdotj: (pvaluepEdotI times: pFTpfunction)
						partj: partFrameI]].
	pvaluepXdotJ := function pvaluepXdotJ.
	pvaluepEdotJ := function pvaluepEdotJ.
	partFrameJ := function partFrameJ.
	pvaluepXdotJ == nil
		ifTrue: [pvaluepEdotJ == nil ifFalse: [forTorBasicJ
					fillpFpydot: mat
					pFTOipEdotj: (pvaluepEdotJ times: pFTpfunction)
					partj: partFrameJ]]
		ifFalse: [pvaluepEdotJ == nil
				ifTrue: [forTorBasicJ
						fillpFpydot: mat
						pFTOipXdotj: (pvaluepXdotJ times: pFTpfunction)
						partj: partFrameJ]
				ifFalse: [forTorBasicJ
						fillpFpydot: mat
						pFTOipXdotj: (pvaluepXdotJ times: pFTpfunction)
						pFTOipEdotj: (pvaluepEdotJ times: pFTpfunction)
						partj: partFrameJ]]
]

{ #category : #'initialize-release' }
ForTorActReactOComp >> forceOnFrmI: aFrmI andFrmJ: aFrmJ axis: axis [ 
	forTorAction forceOnFrmI: aFrmI axis: axis.
	forTorBasicJ := ForceBasicqccqComp new.
	forTorBasicJ parent: self.
	forTorBasicJ endFrame: aFrmJ followEndFrame: aFrmI
]

{ #category : #'initialize-release' }
ForTorActReactOComp >> initialize [
	forTorAction := ForTorActionOComp new
]

{ #category : #'initialize-release' }
ForTorActReactOComp >> torqueOnFrmI: aFrmI andFrmJ: aFrmJ axis: axis [ 
	forTorAction torqueOnFrmI: aFrmI axis: axis.
	forTorBasicJ := TorqueBasicComp new.
	forTorBasicJ parent: self.
	forTorBasicJ endFrame: aFrmJ
]
