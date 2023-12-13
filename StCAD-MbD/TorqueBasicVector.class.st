Class {
	#name : #TorqueBasicVector,
	#superclass : #ForTorBasic,
	#instVars : [
		'twoBT'
	],
	#category : #'StCAD-MbD-MbDTorque'
}

{ #category : #'VisualWorks metadata' }
TorqueBasicVector class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #calc }
TorqueBasicVector >> calcPostDynCorrectorIteration [
	twoBT := endFrame partFrame aB transpose times: 2.0d
]

{ #category : #accIC }
TorqueBasicVector >> fillAccICIterError: col aFTO: aFTO [ 
	col at: iqE plusFullColumn: (twoBT timesFullColumn: aFTO)
]

{ #category : #accIC }
TorqueBasicVector >> fillAccICIterJacob: mat pFTOplam: pFTOplam [ 
	| pQEplam |
	pQEplam := twoBT timesSparseMatrix: pFTOplam.
	mat
		at: iqE
		and: 1
		plusSparseMatrix: pQEplam
]

{ #category : #dynamic }
TorqueBasicVector >> fillDynError: col aFTO: aFTO [ 
	col at: iqE plusFullColumn: (twoBT timesFullColumn: aFTO)
]

{ #category : #dynamic }
TorqueBasicVector >> fillpFpy: mat aFTO: aFTO [ 
	mat
		at: iqE
		and: iqE
		plusFullMatrix: (MbDEulerParameters pBTpEtimesColumn: (aFTO times: 2.0d))
]

{ #category : #dynamic }
TorqueBasicVector >> fillpFpy: mat pFTOpEj: pFTOpEj partFramej: partFramej [ 
	mat
		at: iqE
		and: partFramej iqE
		plusFullMatrix: (twoBT timesFullMatrix: pFTOpEj)
]

{ #category : #dynamic }
TorqueBasicVector >> fillpFpy: mat pFTOpEj: pFTOpEj partj: partj [ 
	mat
		at: iqE
		and: partj iqE
		plusFullMatrix: (twoBT timesFullMatrix: pFTOpEj)
]

{ #category : #dynamic }
TorqueBasicVector >> fillpFpy: mat pFTOpXj: pFTOpXj pFTOpEj: pFTOpEj partFramej: partFramej [ 
	mat
		at: iqE
		and: partFramej iqX
		plusFullMatrix: (twoBT timesFullMatrix: pFTOpXj).
	mat
		at: iqE
		and: partFramej iqE
		plusFullMatrix: (twoBT timesFullMatrix: pFTOpEj)
]

{ #category : #dynamic }
TorqueBasicVector >> fillpFpy: mat pFTOpXj: pFTOpXj pFTOpEj: pFTOpEj partj: partj [ 
	mat
		at: iqE
		and: partj iqX
		plusFullMatrix: (twoBT timesFullMatrix: pFTOpXj).
	mat
		at: iqE
		and: partj iqE
		plusFullMatrix: (twoBT timesFullMatrix: pFTOpEj)
]

{ #category : #dynamic }
TorqueBasicVector >> fillpFpydot: mat pFTOpEdotj: pFTOpEdotj partFramej: partFramej [ 
	mat
		at: iqE
		and: partFramej iqE
		plusFullMatrix: (twoBT timesFullMatrix: pFTOpEdotj)
]

{ #category : #dynamic }
TorqueBasicVector >> fillpFpydot: mat pFTOpEdotj: pFTOpEdotj partj: partj [ 
	mat
		at: iqE
		and: partj iqE
		plusFullMatrix: (twoBT timesFullMatrix: pFTOpEdotj)
]

{ #category : #dynamic }
TorqueBasicVector >> fillpFpydot: mat pFTOpXdotj: pFTOpXdotj pFTOpEdotj: pFTOpEdotj partFramej: partFramej [ 
	mat
		at: iqE
		and: partFramej iqX
		plusFullMatrix: (twoBT timesFullMatrix: pFTOpXdotj).
	mat
		at: iqE
		and: partFramej iqE
		plusFullMatrix: (twoBT timesFullMatrix: pFTOpEdotj)
]

{ #category : #dynamic }
TorqueBasicVector >> fillpFpydot: mat pFTOpXdotj: pFTOpXdotj pFTOpEdotj: pFTOpEdotj partj: partj [ 
	mat
		at: iqE
		and: partj iqX
		plusFullMatrix: (twoBT timesFullMatrix: pFTOpXdotj).
	mat
		at: iqE
		and: partj iqE
		plusFullMatrix: (twoBT timesFullMatrix: pFTOpEdotj)
]

{ #category : #dynamic }
TorqueBasicVector >> fillpFpydot: mat pFTOpmudot: pFTOpmudot [ 
	mat
		at: iqE
		and: 1
		plusSparseMatrix: (twoBT timesSparseMatrix: pFTOpmudot)
]
