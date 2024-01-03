Class {
	#name : #FullColumn,
	#superclass : #FullVector,
	#type : #variable,
	#category : #'StCAD-Math-StMathArray'
}

{ #category : #converting }
FullColumn >> asFullColumn [

	^self
]

{ #category : #converting }
FullColumn >> asFullMatrix [
	| nrow answer |
	nrow := self nrow.
	answer := FullMatrix new: nrow by: 1.
	1 to: nrow do: [:i | (answer at: i)
			at: 1 put: (self at: i)].
	^answer
]

{ #category : #converting }
FullColumn >> asFullRow [
	^self shallowCopy changeClassToThatOf: (FullRow new: 0)
]

{ #category : #converting }
FullColumn >> asZeroColumn [
	^ZeroColumn new: self nrow
]

{ #category : #'ops on self' }
FullColumn >> at: i minusFullColumn: aFullColumn [ 
	super at: i minusFullVector: aFullColumn
]

{ #category : #'ops on self' }
FullColumn >> at: i minusFullColumn: aFullColumn times: aNumber [ 
	super
		at: i
		minusFullVector: aFullColumn
		times: aNumber
]

{ #category : #'ops on self' }
FullColumn >> at: i plusFullColumn: aFullColumn [ 
	super at: i plusFullVector: aFullColumn
]

{ #category : #'ops on self' }
FullColumn >> at: i plusFullColumn: aFullColumn times: aNumber [ 
	super
		at: i
		plusFullVector: aFullColumn
		times: aNumber
]

{ #category : #'ops on self' }
FullColumn >> at: i1 putFullColumn: aFullColumn [ 
	super at: i1 putFullVector: aFullColumn
]

{ #category : #'ops on self' }
FullColumn >> at: i1 putFullColumn: aFullColumn times: aNumber [ 
	super
		at: i1
		putFullVector: aFullColumn
		times: aNumber
]

{ #category : #comparing }
FullColumn >> equal: aArray tol: tol [ 
	"Equal to within a box of side 2*tol."

	| n answer i |
	n := self size.
	answer := true.
	i := 1.
	
	[((self at: i) equal: (aArray at: i) tol: tol) ifFalse: [answer := false].
	answer and: 
			[i := i + 1.
			i <= n]] 
			whileTrue.
	^answer
]

{ #category : #comparing }
FullColumn >> equal: aArray tolBox: tol [ 
	"Equal to within a box of side 2*tol."

	| n answer i |
	n := self size.
	answer := true.
	i := 1.
	
	[((self at: i) equal: (aArray at: i) tol: tol) ifFalse: [answer := false].
	answer and: 
			[i := i + 1.
			i <= n]] 
			whileTrue.
	^answer
]

{ #category : #comparing }
FullColumn >> equal: aFullColumn tolRadius: tol [ 
	^(self minusFullColumn: aFullColumn) length <= tol
]

{ #category : #'ops on self' }
FullColumn >> equalFullColumn: aFullColumn [ 
	super equalFullVector: aFullColumn
]

{ #category : #'ops on self' }
FullColumn >> equalFullColumn: aFullColumn at: ii1 [ 
	super equalFullVector: aFullColumn at: ii1
]

{ #category : #'ops on self' }
FullColumn >> equalFullColumn: aFullColumn times: aNumber [ 
	super equalFullVector: aFullColumn times: aNumber
]

{ #category : #'ops on self' }
FullColumn >> equalFullMatrix: aFullMatrix at: ii1 and: jj1 [ 
	| iiOffset |
	iiOffset := ii1 - 1.
	1 to: self size do: [:i | self at: i put: (aFullMatrix at: iiOffset + i and: jj1)]
]

{ #category : #'ops on self' }
FullColumn >> equalSelfMinusFullColumn: aFullColumn [ 
	super equalSelfMinusFullVector: aFullColumn
]

{ #category : #'ops on self' }
FullColumn >> equalSelfMinusFullColumn: aFullColumn at: ii1 [ 
	super equalSelfMinusFullVector: aFullColumn at: ii1
]

{ #category : #'ops on self' }
FullColumn >> equalSelfMinusFullColumn: aFullColumn times: aNumber [ 
	super equalSelfMinusFullVector: aFullColumn times: aNumber
]

{ #category : #'ops on self' }
FullColumn >> equalSelfMinusFullMatrix: aFullMatrix at: ii1 and: jj1 [ 
	| iiOffset |
	iiOffset := ii1 - 1.
	1 to: self size do: [:i | self at: i put: (self at: i)
				- (aFullMatrix at: iiOffset + i and: jj1)]
]

{ #category : #'ops on self' }
FullColumn >> equalSelfMinusSparseColumn: aSparseColumn [ 
	super equalSelfMinusSparseVector: aSparseColumn
]

{ #category : #'ops on self' }
FullColumn >> equalSelfMinusSparseColumn: aSparseColumn times: aNumber [ 
	super equalSelfMinusSparseVector: aSparseColumn times: aNumber
]

{ #category : #'ops on self' }
FullColumn >> equalSelfPlusFullColumn: aFullColumn [ 
	super equalSelfPlusFullVector: aFullColumn
]

{ #category : #'ops on self' }
FullColumn >> equalSelfPlusFullColumn: aFullColumn at: ii1 [ 
	super equalSelfPlusFullVector: aFullColumn at: ii1
]

{ #category : #'ops on self' }
FullColumn >> equalSelfPlusFullColumn: aFullColumn times: aNumber [ 
	super equalSelfPlusFullVector: aFullColumn times: aNumber
]

{ #category : #'ops on self' }
FullColumn >> equalSelfPlusFullMatrix: aFullMatrix at: ii1 and: jj1 [ 
	| iiOffset |
	iiOffset := ii1 - 1.
	1 to: self size do: [:i | self at: i put: (self at: i)
				+ (aFullMatrix at: iiOffset + i and: jj1)]
]

{ #category : #'ops on self' }
FullColumn >> equalSelfPlusSparseColumn: aSparseColumn [ 
	super equalSelfPlusSparseVector: aSparseColumn
]

{ #category : #'ops on self' }
FullColumn >> equalSelfPlusSparseColumn: aSparseColumn times: aNumber [ 
	super equalSelfPlusSparseVector: aSparseColumn times: aNumber
]

{ #category : #'ops on self' }
FullColumn >> equalSelfTimes: alpha minusFullColumn: aFullColumn times: beta [ 
	super
		equalSelfTimes: alpha
		minusFullVector: aFullColumn
		times: beta
]

{ #category : #'ops on self' }
FullColumn >> equalSelfTimes: alpha plusFullColumn: aFullColumn times: beta [ 
	super
		equalSelfTimes: alpha
		plusFullVector: aFullColumn
		times: beta
]

{ #category : #'ops on self' }
FullColumn >> fitSelfInBox: aBoundingBox [ 
	aBoundingBox isDefined 
		ifTrue: 
			[aBoundingBox origin: (self min: aBoundingBox minCorner)
				corner: (self max: aBoundingBox maxCorner)]
		ifFalse: [aBoundingBox origin: self copy corner: self copy]
]

{ #category : #'basic ops' }
FullColumn >> minusFullColumn: aFullColumn [ 
	^super minusFullVector: aFullColumn
]

{ #category : #'basic ops' }
FullColumn >> minusFullColumn: aFullColumn times: aNumber [ 
	^super minusFullVector: aFullColumn times: aNumber
]

{ #category : #accessing }
FullColumn >> ncol [
	^1
]

{ #category : #accessing }
FullColumn >> nrow [
	"Answer the number of indexable fields in the receiver. This value is the 
	same as the largest legal subscript. Primitive is specified here to override 
	SequenceableCollection size."

	<primitive: 62>
	^self basicSize
]

{ #category : #'basic ops' }
FullColumn >> plusFullColumn: aFullColumn [ 
	^super plusFullVector: aFullColumn
]

{ #category : #'basic ops' }
FullColumn >> plusFullColumn: aFullColumn times: aNumber [ 
	^super plusFullVector: aFullColumn times: aNumber
]

{ #category : #'basic ops' }
FullColumn >> times: beta minusFullColumn: aFullColumn [ 
	^super times: beta minusFullVector: aFullColumn
]

{ #category : #'basic ops' }
FullColumn >> times: beta minusFullColumn: aFullColumn times: alpha [ 
	^super
		times: beta
		minusFullVector: aFullColumn
		times: alpha
]

{ #category : #'basic ops' }
FullColumn >> times: alpha plusFullColumn: aFullColumn [ 
	^super times: alpha plusFullVector: aFullColumn
]

{ #category : #'basic ops' }
FullColumn >> times: beta plusFullColumn: aFullColumn times: alpha [ 
	^super
		times: beta
		plusFullVector: aFullColumn
		times: alpha
]

{ #category : #'basic ops' }
FullColumn >> timesFullColumn: aFullColumn [ 
	self halt: 'Column times: Column is not a valid operation.'
]

{ #category : #'basic ops' }
FullColumn >> timesFullMatrix: aFullMatrix [ 
	"a*b = a(i)b(1,j)"

	^aFullMatrix nrow == 1
		ifTrue: [self timesFullRow: (aFullMatrix at: 1)]
		ifFalse: [self error: 'StM: Incompatible row size.']
]

{ #category : #'basic ops' }
FullColumn >> timesFullRow: aFullRow [ 
	"a*b = a(i)b(j)"

	| nrow answer |
	nrow := self nrow.
	answer := FullMatrix new: nrow.
	1 to: nrow do: [:i | answer at: i put: (aFullRow times: (self at: i))].
	^answer
]

{ #category : #'basic ops' }
FullColumn >> timesFullRow: aFullRow times: double [ 
	"a*b*scalar = a(i)b(j)*scalar"

	| nrow answer |
	nrow := self nrow.
	answer := FullMatrix new: nrow.
	1 to: nrow
		do: [:i | answer at: i put: (aFullRow times: double * (self at: i)) asFullRow].
	^answer
]

{ #category : #'basic ops' }
FullColumn >> timesSparseMatrix: aSparseMatrix [ 
	"a*b = a(i)b(1,j)"

	^aSparseMatrix nrow == 1
		ifTrue: [self timesSparseRow: (aSparseMatrix at: 1)]
		ifFalse: [self error: 'StM: Incompatible row size.']
]

{ #category : #'basic ops' }
FullColumn >> timesSparseRow: aSparseRow [ 
	"a*b = a(i)b(j)"

	| nrow answer |
	nrow := self nrow.
	answer := SparseMatrix new: nrow.
	1 to: nrow do: [:i | answer at: i put: (aSparseRow times: (self at: i))].
	^answer
]

{ #category : #'basic ops' }
FullColumn >> timesSparseRow: aSparseRow times: double [ 
	"a*b*scalar = a(i)b(j)*scalar"

	| nrow answer |
	nrow := self nrow.
	answer := SparseMatrix new: nrow.
	1 to: nrow do: [:i | answer at: i put: (aSparseRow times: double * (self at: i))].
	^answer
]

{ #category : #'basic ops' }
FullColumn >> timesTransposeFullColumn: aFullColumn [ 
	"a*bT = a(i)b(j)"

	^self timesFullRow: aFullColumn transpose
]

{ #category : #'basic ops' }
FullColumn >> timesTransposeFullMatrix: aFullMatrix [ 
	"a*bT = a(i)b(j,1)"

	^self timesTransposeFullColumn: aFullMatrix asFullColumn
]

{ #category : #'basic ops' }
FullColumn >> timesTransposeSparseColumn: aSparseColumn [ 
	"a*bT = a(i)b(j)"

	^self timesSparseRow: aSparseColumn transpose
]

{ #category : #'basic ops' }
FullColumn >> timesTransposeSparseMatrix: aSparseMatrix [ 
	"a*bT = a(i)b(j,1)"

	^self timesTransposeSparseColumn: aSparseMatrix asSparseColumn
]

{ #category : #'basic ops' }
FullColumn >> transpose [
	"Return a row with the same elements."
	"This method is much faster than the obvious way."

	^self shallowCopy changeClassToThatOf: (FullRow new: 0)
]

{ #category : #'basic ops' }
FullColumn >> transposeTimesFullColumn: aFullColumn [ 
	"colT*col = row*col."

	^self dot: aFullColumn
]

{ #category : #'basic ops' }
FullColumn >> transposeTimesFullMatrix: aFullMatrix [ 
	^self transpose timesFullMatrix: aFullMatrix
]

{ #category : #'basic ops' }
FullColumn >> transposeTimesSparseMatrix: aSparseMatrix [ 
	^self transpose timesSparseMatrix: aSparseMatrix
]

{ #category : #accessing }
FullColumn >> value [

	^self
]

{ #category : #converting }
FullColumn >> value: x [ 
	"self is a column of block formulas."
	"Return evaluation at x."

	| nrow answer |
	nrow := self nrow.
	answer := FullColumn new: nrow.
	1 to: nrow do: [:i | answer at: i put: ((self at: i)
				value: x)].
	^answer
]
