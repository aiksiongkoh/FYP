"
Stores doubles only.
"
Class {
	#name : #FullVector,
	#superclass : #MathArray,
	#type : #variable,
	#category : #'StCAD-Math-StMathArray'
}

{ #category : #'ops on self' }
FullVector >> at: i1 minusFullVector: aFullVector [ 
	| iOffset i |
	iOffset := i1 - 1.
	1 to: aFullVector size
		do: 
			[:ii | 
			i := iOffset + ii.
			self at: i put: (self at: i)
					- (aFullVector at: ii)]
]

{ #category : #'ops on self' }
FullVector >> at: i1 minusFullVector: aFullVector times: aNumber [ 
	| iOffset i |
	iOffset := i1 - 1.
	1 to: aFullVector size
		do: 
			[:ii | 
			i := iOffset + ii.
			self at: i put: (self at: i)
					- ((aFullVector at: ii)
							* aNumber)]
]

{ #category : #'ops on self' }
FullVector >> at: i minusNumber: aNumber [ 
	self at: i put: (self at: i) - aNumber
]

{ #category : #'ops on self' }
FullVector >> at: i1 plusFullVector: aFullVector [ 
	| iOffset i |
	iOffset := i1 - 1.
	1 to: aFullVector size
		do: 
			[:ii | 
			i := iOffset + ii.
			self at: i put: (self at: i)
					+ (aFullVector at: ii)]
]

{ #category : #'ops on self' }
FullVector >> at: i1 plusFullVector: aFullVector times: aNumber [ 
	| iOffset i |
	iOffset := i1 - 1.
	1 to: aFullVector size
		do: 
			[:ii | 
			i := iOffset + ii.
			self at: i put: (self at: i)
					+ ((aFullVector at: ii)
							* aNumber)]
]

{ #category : #'ops on self' }
FullVector >> at: i plusNumber: aNumber [ 
	self at: i put: (self at: i) + aNumber
]

{ #category : #'ops on self' }
FullVector >> at: i1 putFullVector: aFullVector [ 
	| iOffset |
	iOffset := i1 - 1.
	1 to: aFullVector size do: [:ii | self at: iOffset + ii put: (aFullVector at: ii)]
]

{ #category : #'ops on self' }
FullVector >> at: i1 putFullVector: aFullVector times: number [ 
	| iOffset |
	iOffset := i1 - 1.
	1 to: aFullVector size do: [:ii | self at: iOffset + ii put: (aFullVector at: ii)
				* number]
]

{ #category : #'ops on self' }
FullVector >> at: i times: aNumber [ 
	^self at: i put: (self at: i)
			* aNumber
]

{ #category : #'basic ops' }
FullVector >> cross: aVector [ 
	| a1 a2 a3 b1 b2 b3 answer |
	a1 := self at: 1.
	a2 := self at: 2.
	a3 := self at: 3.
	b1 := aVector at: 1.
	b2 := aVector at: 2.
	b3 := aVector at: 3.
	answer := self class new: 3.
	answer at: 1 put: a2 * b3 - (a3 * b2).
	answer at: 2 put: a3 * b1 - (a1 * b3).
	answer at: 3 put: a1 * b2 - (a2 * b1).
	^answer
]

{ #category : #'ops on self' }
FullVector >> equalFullVector: aFullVector [ 
	1 to: self size do: [:i | self at: i put: (aFullVector at: i)]
]

{ #category : #'ops on self' }
FullVector >> equalFullVector: aFullVector at: ii1 [ 
	| iiOffset |
	iiOffset := ii1 - 1.
	1 to: self size do: [:i | self at: i put: (aFullVector at: iiOffset + i)]
]

{ #category : #'ops on self' }
FullVector >> equalFullVector: aFullVector times: aNumber [ 
	1 to: self size do: [:i | self at: i put: (aFullVector at: i)
				* aNumber]
]

{ #category : #'ops on self' }
FullVector >> equalSelfMinusFullVector: aFullVector [ 
	1 to: self size do: [:i | self at: i put: (self at: i)
				- (aFullVector at: i)]
]

{ #category : #'ops on self' }
FullVector >> equalSelfMinusFullVector: aFullVector at: ii1 [ 
	| iiOffset |
	iiOffset := ii1 - 1.
	1 to: self size do: [:i | self at: i put: (self at: i)
				- (aFullVector at: iiOffset + i)]
]

{ #category : #'ops on self' }
FullVector >> equalSelfMinusFullVector: aFullVector times: aNumber [ 
	1 to: self size do: [:i | self at: i put: (self at: i)
				- ((aFullVector at: i)
						* aNumber)]
]

{ #category : #'ops on self' }
FullVector >> equalSelfMinusSparseVector: aSparseVector [ 
	aSparseVector keysAndValuesDo: [:i :value | self at: i put: (self at: i)
				- value]
]

{ #category : #'ops on self' }
FullVector >> equalSelfMinusSparseVector: aSparseVector times: aNumber [ 
	aSparseVector keysAndValuesDo: [:i :value | self at: i put: (self at: i)
				- (value * aNumber)]
]

{ #category : #'ops on self' }
FullVector >> equalSelfPlusFullVector: aFullVector [ 
	1 to: self size do: [:i | self at: i put: (self at: i)
				+ (aFullVector at: i)]
]

{ #category : #'ops on self' }
FullVector >> equalSelfPlusFullVector: aFullVector at: ii1 [ 
	| iiOffset |
	iiOffset := ii1 - 1.
	1 to: self size do: [:i | self at: i put: (self at: i)
				+ (aFullVector at: iiOffset + i)]
]

{ #category : #'ops on self' }
FullVector >> equalSelfPlusFullVector: aFullVector times: aNumber [ 
	1 to: self size do: [:i | self at: i put: (self at: i)
				+ ((aFullVector at: i)
						* aNumber)]
]

{ #category : #'ops on self' }
FullVector >> equalSelfPlusSparseVector: aSparseVector [ 
	aSparseVector keysAndValuesDo: [:i :value | self at: i put: (self at: i)
				+ value]
]

{ #category : #'ops on self' }
FullVector >> equalSelfPlusSparseVector: aSparseVector times: aNumber [ 
	aSparseVector keysAndValuesDo: [:i :value | self at: i put: (self at: i)
				+ (value * aNumber)]
]

{ #category : #'ops on self' }
FullVector >> equalSelfTimes: alpha minusFullVector: aFullVector times: beta [ 
	1 to: self size do: [:i | self at: i put: (self at: i)
				* alpha - ((aFullVector at: i)
					* beta)]
]

{ #category : #'ops on self' }
FullVector >> equalSelfTimes: alpha plusFullVector: aFullVector times: beta [ 
	1 to: self size do: [:i | self at: i put: (self at: i)
				* alpha + ((aFullVector at: i)
					* beta)]
]

{ #category : #'ops on self' }
FullVector >> fillWithOrdinals [
	1 to: self size do: [:i | self at: i put: i]
]

{ #category : #testing }
FullVector >> iMax [
	"Answer the index of the largest element."

	| answer iMax |
	answer := self at: 1.
	iMax := 1.
	2 to: self size
		do: 
			[:i | 
			| dum |
			dum := self at: i.
			dum > answer
				ifTrue: 
					[answer := dum.
					iMax := i]].
	^iMax
]

{ #category : #testing }
FullVector >> iMin [
	"Answer the index of the smallest element."

	| answer iMin |
	answer := self at: 1.
	iMin := 1.
	2 to: self size
		do: 
			[:i | 
			| dum |
			dum := self at: i.
			dum < answer
				ifTrue: 
					[answer := dum.
					iMin := i]].
	^iMin
]

{ #category : #testing }
FullVector >> isDecreasing [
	"Test if elements are monotonically decreasing."

	^self isDecreasingIfExceptionsAreLessThan: Number zero
]

{ #category : #testing }
FullVector >> isDecreasingIfExceptionsAreLessThan: tol [ 
	"Test if elements are decreasing."
	"Ok if spoilers are less than tol."

	| next |
	next := self at: 1.
	2 to: self size do: [:i | 
			| previous |
			previous := next.
			next := self at: i.
			next < previous ifFalse: [next - previous < tol ifFalse: [^false]]].
	^true
]

{ #category : #testing }
FullVector >> isIncreasing [
	"Test if elements are monotonically increasing."

	^self isIncreasingIfExceptionsAreLessThan: Number zero
]

{ #category : #testing }
FullVector >> isIncreasingIfExceptionsAreLessThan: tol [ 
	"Test if elements are increasing."
	"Ok if spoilers are less than tol."

	| next |
	next := self at: 1.
	2 to: self size do: [:i | 
			| previous |
			previous := next.
			next := self at: i.
			next > previous ifFalse: [previous - next < tol ifFalse: [^false]]].
	^true
]

{ #category : #'basic ops' }
FullVector >> minusFullVector: aFullVector [ 
	"No checking for speed. Assumes correct dimensions and type."

	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				- (aFullVector at: i)].
	^answer
]

{ #category : #'basic ops' }
FullVector >> minusFullVector: aFullVector times: number [ 
	"No checking for speed. Assumes correct dimensions and type."

	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				- ((aFullVector at: i)
						* number)].
	^answer
]

{ #category : #'basic ops' }
FullVector >> minusNumber: aNumber [ 
	"Minus aNumber from each element."
	"Answer new vector."

	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				- aNumber].
	^answer
]

{ #category : #norms }
FullVector >> normL: number [ 
	^(self sumOfElementsRaisedTo: number)
		raisedTo: number reciprocal
]

{ #category : #'ops on self' }
FullVector >> normalizeSelf [
	| length |
	length := self length.
	length = 0 ifTrue: [self error: 'StM: Inappropriate to normalize a null vector.'].
	self magnifySelf: 1.0d / length
]

{ #category : #accessing }
FullVector >> normalized [
	| answer |
	answer := self copy.
	answer normalizeSelf.
	^answer
]

{ #category : #accessing }
FullVector >> numberOfElements [
	"Borrowed from size."

	<primitive: 62>
	^self basicSize
]

{ #category : #printing }
FullVector >> outputOnFile: aString [ 
	| writeStream aij aijString |
	writeStream := aString asFilename writeStream.
	1 to: self size
		do: 
			[:i | 
			aij := self at: i.
			aij == nil ifTrue: [aij := 0.0d].
			aijString := aij printString.
			aijString last == $d
				ifTrue: [aijString replaceAll: $d with: Character space]
				ifFalse: [aijString replaceAll: $d with: $e].
			writeStream nextPutAll: aijString.
			writeStream cr].
	writeStream flush; close
]

{ #category : #'basic ops' }
FullVector >> plusFullVector: aFullVector [ 
	"No checking for speed. Assumes correct dimensions and type."

	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				+ (aFullVector at: i)].
	^answer
]

{ #category : #'basic ops' }
FullVector >> plusFullVector: aFullVector times: number [ 
	"No checking for speed. Assumes correct dimensions and type."

	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				+ ((aFullVector at: i)
						* number)].
	^answer
]

{ #category : #'basic ops' }
FullVector >> plusNumber: aNumber [ 
	"Plus aNumber from each element."
	"Answer new vector."

	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				+ aNumber].
	^answer
]

{ #category : #norms }
FullVector >> rootMeanSquareWeighted: weights [ 
	"Note that the vector is scaled by the weights before the rms."

	| n vector |
	n := self size.
	vector := self class new: n.
	1 to: n do: [:i | vector at: i put: (self at: i)
				* (weights at: i)].
	^vector rootMeanSquare
]

{ #category : #'basic ops' }
FullVector >> scaledWith: scalingVector forRows: i1 to: i2 [ 
	"Return self scaled with scaling vector."

	i1 to: i2 do: [:i | self at: i put: (self at: i)
				* (scalingVector at: i)]
]

{ #category : #'basic ops' }
FullVector >> tildeMatrix [
	"tildeMatrix is related to angular velocity and cross product."

	self size == 3
		ifTrue: 
			[| tilde c1 c2 c3 |
			tilde := FullMatrix new: 3 by: 3.
			c1 := self at: 1.
			c2 := self at: 2.
			c3 := self at: 3.
			tilde at: 1 and: 1 put: 0.0d.
			tilde at: 2 and: 2 put: 0.0d.
			tilde at: 3 and: 3 put: 0.0d.
			tilde at: 2 and: 3 put: 0.0d - c1.
			tilde at: 1 and: 3 put: c2.
			tilde at: 1 and: 2 put: 0.0d - c3.
			tilde at: 2 and: 1 put: c3.
			tilde at: 3 and: 1 put: 0.0d - c2.
			tilde at: 3 and: 2 put: c1.
			^tilde]
		ifFalse: [self error: 'Column is not of dimension 3.']
]

{ #category : #'basic ops' }
FullVector >> times: aNumber [ 
	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				* aNumber].
	^answer
]

{ #category : #'basic ops' }
FullVector >> times: alpha minusFullVector: aFullVector [ 
	"a*alpha + b."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				* alpha - (aFullVector at: i)].
	^answer
]

{ #category : #'basic ops' }
FullVector >> times: beta minusFullVector: aFullVector times: alpha [ 
	"a*alpha + b*beta = b*beta + a*alpha."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				* beta - ((aFullVector at: i)
					* alpha)].
	^answer
]

{ #category : #'basic ops' }
FullVector >> times: alpha plusFullVector: aFullVector [ 
	"a*alpha + b."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				* alpha + (aFullVector at: i)].
	^answer
]

{ #category : #'basic ops' }
FullVector >> times: beta plusFullVector: aFullVector times: alpha [ 
	"a*alpha + b*beta = b*beta + a*alpha."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				* beta + ((aFullVector at: i)
					* alpha)].
	^answer
]

{ #category : #testing }
FullVector >> validateElements [
	"Check that all elements are real numbers."

	1 to: self size do: [:i | (self at: i) isReal ifFalse: [self error: 'StM: Elements of Vector should be real numbers.']]
]
