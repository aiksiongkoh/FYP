Class {
	#name : #IdentityMatrix,
	#superclass : #SpecialMatrix,
	#instVars : [
		'nrow'
	],
	#category : #'StCAD-Math-StMathArraySpecial'
}

{ #category : #'instance creation' }
IdentityMatrix class >> new: aInteger [ 
	^(super basicNew: 0)
		initialize: aInteger
]

{ #category : #'VisualWorks metadata' }
IdentityMatrix class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'basic ops *' }
IdentityMatrix >> * anObject [ 
	^anObject
]

{ #category : #converting }
IdentityMatrix >> asIdentityMatrix [
	^self
]

{ #category : #accessing }
IdentityMatrix >> at: i and: j [ 
	^i == j
		ifTrue: [self elementClass unity]
		ifFalse: [self elementClass zero]
]

{ #category : #'initialize - release' }
IdentityMatrix >> initialize: aInteger [ 
	nrow := aInteger
]

{ #category : #testing }
IdentityMatrix >> isDiagonal [
	^true
]

{ #category : #testing }
IdentityMatrix >> isIdentity [
	^true
]

{ #category : #accessing }
IdentityMatrix >> ncol [
	^nrow
]

{ #category : #accessing }
IdentityMatrix >> nrow [
	^nrow
]

{ #category : #accessing }
IdentityMatrix >> numberOfElements [
	"Answer the number of elements in the full vector or matrix."

	^nrow * nrow
]

{ #category : #'basic ops *' }
IdentityMatrix >> productFromTranspose: aObject [ 
	^aObject transpose
]

{ #category : #'ops on self' }
IdentityMatrix >> startingAt: i3 and: j3 replaceElementsIn: aVector from: i1 to: i2 [ 
	"OK to use FullMatrix version."

	^aVector
		replaceFrom: i1
		to: i2
		withFullMatrix: self
		startingAt: i3
		and: j3
]

{ #category : #'ops on self' }
IdentityMatrix >> startingAt: ii1 and: jj1 sumFromThenReplaceElementsIn: aMatrix from: i1 and: j1 to: i2 and: j2 [ 
	"This destructively replaces elements from start to stop in the 
	collection starting at index, repStart, in the receiver. 
	Answer the collection."

	^aMatrix
		replaceFrom: i1
		and: j1
		to: i2
		and: j2
		withSelfPlusIdentityMatrix: self
		startingAt: ii1
		and: jj1
		times: self elementClass unity
]

{ #category : #'ops on self' }
IdentityMatrix >> startingAt: i3 and: j3 times: aNumber replaceElementsIn: aVector from: i1 to: i2 [ 
	"OK to use FullMatrix version."

	^aVector
		replaceFrom: i1
		to: i2
		withFullMatrix: self
		startingAt: i3
		and: j3
		times: aNumber
]

{ #category : #'ops on self' }
IdentityMatrix >> startingAt: i3 and: j3 times: aNumber sumFromThenReplaceElementsIn: aMatrix from: i1 and: j1 to: i2 and: j2 [ 
	"This destructively replaces elements from start to stop in the 
	collection starting at index, repStart, in the receiver. 
	Answer the collection."

	^aMatrix
		replaceFrom: i1
		and: j1
		to: i2
		and: j2
		withSelfPlusIdentityMatrix: self
		startingAt: i3
		and: j3
		times: aNumber
]
