Class {
	#name : #MatrixCroutDecomposition,
	#superclass : #MatrixDecomposition,
	#category : #'StCAD-Math-StMathMatrixSolver'
}

{ #category : #solution }
MatrixCroutDecomposition >> decompose: aMatrix saveOriginal: saveOriginal [ 
	self preSolve: aMatrix saveOriginal: saveOriginal.
	1 to: m
		do: 
			[:p | 
			self formLij: p.
			self doPivoting: p.
			self formUij: p]
]

{ #category : #solution }
MatrixCroutDecomposition >> forAndBackSub: aVector saveOriginal: saveOriginal [ 
	rightHandSideB := saveOriginal
				ifTrue: [aVector copy]
				ifFalse: [aVector].
	self applyRowOrderOnRightHandSideB.
	self forwardSubstituteIntoLD.
	self backSubstituteIntoU.
	^answerX
]
