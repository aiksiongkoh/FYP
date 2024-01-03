Class {
	#name : #ForTorActionKComp,
	#superclass : #ForTorActionComp,
	#instVars : [
		'aFTIeO',
		'efrmK',
		'aAjOKe'
	],
	#category : #'StCAD-MbD-MbDForce'
}

{ #category : #accessing }
ForTorActionKComp >> aAjOKe [
	^aAjOKe
]

{ #category : #accessing }
ForTorActionKComp >> aFTIeO [
	^aFTIeO
]

{ #category : #calc }
ForTorActionKComp >> calcPostDynCorrectorIteration [
	aAjOKe := efrmK aAjOe: axis.
	aFTIeO := aAjOKe times: forTorFunction forTor
]

{ #category : #accessing }
ForTorActionKComp >> efrmK [
	^efrmK
]

{ #category : #accIC }
ForTorActionKComp >> fillAccICIterError: col [ 
	forTorBasicI fillAccICIterError: col aFTO: aFTIeO
]

{ #category : #accIC }
ForTorActionKComp >> fillAccICIterJacob: mat [ 
	| jointActions pFTpJtActs jointAction pFTpJtAct |
	jointActions := forTorFunction jointActions.
	pFTpJtActs := forTorFunction pFTpJtActs.
	1 to: jointActions size
		do: 
			[:i | 
			jointAction := jointActions at: i.
			pFTpJtAct := pFTpJtActs at: i.
			forTorBasicI fillAccICIterJacob: mat pFTOplam: (aAjOKe timesSparseRow: jointAction pvalueplam times: pFTpJtAct)]
]

{ #category : #dynamic }
ForTorActionKComp >> fillDynError: col [ 
	forTorBasicI fillDynError: col aFTO: aFTIeO
]

{ #category : #dynamic }
ForTorActionKComp >> fillpFpy: mat [ 
	| kineIJs kinedotIJs jointActions pFTpkineIJs pFTpkinedotIJs pFTpJtActs kineIJ pFTpkineIJ kinedotIJ pFTpkinedotIJ jointAction pFTpJtAct |
	kineIJs := forTorFunction kineIJs.
	kinedotIJs := forTorFunction kinedotIJs.
	jointActions := forTorFunction jointActions.
	pFTpkineIJs := forTorFunction pFTpkineIJs.
	pFTpkinedotIJs := forTorFunction pFTpkinedotIJs.
	pFTpJtActs := forTorFunction pFTpJtActs.
	forTorBasicI fillpFpy: mat aFTO: aFTIeO.
	forTorBasicI
		fillpFpy: mat
		pFTOpEj: ((efrmK pAjOepE: axis)
				times: forTorFunction forTor)
		partj: self pfrmK.
	1 to: kineIJs size
		do: 
			[:i | 
			kineIJ := kineIJs at: i.
			pFTpkineIJ := pFTpkineIJs at: i.
			self
				fillpFpy: mat
				pFTpfunction: pFTpkineIJ
				function: kineIJ].
	1 to: kinedotIJs size
		do: 
			[:i | 
			kinedotIJ := kinedotIJs at: i.
			pFTpkinedotIJ := pFTpkinedotIJs at: i.
			self
				fillpFpy: mat
				pFTpfunction: pFTpkinedotIJ
				function: kinedotIJ].
	1 to: jointActions size
		do: 
			[:i | 
			jointAction := jointActions at: i.
			pFTpJtAct := pFTpJtActs at: i.
			self
				fillpFpy: mat
				pFTpfunction: pFTpJtAct
				function: jointAction]
]

{ #category : #dynamic }
ForTorActionKComp >> fillpFpy: mat pFTpfunction: pFTpfunction function: function [ 
	| pvaluepXI pvaluepEI partFrameI pvaluepXJ pvaluepEJ partFrameJ pvaluepXK pvaluepEK partFrameK |
	pvaluepXI := function pvaluepXI.
	pvaluepEI := function pvaluepEI.
	partFrameI := function partFrameI.
	pvaluepXI == nil
		ifTrue: [pvaluepEI == nil ifFalse: [forTorBasicI
					fillpFpy: mat
					pFTOpEj: (aAjOKe timesFullRow: pvaluepEI times: pFTpfunction)
					partj: partFrameI]]
		ifFalse: [pvaluepEI == nil
				ifTrue: [forTorBasicI
						fillpFpy: mat
						pFTOpXj: (aAjOKe timesFullRow: pvaluepXI times: pFTpfunction)
						partj: partFrameI]
				ifFalse: [forTorBasicI
						fillpFpy: mat
						pFTOpXj: (aAjOKe timesFullRow: pvaluepXI times: pFTpfunction)
						pFTOpEj: (aAjOKe timesFullRow: pvaluepEI times: pFTpfunction)
						partj: partFrameI]].
	pvaluepXJ := function pvaluepXJ.
	pvaluepEJ := function pvaluepEJ.
	partFrameJ := function partFrameJ.
	pvaluepXJ == nil
		ifTrue: [pvaluepEJ == nil ifFalse: [forTorBasicI
					fillpFpy: mat
					pFTOpEj: (aAjOKe timesFullRow: pvaluepEJ times: pFTpfunction)
					partj: partFrameJ]]
		ifFalse: [pvaluepEJ == nil
				ifTrue: [forTorBasicI
						fillpFpy: mat
						pFTOpXj: (aAjOKe timesFullRow: pvaluepXJ times: pFTpfunction)
						partj: partFrameJ]
				ifFalse: [forTorBasicI
						fillpFpy: mat
						pFTOpXj: (aAjOKe timesFullRow: pvaluepXJ times: pFTpfunction)
						pFTOpEj: (aAjOKe timesFullRow: pvaluepEJ times: pFTpfunction)
						partj: partFrameJ]].
	pvaluepXK := function pvaluepXK.
	pvaluepEK := function pvaluepEK.
	partFrameK := function partFrameK.
	pvaluepXK == nil
		ifTrue: [pvaluepEK == nil ifFalse: [forTorBasicI
					fillpFpy: mat
					pFTOpEj: (aAjOKe timesFullRow: pvaluepEK times: pFTpfunction)
					partj: partFrameK]]
		ifFalse: [pvaluepEK == nil
				ifTrue: [forTorBasicI
						fillpFpy: mat
						pFTOpXj: (aAjOKe timesFullRow: pvaluepXK times: pFTpfunction)
						partj: partFrameK]
				ifFalse: [forTorBasicI
						fillpFpy: mat
						pFTOpXj: (aAjOKe timesFullRow: pvaluepXK times: pFTpfunction)
						pFTOpEj: (aAjOKe timesFullRow: pvaluepEK times: pFTpfunction)
						partj: partFrameK]]
]

{ #category : #dynamic }
ForTorActionKComp >> fillpFpydot: mat [ 
	| kinedotIJs jointActions pFTpkinedotIJs pFTpJtActs kinedotIJ pFTpkinedotIJ jointAction pFTpJtAct |
	kinedotIJs := forTorFunction kinedotIJs.
	jointActions := forTorFunction jointActions.
	pFTpkinedotIJs := forTorFunction pFTpkinedotIJs.
	pFTpJtActs := forTorFunction pFTpJtActs.
	1 to: kinedotIJs size
		do: 
			[:i | 
			kinedotIJ := kinedotIJs at: i.
			pFTpkinedotIJ := pFTpkinedotIJs at: i.
			self
				fillpFpydot: mat
				pFTpfunction: pFTpkinedotIJ
				function: kinedotIJ].
	1 to: jointActions size
		do: 
			[:i | 
			jointAction := jointActions at: i.
			pFTpJtAct := pFTpJtActs at: i.
			forTorBasicI fillpFpydot: mat pFOpmudot: (aAjOKe timesSparseRow: jointAction pvalueplam times: pFTpJtAct)]
]

{ #category : #dynamic }
ForTorActionKComp >> fillpFpydot: mat pFTpfunction: pFTpfunction function: function [ 
	| pvaluepXdotI pvaluepEdotI partFrameI pvaluepXdotJ pvaluepEdotJ partFrameJ |
	pvaluepXdotI := function pvaluepXdotI.
	pvaluepEdotI := function pvaluepEdotI.
	partFrameI := function partFrameI.
	pvaluepXdotI == nil
		ifTrue: [pvaluepEdotI == nil ifFalse: [forTorBasicI
					fillpFpydot: mat
					pFTOpEdotj: (aAjOKe timesFullRow: pvaluepEdotI times: pFTpfunction)
					partj: partFrameI]]
		ifFalse: [pvaluepEdotI == nil
				ifTrue: [forTorBasicI
						fillpFpydot: mat
						pFTOpXdotj: (aAjOKe timesFullRow: pvaluepXdotI times: pFTpfunction)
						partj: partFrameI]
				ifFalse: [forTorBasicI
						fillpFpydot: mat
						pFTOpXdotj: (aAjOKe timesFullRow: pvaluepXdotI times: pFTpfunction)
						pFTOpEdotj: (aAjOKe timesFullRow: pvaluepEdotI times: pFTpfunction)
						partj: partFrameI]].
	pvaluepXdotJ := function pvaluepXdotJ.
	pvaluepEdotJ := function pvaluepEdotJ.
	partFrameJ := function partFrameJ.
	pvaluepXdotJ == nil
		ifTrue: [pvaluepEdotJ == nil ifFalse: [forTorBasicI
					fillpFpydot: mat
					pFTOpEdotj: (aAjOKe timesFullRow: pvaluepEdotJ times: pFTpfunction)
					partj: partFrameJ]]
		ifFalse: [pvaluepEdotJ == nil
				ifTrue: [forTorBasicI
						fillpFpydot: mat
						pFTOpXdotj: (aAjOKe timesFullRow: pvaluepXdotJ times: pFTpfunction)
						partj: partFrameJ]
				ifFalse: [forTorBasicI
						fillpFpydot: mat
						pFTOpXdotj: (aAjOKe timesFullRow: pvaluepXdotJ times: pFTpfunction)
						pFTOpEdotj: (aAjOKe timesFullRow: pvaluepEdotJ times: pFTpfunction)
						partj: partFrameJ]]
]

{ #category : #'initialize-release' }
ForTorActionKComp >> forceOnFrmI: efrmi wrtFrmK: efrmk axis: i [ 
	forTorBasicI := ForceBasicqcVector new.
	forTorBasicI parent: self.
	forTorBasicI endFrame: efrmi.
	axis := i.
	efrmK := efrmk
]

{ #category : #accessing }
ForTorActionKComp >> pfrmK [
	^efrmK partFrame
]

{ #category : #'initialize-release' }
ForTorActionKComp >> torqueOnFrmI: efrmi wrtFrmK: efrmk axis: i [ 
	forTorBasicI := TorqueBasicVector new.
	forTorBasicI parent: self.
	forTorBasicI endFrame: efrmi.
	axis := i.
	efrmK := efrmk
]
