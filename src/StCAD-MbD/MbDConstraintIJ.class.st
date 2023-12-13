Class {
	#name : #MbDConstraintIJ,
	#superclass : #MbDConstraint,
	#instVars : [
		'frmI',
		'frmJ',
		'aConstant'
	],
	#category : #'StCAD-MbD-MbDConstraint'
}

{ #category : #'VisualWorks metadata' }
MbDConstraintIJ class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
MbDConstraintIJ >> aConstant [
	^aConstant
]

{ #category : #accessing }
MbDConstraintIJ >> aConstant: aDouble [
	aConstant := aDouble
]

{ #category : #accessing }
MbDConstraintIJ >> addpFIeiGOpEIto: mat [ 
	"ppGpXIpEI is zero."
	"Do nothing."
]

{ #category : #accessing }
MbDConstraintIJ >> addpFIeiGOpEJto: mat [ 
	"ppGpXIpEJ is zero."
	"Do nothing."
]

{ #category : #accessing }
MbDConstraintIJ >> addpFIeiGOpXIto: mat [ 
	"ppGpXIpXI is zero."
	"Do nothing."
]

{ #category : #accessing }
MbDConstraintIJ >> addpFIeiGOpXJto: mat [ 
	"ppGpXIpXJ is zero."
	"Do nothing."
]

{ #category : #accessing }
MbDConstraintIJ >> addpFIeiGOplamto: mat [ 
	mat at: 1 and: iG plusFullColumn: self pGpXI transpose
]

{ #category : #accessing }
MbDConstraintIJ >> addpTIeiGOpEIto: mat [ 
	| term11 prOIeOpEIT aFIeiGOover2 term12 term1 term21 pprOIeOpEIpEI term22 pprOIeOpEIipEI term22rowi pFIeiGOpEIover2 term23 aB term2 pTIeiGOpEI |
	term11 := self pGpEI transpose times: lam / 2.0d.
	prOIeOpEIT := frmI prOeOpE transpose.
	aFIeiGOover2 := self pGpXI transpose times: lam / 2.0d.
	term12 := prOIeOpEIT timesFullColumn: aFIeiGOover2.
	term1 := MbDEulerParameters pBpEtimesColumn: (term11 minusFullColumn: term12).
	term21 := self ppGpEIpEI times: lam / 2.0d.
	pprOIeOpEIpEI := frmI pprOeOpEpE.
	term22 := FullMatrix new: 4 by: 4.
	1 to: 4
		do: 
			[:i | 
			pprOIeOpEIipEI := pprOIeOpEIpEI at: i.
			term22rowi := term22 at: i.
			1 to: 4 do: [:j | term22rowi at: j put: ((pprOIeOpEIipEI at: j)
						dot: aFIeiGOover2)]].
	pFIeiGOpEIover2 := self ppGpXIpEI times: lam / 2.0d.
	term23 := prOIeOpEIT timesFullMatrix: pFIeiGOpEIover2.
	aB := frmI aBOp.
	term2 := aB timesFullMatrix: ((term21 minusFullMatrix: term22)
					minusFullMatrix: term23).
	pTIeiGOpEI := term1 plusFullMatrix: term2.
	mat equalSelfPlusFullMatrix: pTIeiGOpEI
]

{ #category : #accessing }
MbDConstraintIJ >> addpTIeiGOpEJto: mat [ 
	| aB term1 prOIeOpEIT pFIeiGOpEJover2 term2 pTIeiGOpEJ |
	aB := frmI aBOp.
	term1 := self ppGpEIpEJ times: lam / 2.0d.
	prOIeOpEIT := frmI prOeOpE transpose.
	pFIeiGOpEJover2 := self ppGpXIpEJ times: lam / 2.0d.
	term2 := prOIeOpEIT timesFullMatrix: pFIeiGOpEJover2.
	pTIeiGOpEJ := aB timesFullMatrix: (term1 minusFullMatrix: term2).
	mat equalSelfPlusFullMatrix: pTIeiGOpEJ
]

{ #category : #accessing }
MbDConstraintIJ >> addpTIeiGOpXIto: mat [ 
	"ppGpXIpXI is zero."
	"ppGpEIpXI is zero."
	"Do nothing."
]

{ #category : #accessing }
MbDConstraintIJ >> addpTIeiGOpXJto: mat [ 
	"ppGpXIpXJ is zero."
	"ppGpEIpXJ is zero."
	"Do nothing."
]

{ #category : #accessing }
MbDConstraintIJ >> addpTIeiGOplamto: mat [ 
	| halfB term1 prOIeOpEIT pFIeiGOplam term2 pTIeiGOplam |
	halfB := frmI aBOp times: 0.5d.
	term1 := self pGpEI transpose.
	prOIeOpEIT := frmI prOeOpE transpose.
	pFIeiGOplam := self pGpXI transpose.
	term2 := prOIeOpEIT timesFullColumn: pFIeiGOplam.
	pTIeiGOplam := halfB timesFullColumn: (term1 minusFullColumn: term2).
	mat at: 1 and: iG plusFullColumn: pTIeiGOplam
]

{ #category : #accessing }
MbDConstraintIJ >> frmI [
	^frmI
]

{ #category : #accessing }
MbDConstraintIJ >> frmJ [
	^frmJ
]

{ #category : #'initialize-release' }
MbDConstraintIJ >> initialize [
	super initialize.
	aConstant := 0.0d
]
