Class {
	#name : #MatrixLDU,
	#superclass : #MatrixDecomposition,
	#category : #'StCAD-Math-StMathMatrixSolver'
}

{ #category : #'VisualWorks metadata' }
MatrixLDU class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #solution }
MatrixLDU >> decompose: aMatrix saveOriginal: saveOriginal [ 
	self preSolve: aMatrix saveOriginal: saveOriginal.
	1 to: m
		do: 
			[:p | 
			self doPivoting: p.
			self forwardEliminateWithPivot: p]
]

{ #category : #solution }
MatrixLDU >> forAndBackSub: aVector saveOriginal: saveOriginal [ 
	rightHandSideB := saveOriginal
				ifTrue: [aVector copy]
				ifFalse: [aVector].
	self applyRowOrderOnRightHandSideB.
	self forwardSubstituteIntoL.
	self backSubstituteIntoDU.
	^answerX
]
