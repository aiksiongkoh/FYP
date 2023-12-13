Class {
	#name : #ZeroMatrix,
	#superclass : #SpecialMatrix,
	#instVars : [
		'nrow',
		'ncol'
	],
	#category : #'StCAD-Math-StMathArraySpecial'
}

{ #category : #'instance creation' }
ZeroMatrix class >> new: nrow by: ncol [ 
	^(super basicNew: 0)
		initialize: nrow by: ncol
]

{ #category : #'VisualWorks metadata' }
ZeroMatrix class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #accessing }
ZeroMatrix >> at: i and: j [ 
	^self elementClass zero
]

{ #category : #'initialize - release' }
ZeroMatrix >> initialize: nrow1 by: ncol1 [ 
	nrow := nrow1.
	ncol := ncol1
]

{ #category : #accessing }
ZeroMatrix >> ncol [
	^ncol
]

{ #category : #accessing }
ZeroMatrix >> nrow [
	^nrow
]

{ #category : #accessing }
ZeroMatrix >> numberOfElements [
	"Answer the number of elements in the full vector or matrix."

	^nrow * ncol
]

{ #category : #'ops on self +' }
ZeroMatrix >> startingAt: ii1 and: jj1 times: aNumber sumFromThenReplaceElementsIn: aMatrix from: i1 and: j1 to: i2 and: j2 [ 
	"Do nothing."
]

{ #category : #'basic ops *' }
ZeroMatrix >> timesFullColumn: aFullColumn [ 
	^ZeroColumn new: self nrow
]

{ #category : #'basic ops *' }
ZeroMatrix >> timesFullMatrix: anObject [ 
	^self class new: self nrow by: anObject ncol
]

{ #category : #'basic ops *' }
ZeroMatrix >> timesZeroVector: aZeroVector [ 
	"a*b = a(i,j)b(j) sum j."

	^aZeroVector class new: self nrow
]
