"
Second dimension is a kind of Row which in turn can store Double's only.
A matrix is a stack of rows.

GE	Gauss Elimination
LU	LU decomposition
SC	Scaling
FP	Full pivoting
PP	Partial pivoting
MT	Markowitz criterion and threshold (stops when threshold fails)
AM 	Criterion is Aij divided by (2.0d raisedTo: MarkowitzProduct * integerExp)

GE:SC:PV:AM:
GE:FPAM:
GE:PPAM:

LU:SC:PV:AM:
LUAM:			Factorized self and return row pivoting. Ready for use with different b vectors.
LU:SC:PV:		Scale and pivot b vector, then forward and back substitute with LU for x.
"
Class {
	#name : #RowTypeMatrix,
	#superclass : #MathArray,
	#type : #variable,
	#category : #'StCAD-Math-StMathArray'
}

{ #category : #converting }
RowTypeMatrix >> asDiagonalMatrix [
	| nrow answer |
	nrow := self nrow.
	answer := DiagonalMatrix new: nrow.
	1 to: nrow do: [:i | answer at: i put: (self at: i and: i)].
	^answer
]

{ #category : #converting }
RowTypeMatrix >> asFullColumn [
	self ncol == 1 ifFalse: [self error: 'Matrix cannot be converted into a column.'].
	^self fullColumn: 1
]

{ #category : #converting }
RowTypeMatrix >> asIdentityMatrix [
	^IdentityMatrix new: self nrow
]

{ #category : #converting }
RowTypeMatrix >> asSparseColumn [
	self ncol == 1 ifFalse: [self error: 'Matrix cannot be converted into a column.'].
	^self sparseColumn: 1
]

{ #category : #converting }
RowTypeMatrix >> asZeroMatrix [
	^ZeroMatrix new: self nrow by: self ncol
]

{ #category : #accessing }
RowTypeMatrix >> at: i and: j [ 
	"Return element aij."

	^(self at: i)
		at: j
]

{ #category : #'ops on self' }
RowTypeMatrix >> at: i1 and: j1 minusDiagonalMatrix: aDiagonalMatrix [ 
	| n iOffset jOffset |
	n := aDiagonalMatrix nrow.
	iOffset := i1 - 1.
	jOffset := j1 - 1.
	1 to: n do: [:ii | (self at: iOffset + ii)
			at: jOffset + ii minusNumber: (aDiagonalMatrix at: ii)]
]

{ #category : #'ops on self' }
RowTypeMatrix >> at: i1 and: j1 minusFullColumn: aFullColumn [ 
	| iOffset |
	iOffset := i1 - 1.
	1 to: aFullColumn size do: [:ii | (self at: iOffset + ii)
			at: j1 minusNumber: (aFullColumn at: ii)]
]

{ #category : #'ops on self' }
RowTypeMatrix >> at: i1 and: j1 minusFullColumn: aFullColumn times: aNumber [ 
	| iOffset |
	iOffset := i1 - 1.
	1 to: aFullColumn size do: [:ii | (self at: iOffset + ii)
			at: j1 minusNumber: (aFullColumn at: ii)
				* aNumber]
]

{ #category : #'ops on self' }
RowTypeMatrix >> at: i1 and: j1 minusFullMatrix: aFullMatrix [ 
	| iOffset |
	iOffset := i1 - 1.
	1 to: aFullMatrix nrow do: [:ii | (self at: iOffset + ii)
			at: j1 minusFullRow: (aFullMatrix at: ii)]
]

{ #category : #'ops on self' }
RowTypeMatrix >> at: i1 and: j1 minusFullMatrix: aFullMatrix times: aNumber [ 
	| iOffset |
	iOffset := i1 - 1.
	1 to: aFullMatrix nrow do: [:ii | (self at: iOffset + ii)
			at: j1
			minusFullRow: (aFullMatrix at: ii)
			times: aNumber]
]

{ #category : #'ops on self' }
RowTypeMatrix >> at: i1 and: j1 minusFullRow: aFullRow [ 
	(self at: i1)
		at: j1 minusFullRow: aFullRow
]

{ #category : #'ops on self' }
RowTypeMatrix >> at: i1 and: j1 minusFullRow: aFullRow times: aNumber [ 
	(self at: i1)
		at: j1
		minusFullRow: aFullRow
		times: aNumber
]

{ #category : #'ops on self' }
RowTypeMatrix >> at: i1 and: j1 minusSparseMatrix: aSparseMatrix [ 
	| iOffset |
	iOffset := i1 - 1.
	1 to: aSparseMatrix nrow do: [:ii | (self at: iOffset + ii)
			at: j1 minusSparseRow: (aSparseMatrix at: ii)]
]

{ #category : #'ops on self' }
RowTypeMatrix >> at: i1 and: j1 minusTransposeFullMatrix: aFullMatrix [ 
	| jOffset |
	jOffset := j1 - 1.
	1 to: aFullMatrix nrow do: [:jj | self
			at: i1
			and: jOffset + jj
			minusFullColumn: (aFullMatrix at: jj) transpose]
]

{ #category : #'ops on self' }
RowTypeMatrix >> at: i1 and: j1 minusTransposeFullMatrix: aFullMatrix times: aNumber [ 
	| jOffset |
	jOffset := j1 - 1.
	1 to: aFullMatrix nrow do: [:jj | self
			at: i1
			and: jOffset + jj
			minusFullColumn: (aFullMatrix at: jj) transpose
			times: aNumber]
]

{ #category : #'ops on self' }
RowTypeMatrix >> at: i1 and: j1 plusDiagonalMatrix: aDiagonalMatrix [ 
	| n iOffset jOffset |
	n := aDiagonalMatrix nrow.
	iOffset := i1 - 1.
	jOffset := j1 - 1.
	1 to: n do: [:ii | (self at: iOffset + ii)
			at: jOffset + ii plusNumber: (aDiagonalMatrix at: ii)]
]

{ #category : #'ops on self' }
RowTypeMatrix >> at: i1 and: j1 plusFullColumn: aFullColumn [ 
	| iOffset |
	iOffset := i1 - 1.
	1 to: aFullColumn size do: [:ii | (self at: iOffset + ii)
			at: j1 plusNumber: (aFullColumn at: ii)]
]

{ #category : #'ops on self' }
RowTypeMatrix >> at: i1 and: j1 plusFullColumn: aFullColumn times: aNumber [ 
	| iOffset |
	iOffset := i1 - 1.
	1 to: aFullColumn size do: [:ii | (self at: iOffset + ii)
			at: j1 plusNumber: (aFullColumn at: ii)
				* aNumber]
]

{ #category : #'ops on self' }
RowTypeMatrix >> at: i1 and: j1 plusFullMatrix: aFullMatrix [ 
	| iOffset |
	iOffset := i1 - 1.
	1 to: aFullMatrix nrow do: [:ii | (self at: iOffset + ii)
			at: j1 plusFullRow: (aFullMatrix at: ii)]
]

{ #category : #'ops on self' }
RowTypeMatrix >> at: i1 and: j1 plusFullMatrix: aFullMatrix times: aNumber [ 
	| iOffset |
	iOffset := i1 - 1.
	1 to: aFullMatrix nrow do: [:ii | (self at: iOffset + ii)
			at: j1
			plusFullRow: (aFullMatrix at: ii)
			times: aNumber]
]

{ #category : #'ops on self' }
RowTypeMatrix >> at: i1 and: j1 plusFullRow: aFullRow [ 
	(self at: i1)
		at: j1 plusFullRow: aFullRow
]

{ #category : #'ops on self' }
RowTypeMatrix >> at: i1 and: j1 plusFullRow: aFullRow times: aNumber [ 
	(self at: i1)
		at: j1
		plusFullRow: aFullRow
		times: aNumber
]

{ #category : #'ops on self' }
RowTypeMatrix >> at: i and: j plusNumber: aNumber [ 
	^(self at: i)
		at: j plusNumber: aNumber
]

{ #category : #'ops on self' }
RowTypeMatrix >> at: i1 and: j1 plusSparseMatrix: aSparseMatrix [ 
	| iOffset |
	iOffset := i1 - 1.
	1 to: aSparseMatrix nrow do: [:ii | (self at: iOffset + ii)
			at: j1 plusSparseRow: (aSparseMatrix at: ii)]
]

{ #category : #'ops on self' }
RowTypeMatrix >> at: i1 and: j1 plusTransposeFullMatrix: aFullMatrix [ 
	| jOffset |
	jOffset := j1 - 1.
	1 to: aFullMatrix nrow do: [:jj | self
			at: i1
			and: jOffset + jj
			plusFullColumn: (aFullMatrix at: jj) transpose]
]

{ #category : #'ops on self' }
RowTypeMatrix >> at: i1 and: j1 plusTransposeFullMatrix: aFullMatrix times: aNumber [ 
	| jOffset |
	jOffset := j1 - 1.
	1 to: aFullMatrix nrow do: [:jj | self
			at: i1
			and: jOffset + jj
			plusFullColumn: (aFullMatrix at: jj) transpose
			times: aNumber]
]

{ #category : #accessing }
RowTypeMatrix >> at: i and: j put: value [ 
	"Set element aij."

	(self at: i)
		at: j put: value
]

{ #category : #'ops on self' }
RowTypeMatrix >> at: i1 and: j1 putFullColumn: aFullColumn [ 
	| iOffset |
	iOffset := i1 - 1.
	1 to: aFullColumn size do: [:ii | self
			at: iOffset + ii
			and: j1
			put: (aFullColumn at: ii)]
]

{ #category : #'ops on self' }
RowTypeMatrix >> at: i1 and: j1 putFullMatrix: aFullMatrix [ 
	"Put aFullMatrix into a submatrix of self."

	| iOffset |
	iOffset := i1 - 1.
	1 to: aFullMatrix nrow do: [:ii | (self at: iOffset + ii)
			at: j1 putFullRow: (aFullMatrix at: ii)]
]

{ #category : #'ops on self' }
RowTypeMatrix >> at: i1 and: j1 putFullMatrix: aFullMatrix times: aNumber [ 
	"Put aFullMatrix into a submatrix of self."

	| iOffset |
	iOffset := i1 - 1.
	1 to: aFullMatrix nrow do: [:ii | (self at: iOffset + ii)
			at: j1
			putFullRow: (aFullMatrix at: ii)
			times: aNumber]
]

{ #category : #'ops on self' }
RowTypeMatrix >> at: i1 and: j1 putFullRow: aFullRow [ 
	(self at: i1)
		at: j1 putFullRow: aFullRow
]

{ #category : #'instance creation' }
RowTypeMatrix >> by: ncol [ 
	"Add second dimension to matrix. Used by new:by: only."

	1 to: self nrow do: [:i | self at: i put: (self secondDimensionClass new: ncol)]
]

{ #category : #accessing }
RowTypeMatrix >> column: j [ 
	"Returns the column of a matrix."

	| n column |
	n := self nrow.
	column := FullColumn new: n.
	1 to: n do: [:i | column at: i put: (self at: i and: j)].
	^column
]

{ #category : #'ops on self' }
RowTypeMatrix >> conditionSelfByRow [
	1 to: self nrow do: [:i | self at: i put: (self at: i) conditioned]
]

{ #category : #'basic ops' }
RowTypeMatrix >> conditionedByRow [
	| nrow answer |
	nrow := self nrow.
	answer := self class new: nrow.
	1 to: nrow do: [:i | answer at: i put: (self at: i) conditioned].
	^answer
]

{ #category : #'ops on self' }
RowTypeMatrix >> equalFullMatrix: aFullMatrix [ 
	1 to: self nrow do: [:i | (self at: i)
			equalFullRow: (aFullMatrix at: i)]
]

{ #category : #'ops on self' }
RowTypeMatrix >> equalFullMatrix: aFullMatrix at: ii1 and: jj1 [ 
	| iiOffset |
	iiOffset := ii1 - 1.
	1 to: self nrow do: [:i | (self at: i)
			equalFullRow: (aFullMatrix at: iiOffset + i)
			at: jj1]
]

{ #category : #'ops on self' }
RowTypeMatrix >> equalFullMatrix: aFullMatrix times: aNumber [ 
	1 to: self nrow do: [:i | (self at: i)
			equalFullRow: (aFullMatrix at: i)
			times: aNumber]
]

{ #category : #'ops on self' }
RowTypeMatrix >> equalSelfMinusFullMatrix: aFullMatrix [ 
	1 to: self nrow do: [:i | (self at: i)
			equalSelfMinusFullRow: (aFullMatrix at: i)]
]

{ #category : #'ops on self' }
RowTypeMatrix >> equalSelfMinusFullMatrix: aFullMatrix at: ii1 and: jj1 [ 
	| iiOffset |
	iiOffset := ii1 - 1.
	1 to: self nrow do: [:i | (self at: i)
			equalSelfMinusFullRow: (aFullMatrix at: iiOffset + i)
			at: jj1]
]

{ #category : #'ops on self' }
RowTypeMatrix >> equalSelfMinusFullMatrix: aFullMatrix times: aNumber [ 
	1 to: self nrow do: [:i | (self at: i)
			equalSelfMinusFullRow: (aFullMatrix at: i)
			times: aNumber]
]

{ #category : #'ops on self' }
RowTypeMatrix >> equalSelfPlusFullMatrix: aFullMatrix [ 
	1 to: self nrow do: [:i | (self at: i)
			equalSelfPlusFullRow: (aFullMatrix at: i)]
]

{ #category : #'ops on self' }
RowTypeMatrix >> equalSelfPlusFullMatrix: aFullMatrix at: ii1 and: jj1 [ 
	| iiOffset |
	iiOffset := ii1 - 1.
	1 to: self nrow do: [:i | (self at: i)
			equalSelfPlusFullRow: (aFullMatrix at: iiOffset + i)
			at: jj1]
]

{ #category : #'ops on self' }
RowTypeMatrix >> equalSelfPlusFullMatrix: aFullMatrix times: aNumber [ 
	1 to: self nrow do: [:i | (self at: i)
			equalSelfPlusFullRow: (aFullMatrix at: i)
			times: aNumber]
]

{ #category : #'ops on self' }
RowTypeMatrix >> equalSelfTimes: alpha minusFullMatrix: aFullMatrix times: beta [ 
	1 to: self nrow do: [:i | (self at: i)
			equalSelfTimes: alpha
			minusFullRow: (aFullMatrix at: i)
			times: beta]
]

{ #category : #'ops on self' }
RowTypeMatrix >> equalSelfTimes: alpha plusFullMatrix: aFullMatrix times: beta [ 
	1 to: self nrow do: [:i | (self at: i)
			equalSelfTimes: alpha
			plusFullRow: (aFullMatrix at: i)
			times: beta]
]

{ #category : #accessing }
RowTypeMatrix >> fullColumn: j [ 
	"Returns the fullColumn of a matrix."

	| nrow fullColumn |
	nrow := self nrow.
	fullColumn := FullColumn new: nrow.
	1 to: nrow do: [:i | fullColumn at: i put: (self at: i and: j)].
	^fullColumn
]

{ #category : #'basic ops' }
RowTypeMatrix >> identity [
	self nrow == self ncol ifFalse: [self error: 'Matrix is not square'].
	self zeroSelf.
	1 to: self nrow do: [:i | self at: i and: i put: 1.0d]
]

{ #category : #testing }
RowTypeMatrix >> isDiagonal [
	| m n |
	m := self nrow.
	n := self ncol.
	m == n ifFalse: [^false].
	1 to: m
		do: 
			[:i | 
			| arrayi |
			arrayi := self at: i.
			1 to: n do: [:j | i == j ifFalse: [(arrayi at: j)
						= 0 ifFalse: [^false]]]].
	^true
]

{ #category : #testing }
RowTypeMatrix >> isIdentity [
	| n identicalElement m |
	m := self nrow.
	n := self ncol.
	m == n ifFalse: [^false].
	identicalElement := self at: 1 and: 1.
	1 to: m
		do: 
			[:i | 
			| arrayi |
			arrayi := self at: i.
			1 to: n do: [:j | i == j
					ifTrue: [(arrayi at: j)
							= identicalElement ifFalse: [^false]]
					ifFalse: [(arrayi at: j)
							= 0 ifFalse: [^false]]]].
	^true
]

{ #category : #accessing }
RowTypeMatrix >> matrixSolverClass [
	self subclassResponsibility
]

{ #category : #accessing }
RowTypeMatrix >> ncol [
	^(self at: 1) ncol
]

{ #category : #accessing }
RowTypeMatrix >> nrow [
	"Answer the number of indexable fields in the receiver. This value is the 
	same as the largest legal subscript. Primitive is specified here to override 
	SequenceableCollection size."

	<primitive: 62>
	^self basicSize
]

{ #category : #accessing }
RowTypeMatrix >> numberOfElements [
	"Answer the number of elements in the full vector or matrix."

	^self nrow * self ncol
]

{ #category : #printing }
RowTypeMatrix >> outputOnFile: aString [ 
	| writeStream aij aijString |
	writeStream := aString asFilename writeStream.
	1 to: self nrow
		do: 
			[:i | 
			1 to: self ncol
				do: 
					[:j | 
					aij := self at: i and: j.
					aij == nil ifTrue: [aij := 0.0d].
					aijString := aij printString.
					aijString last == $d
						ifTrue: [aijString replaceAll: $d with: Character space]
						ifFalse: [aijString replaceAll: $d with: $e].
					writeStream nextPutAll: aijString.
					writeStream space].
			writeStream cr].
	writeStream flush; close
]

{ #category : #accessing }
RowTypeMatrix >> row: i [ 
	^(self at: i) copy
]

{ #category : #norms }
RowTypeMatrix >> rowSumNorm [
	| rowsum answer |
	answer := (self at: 1) sumOfAbsElements.
	2 to: self size
		do: 
			[:i | 
			rowsum := (self at: i) sumOfAbsElements.
			answer < rowsum ifTrue: [answer := rowsum]].
	^answer
]

{ #category : #'basic ops' }
RowTypeMatrix >> scaledWith: scalingVector forRows: i1 to: i2 [ 
	i1 to: i2 do: [:i | (self at: i)
			magnifySelf: (scalingVector at: i)]
]

{ #category : #'basic ops' }
RowTypeMatrix >> scalingVectorForRows: i1 to: i2 [ 
	"Row element * scaling <= 1.0."

	| scalingVector maxElement |
	scalingVector := FullColumn new: self nrow.
	i1 to: i2
		do: 
			[:i | 
			maxElement := (self at: i) maxElement.
			scalingVector at: i put: 1.0d / maxElement].
	^scalingVector
]

{ #category : #accessing }
RowTypeMatrix >> secondDimensionClass [
	self subclassResponsibility
]

{ #category : #accessing }
RowTypeMatrix >> sparseColumn: j [ 
	"Returns the sparseColumn of a matrix."

	| nrow sparseColumn aij |
	nrow := self nrow.
	sparseColumn := SparseColumn new: nrow.
	1 to: nrow
		do: 
			[:i | 
			aij := self at: i and: j.
			(aij isNil or: [aij isZero])
				ifFalse: [sparseColumn at: i put: aij]].
	^sparseColumn
]

{ #category : #'ops on self' }
RowTypeMatrix >> symLowerWithUpper [
	"Upper triangle is given."
	"Fill lower triangle with upper triangle to make matrix symmetric."

	| nrow ncol |
	nrow := self nrow.
	ncol := self ncol.
	nrow == ncol ifFalse: [self error: 'StM: Matrix must be square to be made symmetric.'].
	1 to: ncol
		do: 
			[:i | 
			| row |
			row := self at: i.
			i + 1 to: ncol do: [:j | self
					at: j
					and: i
					put: (row at: j)]]
]

{ #category : #'basic ops' }
RowTypeMatrix >> timesFullColumn: aFullColumn [ 
	"a*b = a(i,j)b(j) sum j."

	| nrow answer |
	nrow := self nrow.
	answer := FullColumn new: nrow.
	1 to: nrow do: [:i | answer at: i put: ((self at: i)
				timesFullColumn: aFullColumn)].
	^answer
]

{ #category : #'basic ops' }
RowTypeMatrix >> timesFullMatrix: aFullMatrix [ 
	"a*b = a(i,j)b(j,k)"

	| nrow answer |
	nrow := self nrow.
	answer := FullMatrix new: nrow.
	1 to: nrow do: [:i | answer at: i put: ((self at: i)
				timesFullMatrix: aFullMatrix)].
	^answer
]

{ #category : #'basic ops' }
RowTypeMatrix >> timesFullRow: aFullRow [ 
	"a*b = a(i,1)b(1,j) sum j."

	| nrow answer |
	self ncol == 1 ifFalse: [self error: 'Matrix has wrong dimension for product with row.'].
	nrow := self nrow.
	answer := FullMatrix new: nrow.
	1 to: nrow do: [:i | answer at: i put: (aFullRow times: (self at: i and: 1))].
	^answer
]

{ #category : #'basic ops' }
RowTypeMatrix >> timesSparseMatrix: aSparseMatrix [ 
	"a*b = a(i,j)b(j,k)"

	| nrow answer |
	nrow := self nrow.
	answer := SparseMatrix new: nrow.
	1 to: nrow do: [:i | answer at: i put: ((self at: i)
				timesSparseMatrix: aSparseMatrix)].
	^answer
]

{ #category : #'basic ops' }
RowTypeMatrix >> timesTransposeFullColumn: aFullColumn [ 
	"a*bT = a(i,1)b(j)"

	^self timesFullRow: aFullColumn transpose
]

{ #category : #'basic ops' }
RowTypeMatrix >> timesTransposeFullMatrix: aFullMatrix [ 
	"a*bT = a(i,j)b(k,j)"

	| nrow answer |
	nrow := self nrow.
	answer := FullMatrix new: nrow.
	1 to: nrow do: [:i | answer at: i put: ((self at: i)
				timesTransposeFullMatrix: aFullMatrix)].
	^answer
]

{ #category : #'basic ops' }
RowTypeMatrix >> timesTransposeSparseMatrix: aSparseMatrix [ 
	"a*bT = a(i,j)b(k,j)"

	| nrow answer |
	nrow := self nrow.
	answer := SparseMatrix new: nrow.
	1 to: nrow do: [:i | answer at: i put: ((self at: i)
				timesTransposeSparseMatrix: aSparseMatrix)].
	^answer
]

{ #category : #'basic ops' }
RowTypeMatrix >> trace [
	"No checking."

	| trace |
	trace := self at: 1 and: 1.
	2 to: self nrow do: [:i | trace := trace + (self at: i and: i)].
	^trace
]

{ #category : #'basic ops' }
RowTypeMatrix >> transposeTimes: aNumber [ 
	self subclassResponsibility
]

{ #category : #'basic ops' }
RowTypeMatrix >> transposeTimesFullColumn: aFullColumn [ 
	"aT*b = a(i,j)b(i) sum i."

	self subclassResponsibility
]

{ #category : #'basic ops' }
RowTypeMatrix >> transposeTimesFullColumn: aFullColumn times: aNumber [ 
	"aT*b = a(i,j)b(i) sum i."

	| nrow ncol answer |
	nrow := self nrow.
	ncol := self ncol.
	answer := (FullColumn zero: ncol).
	1 to: nrow do: [:i | answer equalSelfPlusFullColumn: (self at: i)
			times: (aFullColumn at: i)
					* aNumber].
	^answer
]

{ #category : #'basic ops' }
RowTypeMatrix >> transposeTimesFullMatrix: aFullMatrix [ 
	^self transpose timesFullMatrix: aFullMatrix
]

{ #category : #'basic ops' }
RowTypeMatrix >> transposeTimesSparseMatrix: aSparseMatrix [ 
	^self transpose timesSparseMatrix: aSparseMatrix
]

{ #category : #'initialize-release' }
RowTypeMatrix >> validateElements [
	"Check that all the arrays have the same second dimension size."

	| ncol secondDimensionClass |
	ncol := self ncol.
	secondDimensionClass := self secondDimensionClass.
	1 to: self nrow
		do: 
			[:i | 
			| array newArray |
			array := self at: i.
			newArray := (array isMemberOf: secondDimensionClass)
						ifTrue: [array]
						ifFalse: [array shallowCopy changeClassToThatOf: (secondDimensionClass new: 0)].
			newArray size == ncol ifFalse: [self error: 'StM: Matrix must have newArrays equal to the second dimension.'].
			newArray validateElements.
			self at: i put: newArray]
]
