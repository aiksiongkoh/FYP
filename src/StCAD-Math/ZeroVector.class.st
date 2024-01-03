Class {
	#name : #ZeroVector,
	#superclass : #VerySparseVector,
	#instVars : [
		'size'
	],
	#category : #'StCAD-Math-StMathArraySpecial'
}

{ #category : #converting }
ZeroVector >> asZeroVector [
	^self
]

{ #category : #accessing }
ZeroVector >> at: aInteger [ 
	^self elementClass zero
]

{ #category : #'initialize - release' }
ZeroVector >> initialize: aInteger [ 
	size := aInteger
]

{ #category : #'ops on self' }
ZeroVector >> magnifySelf: aNumber [ 
	"Do nothing."
]

{ #category : #'basic ops *' }
ZeroVector >> productFromTranspose: aObject [ 
	^aObject transposeTimesZeroVector: self
]

{ #category : #'ops on self' }
ZeroVector >> replaceElementsFrom: i1 to: i2 withArray: aArray startingAt: ii1 [ 
	| newArray |
	i2 - i1 + 1 == size
		ifTrue: [newArray := aArray copyFrom: ii1 to: ii1 + size - 1]
		ifFalse: 
			[newArray := aArray class new: size.
			newArray zeroSelf.
			newArray
				replaceFrom: i1
				to: i2
				with: aArray
				startingAt: ii1].
	self become: newArray
]

{ #category : #'ops on self' }
ZeroVector >> replaceFrom: start to: stop with: replacement startingAt: repStart [ 
	"This destructively replaces elements from start to stop in the 
	receiver starting at index, repStart, in the collection, replacement. 
	Answer the receiver. No range checks are performed, but 
	overlapping replacements are handled correctly."

	^replacement
		startingAt: repStart
		replaceElementsIn: self
		from: start
		to: stop
]

{ #category : #accessing }
ZeroVector >> size [
	^size
]

{ #category : #'ops on self' }
ZeroVector >> startingAt: i3 times: aNumber replaceElementsIn: aVector from: i1 to: i2 [ 
	"Used for double dispatching."
	"See its sender and the message it sends."

	^aVector
		replaceFrom: i1
		to: i2
		withZeroVector: self
		startingAt: i3
		times: aNumber
]

{ #category : #'ops on self' }
ZeroVector >> startingAt: ii1 times: aNumber sumFromThenReplaceElementsIn: aVector from: i1 to: i2 [ 
	"Do nothing."
]

{ #category : #'ops on self' }
ZeroVector >> startingAt: i3 to: i4 times: aNumber replaceElementsIn: aMatrix from: i1 and: j1 [ 
	"Used for double dispatching."
	"See its sender and the message it sends."

	^aMatrix
		replaceFrom: i1
		and: j1
		withZeroVector: self
		startingAt: i3
		to: i4
		times: aNumber
]

{ #category : #'basic ops *' }
ZeroVector >> transposeTimesDiagonalMatrix: aDiagonalMatrix [ 
	"aTb := a(i)b(i,j) sum i."

	^self class new: aDiagonalMatrix ncol
]

{ #category : #'basic ops *' }
ZeroVector >> transposeTimesFullMatrix: aFullMatrix [ 
	"aTb := a(i)b(i,j) sum i."

	^self class new: aFullMatrix ncol
]

{ #category : #'basic ops *' }
ZeroVector >> transposeTimesZeroMatrix: aZeroMatrix [ 
	"aT*b = a(i)b(i,j) sum i."

	^self class new: aZeroMatrix ncol
]
