Class {
	#name : #ForceBasicqcVector,
	#superclass : #ForTorBasic,
	#instVars : [
		'iqX',
		'prOeOpET'
	],
	#category : #'StCAD-MbD-MbDForce'
}

{ #category : #'VisualWorks metadata' }
ForceBasicqcVector class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #calc }
ForceBasicqcVector >> calcPostDynCorrectorIteration [
	"rpep is not a constant for aMbDEndFrameqccq, qcs or qct."

	prOeOpET := endFrame prOeOpE transpose
]

{ #category : #accIC }
ForceBasicqcVector >> fillAccICIterError: col aFTO: aFTO [ 
	col at: iqX plusFullColumn: aFTO.
	col at: iqE plusFullColumn: (prOeOpET timesFullColumn: aFTO)
]

{ #category : #accIC }
ForceBasicqcVector >> fillAccICIterJacob: mat pFTOplam: pFTOplam [ 
	mat
		at: iqX
		and: 1
		plusSparseMatrix: pFTOplam.
	mat
		at: iqE
		and: 1
		plusSparseMatrix: (prOeOpET timesSparseMatrix: pFTOplam)
]

{ #category : #dynamic }
ForceBasicqcVector >> fillDynError: col aFTO: aFTO [ 
	col at: iqX plusFullColumn: aFTO.
	col at: iqE plusFullColumn: (prOeOpET timesFullColumn: aFTO)
]

{ #category : #dynamic }
ForceBasicqcVector >> fillpFpy: mat aFTO: aFTO [ 
	| pprOeOpEpE iqEm1 pprOeOpEpEi mati pprOeOpEpEij |
	pprOeOpEpE := endFrame pprOeOpEpE.
	iqEm1 := iqE - 1.
	1 to: 4
		do: 
			[:i | 
			pprOeOpEpEi := pprOeOpEpE at: i.
			mati := mat at: iqEm1 + i.
			1 to: 4
				do: 
					[:j | 
					pprOeOpEpEij := pprOeOpEpEi at: j.
					mati at: iqEm1 + j plusNumber: (pprOeOpEpEij dot: aFTO)]]
]

{ #category : #dynamic }
ForceBasicqcVector >> fillpFpy: mat pFTOpEj: pFTOpEj partj: partj [ 
	| iqEj |
	iqEj := partj iqE.
	mat
		at: iqX
		and: iqEj
		plusFullMatrix: pFTOpEj.
	mat
		at: iqE
		and: iqEj
		plusFullMatrix: (prOeOpET timesFullMatrix: pFTOpEj)
]

{ #category : #dynamic }
ForceBasicqcVector >> fillpFpy: mat pFTOpXj: pFTOpXj pFTOpEj: pFTOpEj partj: partj [ 
	self
		fillpFpy: mat
		pFTOpXj: pFTOpXj
		partj: partj.
	self
		fillpFpy: mat
		pFTOpEj: pFTOpEj
		partj: partj
]

{ #category : #dynamic }
ForceBasicqcVector >> fillpFpy: mat pFTOpXj: pFTOpXj partj: partj [ 
	| iqXj |
	iqXj := partj iqX.
	mat
		at: iqX
		and: iqXj
		plusFullMatrix: pFTOpXj.
	mat
		at: iqE
		and: iqXj
		plusFullMatrix: (prOeOpET timesFullMatrix: pFTOpXj)
]

{ #category : #dynamic }
ForceBasicqcVector >> fillpFpydot: mat pFTOpEdotj: pFTOpEdotj partj: partj [ 
	| iqEj |
	iqEj := partj iqE.
	mat
		at: iqX
		and: iqEj
		plusFullMatrix: pFTOpEdotj.
	mat
		at: iqE
		and: iqEj
		plusFullMatrix: (prOeOpET timesFullMatrix: pFTOpEdotj)
]

{ #category : #dynamic }
ForceBasicqcVector >> fillpFpydot: mat pFTOpXdotj: pFTOpXdotj pFTOpEdotj: pFTOpEdotj partj: partj [ 
	self
		fillpFpydot: mat
		pFTOpXdotj: pFTOpXdotj
		partj: partj.
	self
		fillpFpydot: mat
		pFTOpEdotj: pFTOpEdotj
		partj: partj
]

{ #category : #dynamic }
ForceBasicqcVector >> fillpFpydot: mat pFTOpXdotj: pFTOpXdotj partj: partj [ 
	| iqXj |
	iqXj := partj iqX.
	mat
		at: iqX
		and: iqXj
		plusFullMatrix: pFTOpXdotj.
	mat
		at: iqE
		and: iqXj
		plusFullMatrix: (prOeOpET timesFullMatrix: pFTOpXdotj)
]

{ #category : #dynamic }
ForceBasicqcVector >> fillpFpydot: mat pFTOpmudot: pFTOpmudot [ 
	mat
		at: iqX
		and: 1
		plusSparseMatrix: pFTOpmudot.
	mat
		at: iqE
		and: 1
		plusSparseMatrix: (prOeOpET timesSparseMatrix: pFTOpmudot)
]

{ #category : #'initialize-release' }
ForceBasicqcVector >> useEquationNumbers [
	super useEquationNumbers.
	iqX := endFrame partFrame iqX
]
