"
SparseMatrix contains StMIdentityDictionary's.
"
Class {
	#name : #SparseMatrix,
	#superclass : #RowTypeMatrix,
	#type : #variable,
	#category : #'StCAD-Math-StMathArray'
}

{ #category : #converting }
SparseMatrix >> asFullMatrix [
	| nrow answer |
	nrow := self nrow.
	answer := FullMatrix new: nrow.
	1 to: nrow do: [:i | answer at: i put: (self at: i) asFullRow].
	^answer
]

{ #category : #'instance creation' }
SparseMatrix >> by: secondSize [ 
	"Add second dimension to matrix. Used by new:by: only."

	| rowi |
	1 to: self nrow
		do: 
			[:i | 
			rowi := self secondDimensionClass new: (secondSize min: 7).
			rowi fullsize: secondSize.
			self at: i put: rowi]
]

{ #category : #accessing }
SparseMatrix >> matrixSolverClass [
	^GESpMatParPvMarkoFast
]

{ #category : #'basic ops' }
SparseMatrix >> minusSparseMatrix: aSparseMatrix [ 
	"a - b."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	| answer |
	answer := self shallowCopy.
	1 to: answer nrow do: [:i | answer at: i put: ((answer at: i)
				minusSparseRow: (aSparseMatrix at: i))].
	^answer
]

{ #category : #'basic ops' }
SparseMatrix >> minusSparseMatrix: aSparseMatrix times: beta [ 
	"a - b."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	| answer |
	answer := self shallowCopy.
	1 to: answer nrow do: [:i | answer at: i put: ((answer at: i)
				minusSparseRow: (aSparseMatrix at: i)
				times: beta)].
	^answer
]

{ #category : #'basic ops' }
SparseMatrix >> plusSparseMatrix: aSparseMatrix [ 
	"a + b."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	| answer |
	answer := self shallowCopy.
	1 to: answer nrow do: [:i | answer at: i put: ((answer at: i)
				plusSparseRow: (aSparseMatrix at: i))].
	^answer
]

{ #category : #'basic ops' }
SparseMatrix >> plusSparseMatrix: aSparseMatrix times: beta [ 
	"a + b."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	| answer |
	answer := self shallowCopy.
	1 to: answer nrow do: [:i | answer at: i put: ((answer at: i)
				plusSparseRow: (aSparseMatrix at: i)
				times: beta)].
	^answer
]

{ #category : #accessing }
SparseMatrix >> secondDimensionClass [
	^SparseRow
]

{ #category : #'basic ops' }
SparseMatrix >> times: alpha minusSparseMatrix: aSparseMatrix [ 
	"a*alpha + b."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	| answer |
	answer := self shallowCopy.
	1 to: answer nrow do: [:i | answer at: i put: ((answer at: i)
				times: alpha minusSparseRow: (aSparseMatrix at: i))].
	^answer
]

{ #category : #'basic ops' }
SparseMatrix >> times: alpha minusSparseMatrix: aSparseMatrix times: beta [ 
	"a*alpha + b."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	| answer |
	answer := self shallowCopy.
	1 to: answer nrow do: [:i | answer at: i put: ((answer at: i)
				times: alpha
				minusSparseRow: (aSparseMatrix at: i)
				times: beta)].
	^answer
]

{ #category : #'basic ops' }
SparseMatrix >> times: alpha plusSparseMatrix: aSparseMatrix [ 
	"a*alpha + b."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	| answer |
	answer := self shallowCopy.
	1 to: answer nrow do: [:i | answer at: i put: ((answer at: i)
				times: alpha plusSparseRow: (aSparseMatrix at: i))].
	^answer
]

{ #category : #'basic ops' }
SparseMatrix >> times: alpha plusSparseMatrix: aSparseMatrix times: beta [ 
	"a*alpha + b."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	| answer |
	answer := self shallowCopy.
	1 to: answer nrow do: [:i | answer at: i put: ((answer at: i)
				times: alpha
				plusSparseRow: (aSparseMatrix at: i)
				times: beta)].
	^answer
]

{ #category : #'basic ops' }
SparseMatrix >> transpose [
	"Returns a new Matrix which is the transpose of self."

	| nrow answer rowi |
	nrow := self nrow.
	answer := self class new: self ncol by: nrow.
	1 to: nrow
		do: 
			[:i | 
			rowi := self at: i.
			rowi keysAndValuesDo: [:j :value | answer
					at: j
					and: i
					put: value]].
	^answer
]
