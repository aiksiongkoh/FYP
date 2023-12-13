Class {
	#name : #ForceBasicqcComp,
	#superclass : #ForTorBasic,
	#instVars : [
		'iqXaxis',
		'prOeOaxispET'
	],
	#category : #'StCAD-MbD-MbDForce'
}

{ #category : #'VisualWorks metadata' }
ForceBasicqcComp class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #calc }
ForceBasicqcComp >> calcPostDynCorrectorIteration [
	"rpep is not a constant for aMbDEndFrameqccq, qcs or qct."

	prOeOaxispET := (endFrame prOeOpE at: parent axis) transpose
]

{ #category : #accIC }
ForceBasicqcComp >> fillAccICIterError: col aFTOi: aFTOi [ 
	col at: iqXaxis plusNumber: aFTOi.
	col at: iqE plusFullColumn: (prOeOaxispET times: aFTOi)
]

{ #category : #accIC }
ForceBasicqcComp >> fillAccICIterJacob: mat pFTOiplam: pFTOiplam [ 
	mat
		at: iqXaxis
		and: 1
		plusSparseRow: pFTOiplam.
	mat
		at: iqE
		and: 1
		plusSparseMatrix: (prOeOaxispET timesSparseRow: pFTOiplam)
]

{ #category : #dynamic }
ForceBasicqcComp >> fillDynError: col aFTOi: aFTOi [ 
	col at: iqXaxis plusNumber: aFTOi.
	col at: iqE plusFullColumn: (prOeOaxispET times: aFTOi)
]

{ #category : #dynamic }
ForceBasicqcComp >> fillpFpy: mat aFTOi: aFTOi [ 
	| axis pprOeOpEpE iqEm1 pprOeOpEpEi mati pprOeOpEpEij |
	axis := parent axis.
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
					mati at: iqEm1 + j plusNumber: (pprOeOpEpEij at: axis)
							* aFTOi]]
]

{ #category : #dynamic }
ForceBasicqcComp >> fillpFpy: mat pFTOipEj: pFTOipEj partj: partj [ 
	| iqEj |
	iqEj := partj iqE.
	mat
		at: iqXaxis
		and: iqEj
		plusFullRow: pFTOipEj.
	mat
		at: iqE
		and: iqEj
		plusFullMatrix: (prOeOaxispET timesFullRow: pFTOipEj)
]

{ #category : #dynamic }
ForceBasicqcComp >> fillpFpy: mat pFTOipXj: pFTOipXj pFTOipEj: pFTOipEj partj: partj [ 
	self
		fillpFpy: mat
		pFTOipXj: pFTOipXj
		partj: partj.
	self
		fillpFpy: mat
		pFTOipEj: pFTOipEj
		partj: partj
]

{ #category : #dynamic }
ForceBasicqcComp >> fillpFpy: mat pFTOipXj: pFTOipXj partj: partj [ 
	| iqXj |
	iqXj := partj iqX.
	mat
		at: iqXaxis
		and: iqXj
		plusFullRow: pFTOipXj.
	mat
		at: iqE
		and: iqXj
		plusFullMatrix: (prOeOaxispET timesFullRow: pFTOipXj)
]

{ #category : #dynamic }
ForceBasicqcComp >> fillpFpydot: mat pFTOipEdotj: pFTOipEdotj partj: partj [ 
	| iqEj |
	iqEj := partj iqE.
	mat
		at: iqXaxis
		and: iqEj
		plusFullRow: pFTOipEdotj.
	mat
		at: iqE
		and: iqEj
		plusFullMatrix: (prOeOaxispET timesFullRow: pFTOipEdotj)
]

{ #category : #dynamic }
ForceBasicqcComp >> fillpFpydot: mat pFTOipXdotj: pFTOipXdotj pFTOipEdotj: pFTOipEdotj partj: partj [ 
	self
		fillpFpydot: mat
		pFTOipXdotj: pFTOipXdotj
		partj: partj.
	self
		fillpFpydot: mat
		pFTOipEdotj: pFTOipEdotj
		partj: partj
]

{ #category : #dynamic }
ForceBasicqcComp >> fillpFpydot: mat pFTOipXdotj: pFTOipXdotj partj: partj [ 
	| iqXj |
	iqXj := partj iqX.
	mat
		at: iqXaxis
		and: iqXj
		plusFullRow: pFTOipXdotj.
	mat
		at: iqE
		and: iqXj
		plusFullMatrix: (prOeOaxispET timesFullRow: pFTOipXdotj)
]

{ #category : #dynamic }
ForceBasicqcComp >> fillpFpydot: mat pFTOipmudot: pFTOipmudot [ 
	mat
		at: iqXaxis
		and: 1
		plusSparseRow: pFTOipmudot.
	mat
		at: iqE
		and: 1
		plusSparseMatrix: (prOeOaxispET timesSparseRow: pFTOipmudot)
]

{ #category : #'initialize-release' }
ForceBasicqcComp >> useEquationNumbers [
	super useEquationNumbers.
	iqXaxis := endFrame partFrame iqX + parent axis - 1
]
