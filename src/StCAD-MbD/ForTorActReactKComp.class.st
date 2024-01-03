Class {
	#name : #ForTorActReactKComp,
	#superclass : #ForTorActReactComp,
	#instVars : [
		'aFTJeO'
	],
	#category : #'StCAD-MbD-MbDForce'
}

{ #category : #calc }
ForTorActReactKComp >> calcPostDynCorrectorIteration [
	aFTJeO := forTorAction aFTIeO negated
]

{ #category : #accIC }
ForTorActReactKComp >> fillAccICIterError: col [ 
	forTorAction fillAccICIterError: col.
	forTorBasicJ fillAccICIterError: col aFTO: aFTJeO
]

{ #category : #accIC }
ForTorActReactKComp >> fillAccICIterJacob: mat [ 
	| aAjOKe forTorFunction jointActions pFTpJtActs jointAction mpFTpJtAct |
	forTorAction fillAccICIterJacob: mat.
	aAjOKe := forTorAction aAjOKe.
	forTorFunction := forTorAction forTorFunction.
	jointActions := forTorFunction jointActions.
	pFTpJtActs := forTorFunction pFTpJtActs.
	1 to: jointActions size
		do: 
			[:i | 
			jointAction := jointActions at: i.
			mpFTpJtAct := (pFTpJtActs at: i) negated.
			forTorBasicJ fillAccICIterJacob: mat pFTOplam: (aAjOKe timesSparseRow: jointAction pvalueplam times: mpFTpJtAct)]
]

{ #category : #dynamic }
ForTorActReactKComp >> fillDynError: col [ 
	forTorAction fillDynError: col.
	forTorBasicJ fillDynError: col aFTO: aFTJeO
]

{ #category : #dynamic }
ForTorActReactKComp >> fillpFpy: mat [ 
	| forTorFunction kineIJs kinedotIJs jointActions pFTpkineIJs pFTpkinedotIJs pFTpJtActs kineIJ mpFTpkineIJ kinedotIJ mpFTpkinedotIJ jointAction mpFTpJtAct |
	forTorAction fillpFpy: mat.
	forTorFunction := forTorAction forTorFunction.
	kineIJs := forTorFunction kineIJs.
	kinedotIJs := forTorFunction kinedotIJs.
	jointActions := forTorFunction jointActions.
	pFTpkineIJs := forTorFunction pFTpkineIJs.
	pFTpkinedotIJs := forTorFunction pFTpkinedotIJs.
	pFTpJtActs := forTorFunction pFTpJtActs.
	forTorBasicJ fillpFpy: mat aFTO: aFTJeO.
	forTorBasicJ
		fillpFpy: mat
		pFTOpEj: ((forTorAction efrmK pAjOepE: forTorAction axis)
				times: forTorFunction forTor negated)
		partj: forTorAction pfrmK.
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
ForTorActReactKComp >> fillpFpy: mat pFTpfunction: pFTpfunction function: function [ 
	| pvaluepXI pvaluepEI partFrameI pvaluepXJ pvaluepEJ partFrameJ aAjOKe pvaluepXK pvaluepEK partFrameK |
	aAjOKe := forTorAction aAjOKe.
	pvaluepXI := function pvaluepXI.
	pvaluepEI := function pvaluepEI.
	partFrameI := function partFrameI.
	pvaluepXI == nil
		ifTrue: [pvaluepEI == nil ifFalse: [forTorBasicJ
					fillpFpy: mat
					pFTOpEj: (aAjOKe timesFullRow: pvaluepEI times: pFTpfunction)
					partj: partFrameI]]
		ifFalse: [pvaluepEI == nil
				ifTrue: [forTorBasicJ
						fillpFpy: mat
						pFTOpXj: (aAjOKe timesFullRow: pvaluepXI times: pFTpfunction)
						partj: partFrameI]
				ifFalse: [forTorBasicJ
						fillpFpy: mat
						pFTOpXj: (aAjOKe timesFullRow: pvaluepXI times: pFTpfunction)
						pFTOpEj: (aAjOKe timesFullRow: pvaluepEI times: pFTpfunction)
						partj: partFrameI]].
	pvaluepXJ := function pvaluepXJ.
	pvaluepEJ := function pvaluepEJ.
	partFrameJ := function partFrameJ.
	pvaluepXJ == nil
		ifTrue: [pvaluepEJ == nil ifFalse: [forTorBasicJ
					fillpFpy: mat
					pFTOpEj: (aAjOKe timesFullRow: pvaluepEJ times: pFTpfunction)
					partj: partFrameJ]]
		ifFalse: [pvaluepEJ == nil
				ifTrue: [forTorBasicJ
						fillpFpy: mat
						pFTOpXj: (aAjOKe timesFullRow: pvaluepXJ times: pFTpfunction)
						partj: partFrameJ]
				ifFalse: [forTorBasicJ
						fillpFpy: mat
						pFTOpXj: (aAjOKe timesFullRow: pvaluepXJ times: pFTpfunction)
						pFTOpEj: (aAjOKe timesFullRow: pvaluepEJ times: pFTpfunction)
						partj: partFrameJ]].
	pvaluepXK := function pvaluepXK.
	pvaluepEK := function pvaluepEK.
	partFrameK := function partFrameK.
	pvaluepXK == nil
		ifTrue: [pvaluepEK == nil ifFalse: [forTorBasicJ
					fillpFpy: mat
					pFTOpEj: (aAjOKe timesFullRow: pvaluepEK times: pFTpfunction)
					partj: partFrameK]]
		ifFalse: [pvaluepEK == nil
				ifTrue: [forTorBasicJ
						fillpFpy: mat
						pFTOpXj: (aAjOKe timesFullRow: pvaluepXK times: pFTpfunction)
						partj: partFrameK]
				ifFalse: [forTorBasicJ
						fillpFpy: mat
						pFTOpXj: (aAjOKe timesFullRow: pvaluepXK times: pFTpfunction)
						pFTOpEj: (aAjOKe timesFullRow: pvaluepEK times: pFTpfunction)
						partj: partFrameK]]
]

{ #category : #dynamic }
ForTorActReactKComp >> fillpFpydot: mat [ 
	| aAjOKe forTorFunction kinedotIJs jointActions pFTpkinedotIJs pFTpJtActs kinedotIJ mpFTpkinedotIJ jointAction mpFTpJtAct |
	forTorAction fillpFpydot: mat.
	aAjOKe := forTorAction aAjOKe.
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
			forTorBasicJ fillpFpydot: mat pFOpmudot: (aAjOKe timesSparseRow: jointAction pvalueplam times: mpFTpJtAct)]
]

{ #category : #dynamic }
ForTorActReactKComp >> fillpFpydot: mat pFTpfunction: pFTpfunction function: function [ 
	| pvaluepXdotI pvaluepEdotI partFrameI pvaluepXdotJ pvaluepEdotJ partFrameJ aAjOKe |
	aAjOKe := forTorAction aAjOKe.
	pvaluepXdotI := function pvaluepXdotI.
	pvaluepEdotI := function pvaluepEdotI.
	partFrameI := function partFrameI.
	pvaluepXdotI == nil
		ifTrue: [pvaluepEdotI == nil ifFalse: [forTorBasicJ
					fillpFpydot: mat
					pFTOpEdotj: (aAjOKe timesFullRow: pvaluepEdotI times: pFTpfunction)
					partj: partFrameI]]
		ifFalse: [pvaluepEdotI == nil
				ifTrue: [forTorBasicJ
						fillpFpydot: mat
						pFTOpXdotj: (aAjOKe timesFullRow: pvaluepXdotI times: pFTpfunction)
						partj: partFrameI]
				ifFalse: [forTorBasicJ
						fillpFpydot: mat
						pFTOpXdotj: (aAjOKe timesFullRow: pvaluepXdotI times: pFTpfunction)
						pFTOpEdotj: (aAjOKe timesFullRow: pvaluepEdotI times: pFTpfunction)
						partj: partFrameI]].
	pvaluepXdotJ := function pvaluepXdotJ.
	pvaluepEdotJ := function pvaluepEdotJ.
	partFrameJ := function partFrameJ.
	pvaluepXdotJ == nil
		ifTrue: [pvaluepEdotJ == nil ifFalse: [forTorBasicJ
					fillpFpydot: mat
					pFTOpEdotj: (aAjOKe timesFullRow: pvaluepEdotJ times: pFTpfunction)
					partj: partFrameJ]]
		ifFalse: [pvaluepEdotJ == nil
				ifTrue: [forTorBasicJ
						fillpFpydot: mat
						pFTOpXdotj: (aAjOKe timesFullRow: pvaluepXdotJ times: pFTpfunction)
						partj: partFrameJ]
				ifFalse: [forTorBasicJ
						fillpFpydot: mat
						pFTOpXdotj: (aAjOKe timesFullRow: pvaluepXdotJ times: pFTpfunction)
						pFTOpEdotj: (aAjOKe timesFullRow: pvaluepEdotJ times: pFTpfunction)
						partj: partFrameJ]]
]

{ #category : #'initialize-release' }
ForTorActReactKComp >> forceOnFrmI: aFrmI andFrmJ: aFrmJ wrtFrmK: aFrmK axis: i [ 
	forTorAction
		forceOnFrmI: aFrmI
		wrtFrmK: aFrmK
		axis: i.
	forTorBasicJ := ForceBasicqccqVector new.
	forTorBasicJ parent: self.
	forTorBasicJ endFrame: aFrmJ followEndFrame: aFrmI
]

{ #category : #'initialize-release' }
ForTorActReactKComp >> initialize [
	forTorAction := ForTorActionKComp new
]

{ #category : #'initialize-release' }
ForTorActReactKComp >> torqueOnFrmI: aFrmI andFrmJ: aFrmJ wrtFrmK: aFrmK axis: i [ 
	forTorAction
		torqueOnFrmI: aFrmI
		wrtFrmK: aFrmK
		axis: i.
	forTorBasicJ := TorqueBasicVector new.
	forTorBasicJ parent: self.
	forTorBasicJ endFrame: aFrmJ
]
