Class {
	#name : #ForTorActionOComp,
	#superclass : #ForTorActionComp,
	#instVars : [
		'aFTIeOi'
	],
	#category : #'StCAD-MbD-MbDForce'
}

{ #category : #accessing }
ForTorActionOComp >> aFTIeO [
	| answer |
	answer := (FullColumn zero: 3).
	answer at: axis put: aFTIeOi.
	^answer
]

{ #category : #accessing }
ForTorActionOComp >> aFTIeOi [
	^aFTIeOi
]

{ #category : #calc }
ForTorActionOComp >> calcPostDynCorrectorIteration [
	aFTIeOi := forTorFunction forTor
]

{ #category : #accIC }
ForTorActionOComp >> fillAccICIterError: col [ 
	forTorBasicI fillAccICIterError: col aFTOi: aFTIeOi
]

{ #category : #accIC }
ForTorActionOComp >> fillAccICIterJacob: mat [ 
	| jointActions pFTpJtActs jointAction pFTpJtAct |
	jointActions := forTorFunction jointActions.
	pFTpJtActs := forTorFunction pFTpJtActs.
	1 to: jointActions size
		do: 
			[:i | 
			jointAction := jointActions at: i.
			pFTpJtAct := pFTpJtActs at: i.
			forTorBasicI fillAccICIterJacob: mat pFTOiplam: (jointAction pvalueplam times: pFTpJtAct)]
]

{ #category : #dynamic }
ForTorActionOComp >> fillDynError: col [ 
	forTorBasicI fillDynError: col aFTOi: aFTIeOi
]

{ #category : #dynamic }
ForTorActionOComp >> fillpFpy: mat [ 
	| kineIJs kinedotIJs jointActions pFTpkineIJs pFTpkinedotIJs pFTpJtActs kineIJ pFTpkineIJ kinedotIJ pFTpkinedotIJ jointAction pFTpJtAct |
	kineIJs := forTorFunction kineIJs.
	kinedotIJs := forTorFunction kinedotIJs.
	jointActions := forTorFunction jointActions.
	pFTpkineIJs := forTorFunction pFTpkineIJs.
	pFTpkinedotIJs := forTorFunction pFTpkinedotIJs.
	pFTpJtActs := forTorFunction pFTpJtActs.
	forTorBasicI fillpFpy: mat aFTOi: aFTIeOi.
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
ForTorActionOComp >> fillpFpy: mat pFTpfunction: pFTpfunction function: function [ 
	"function is in a user defined function. Therefore it is a function of 
	its I,J,K which may be different 
	from the I,J,K of the holder."

	| pvaluepXI pvaluepEI partFrameI pvaluepXJ pvaluepEJ partFrameJ pvaluepXK pvaluepEK partFrameK |
	pvaluepXI := function pvaluepXI.
	pvaluepEI := function pvaluepEI.
	partFrameI := function partFrameI.
	pvaluepXI == nil
		ifTrue: [pvaluepEI == nil ifFalse: [forTorBasicI
					fillpFpy: mat
					pFTOipEj: (pvaluepEI times: pFTpfunction)
					partj: partFrameI]]
		ifFalse: [pvaluepEI == nil
				ifTrue: [forTorBasicI
						fillpFpy: mat
						pFTOipXj: (pvaluepXI times: pFTpfunction)
						partj: partFrameI]
				ifFalse: [forTorBasicI
						fillpFpy: mat
						pFTOipXj: (pvaluepXI times: pFTpfunction)
						pFTOipEj: (pvaluepEI times: pFTpfunction)
						partj: partFrameI]].
	pvaluepXJ := function pvaluepXJ.
	pvaluepEJ := function pvaluepEJ.
	partFrameJ := function partFrameJ.
	pvaluepXJ == nil
		ifTrue: [pvaluepEJ == nil ifFalse: [forTorBasicI
					fillpFpy: mat
					pFTOipEj: (pvaluepEJ times: pFTpfunction)
					partj: partFrameJ]]
		ifFalse: [pvaluepEJ == nil
				ifTrue: [forTorBasicI
						fillpFpy: mat
						pFTOipXj: (pvaluepXJ times: pFTpfunction)
						partj: partFrameJ]
				ifFalse: [forTorBasicI
						fillpFpy: mat
						pFTOipXj: (pvaluepXJ times: pFTpfunction)
						pFTOipEj: (pvaluepEJ times: pFTpfunction)
						partj: partFrameJ]].
	pvaluepXK := function pvaluepXK.
	pvaluepEK := function pvaluepEK.
	partFrameK := function partFrameK.
	pvaluepXK == nil
		ifTrue: [pvaluepEK == nil ifFalse: [forTorBasicI
					fillpFpy: mat
					pFTOipEj: (pvaluepEK times: pFTpfunction)
					partj: partFrameK]]
		ifFalse: [pvaluepEK == nil
				ifTrue: [forTorBasicI
						fillpFpy: mat
						pFTOipXj: (pvaluepXK times: pFTpfunction)
						partj: partFrameK]
				ifFalse: [forTorBasicI
						fillpFpy: mat
						pFTOipXj: (pvaluepXK times: pFTpfunction)
						pFTOipEj: (pvaluepEK times: pFTpfunction)
						partj: partFrameK]]
]

{ #category : #dynamic }
ForTorActionOComp >> fillpFpydot: mat [ 
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
			forTorBasicI fillpFpydot: mat pFOipmudot: (jointAction pvalueplam times: pFTpJtAct)]
]

{ #category : #dynamic }
ForTorActionOComp >> fillpFpydot: mat pFTpfunction: pFTpfunction function: function [ 
	| pvaluepXdotI pvaluepEdotI partFrameI pvaluepXdotJ pvaluepEdotJ partFrameJ |
	pvaluepXdotI := function pvaluepXdotI.
	pvaluepEdotI := function pvaluepEdotI.
	partFrameI := function partFrameI.
	pvaluepXdotI == nil
		ifTrue: [pvaluepEdotI == nil ifFalse: [forTorBasicI
					fillpFpydot: mat
					pFTOipEdotj: (pvaluepEdotI times: pFTpfunction)
					partj: partFrameI]]
		ifFalse: [pvaluepEdotI == nil
				ifTrue: [forTorBasicI
						fillpFpydot: mat
						pFTOipXdotj: (pvaluepXdotI times: pFTpfunction)
						partj: partFrameI]
				ifFalse: [forTorBasicI
						fillpFpydot: mat
						pFTOipXdotj: (pvaluepXdotI times: pFTpfunction)
						pFTOipEdotj: (pvaluepEdotI times: pFTpfunction)
						partj: partFrameI]].
	pvaluepXdotJ := function pvaluepXdotJ.
	pvaluepEdotJ := function pvaluepEdotJ.
	partFrameJ := function partFrameJ.
	pvaluepXdotJ == nil
		ifTrue: [pvaluepEdotJ == nil ifFalse: [forTorBasicI
					fillpFpydot: mat
					pFTOipEdotj: (pvaluepEdotJ times: pFTpfunction)
					partj: partFrameJ]]
		ifFalse: [pvaluepEdotJ == nil
				ifTrue: [forTorBasicI
						fillpFpydot: mat
						pFTOipXdotj: (pvaluepXdotJ times: pFTpfunction)
						partj: partFrameJ]
				ifFalse: [forTorBasicI
						fillpFpydot: mat
						pFTOipXdotj: (pvaluepXdotJ times: pFTpfunction)
						pFTOipEdotj: (pvaluepEdotJ times: pFTpfunction)
						partj: partFrameJ]]
]

{ #category : #'initialize-release' }
ForTorActionOComp >> forceOnFrmI: efrm1 axis: i [ 
	axis := i.
	forTorBasicI := ForceBasicqcComp new.
	forTorBasicI parent: self.
	forTorBasicI endFrame: efrm1
]

{ #category : #'initialize-release' }
ForTorActionOComp >> torqueOnFrmI: efrm1 axis: i [ 
	axis := i.
	forTorBasicI := TorqueBasicComp new.
	forTorBasicI parent: self.
	forTorBasicI endFrame: efrm1
]
