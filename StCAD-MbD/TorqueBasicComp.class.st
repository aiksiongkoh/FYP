Class {
	#name : #TorqueBasicComp,
	#superclass : #ForTorBasic,
	#instVars : [
		'twoBaxisT'
	],
	#category : #'StCAD-MbD-MbDTorque'
}

{ #category : #'VisualWorks metadata' }
TorqueBasicComp class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #calc }
TorqueBasicComp >> calcPostDynCorrectorIteration [
	twoBaxisT := (endFrame partFrame aB at: parent axis) transpose times: 2.0d
]

{ #category : #accIC }
TorqueBasicComp >> fillAccICIterError: col aFTOi: aFTOi [ 
	col at: iqE plusFullColumn: (twoBaxisT times: aFTOi)
]

{ #category : #accIC }
TorqueBasicComp >> fillAccICIterJacob: mat pFTOiplam: pFTOiplam [ 
	| pQEplam |
	pQEplam := twoBaxisT timesSparseRow: pFTOiplam.
	mat
		at: iqE
		and: 1
		plusSparseMatrix: pQEplam
]

{ #category : #dynamic }
TorqueBasicComp >> fillDynError: col aFTOi: aFTOi [ 
	col at: iqE plusFullColumn: (twoBaxisT times: aFTOi)
]

{ #category : #dynamic }
TorqueBasicComp >> fillpFpy: mat aFTOi: aFTOi [ 
	| aFTO |
	aFTO := (FullColumn zero: 3).
	aFTO at: parent axis put: aFTOi.
	mat
		at: iqE
		and: iqE
		plusFullMatrix: (MbDEulerParameters pBTpEtimesColumn: (aFTO times: 2.0d))
]

{ #category : #dynamic }
TorqueBasicComp >> fillpFpy: mat pFTOipEj: pFTOipEj partFramej: partFramej [ 
	mat
		at: iqE
		and: partFramej iqE
		plusFullMatrix: (twoBaxisT timesFullRow: pFTOipEj)
]

{ #category : #dynamic }
TorqueBasicComp >> fillpFpy: mat pFTOipEj: pFTOipEj partj: partj [ 
	mat
		at: iqE
		and: partj iqE
		plusFullMatrix: (twoBaxisT timesFullRow: pFTOipEj)
]

{ #category : #dynamic }
TorqueBasicComp >> fillpFpy: mat pFTOipXj: pFTOipXj pFTOipEj: pFTOipEj partFramej: partFramej [ 
	mat
		at: iqE
		and: partFramej iqX
		plusFullMatrix: (twoBaxisT timesFullRow: pFTOipXj).
	mat
		at: iqE
		and: partFramej iqE
		plusFullMatrix: (twoBaxisT timesFullRow: pFTOipEj)
]

{ #category : #dynamic }
TorqueBasicComp >> fillpFpy: mat pFTOipXj: pFTOipXj pFTOipEj: pFTOipEj partj: partj [ 
	mat
		at: iqE
		and: partj iqX
		plusFullMatrix: (twoBaxisT timesFullRow: pFTOipXj).
	mat
		at: iqE
		and: partj iqE
		plusFullMatrix: (twoBaxisT timesFullRow: pFTOipEj)
]

{ #category : #dynamic }
TorqueBasicComp >> fillpFpydot: mat pFTOipEdotj: pFTOipEdotj partFramej: partFramej [ 
	mat
		at: iqE
		and: partFramej iqE
		plusFullMatrix: (twoBaxisT timesFullRow: pFTOipEdotj)
]

{ #category : #dynamic }
TorqueBasicComp >> fillpFpydot: mat pFTOipEdotj: pFTOipEdotj partj: partj [ 
	mat
		at: iqE
		and: partj iqE
		plusFullMatrix: (twoBaxisT timesFullRow: pFTOipEdotj)
]

{ #category : #dynamic }
TorqueBasicComp >> fillpFpydot: mat pFTOipXdotj: pFTOipXdotj pFTOipEdotj: pFTOipEdotj partFramej: partFramej [ 
	mat
		at: iqE
		and: partFramej iqX
		plusFullMatrix: (twoBaxisT timesFullRow: pFTOipXdotj).
	mat
		at: iqE
		and: partFramej iqE
		plusFullMatrix: (twoBaxisT timesFullRow: pFTOipEdotj)
]

{ #category : #dynamic }
TorqueBasicComp >> fillpFpydot: mat pFTOipXdotj: pFTOipXdotj pFTOipEdotj: pFTOipEdotj partj: partj [ 
	mat
		at: iqE
		and: partj iqX
		plusFullMatrix: (twoBaxisT timesFullRow: pFTOipXdotj).
	mat
		at: iqE
		and: partj iqE
		plusFullMatrix: (twoBaxisT timesFullRow: pFTOipEdotj)
]

{ #category : #dynamic }
TorqueBasicComp >> fillpFpydot: mat pFTOipmudot: pFTOipmudot [ 
	mat
		at: iqE
		and: 1
		plusSparseMatrix: (twoBaxisT timesSparseRow: pFTOipmudot)
]
