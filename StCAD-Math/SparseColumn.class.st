Class {
	#name : #SparseColumn,
	#superclass : #SparseVector,
	#type : #variable,
	#category : #'StCAD-Math-StMathArraySparse'
}

{ #category : #'VisualWorks metadata' }
SparseColumn class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'ops on self -' }
SparseColumn >> at: i minusFullColumn: aFullColumn [ 
	^super at: i minusFullVector: aFullColumn
]

{ #category : #'ops on self -' }
SparseColumn >> at: i minusFullColumn: aFullColumn times: aNumber [ 
	^super
		at: i
		minusFullVector: aFullColumn
		times: aNumber
]

{ #category : #'ops on self -' }
SparseColumn >> at: i1 minusSparseColumn: aSparseColumn [ 
	super at: i1 minusSparseVector: aSparseColumn
]

{ #category : #'ops on self +' }
SparseColumn >> at: i plusFullColumn: aFullColumn [ 
	^super at: i plusFullVector: aFullColumn
]

{ #category : #'ops on self +' }
SparseColumn >> at: i plusFullColumn: aFullColumn times: aNumber [ 
	^super
		at: i
		plusFullVector: aFullColumn
		times: aNumber
]

{ #category : #'ops on self +' }
SparseColumn >> at: i1 plusSparseColumn: aSparseColumn [ 
	super at: i1 plusSparseVector: aSparseColumn
]

{ #category : #'ops on self' }
SparseColumn >> at: i1 putFullColumn: aFullColumn [ 
	super at: i1 putFullVector: aFullColumn
]

{ #category : #'ops on self' }
SparseColumn >> at: i1 putFullColumn: aFullColumn times: number [ 
	super
		at: i1
		putFullVector: aFullColumn
		times: number
]

{ #category : #'ops on self -' }
SparseColumn >> equalSelfMinusSparseColumn: aSparseColumn [ 
	super equalSelfMinusSparseVector: aSparseColumn
]

{ #category : #'ops on self -' }
SparseColumn >> equalSelfMinusSparseColumn: aSparseColumn times: aNumber [ 
	super equalSelfMinusSparseVector: aSparseColumn times: aNumber
]

{ #category : #'ops on self +' }
SparseColumn >> equalSelfPlusSparseColumn: aSparseColumn [ 
	super equalSelfPlusSparseVector: aSparseColumn
]

{ #category : #'ops on self +' }
SparseColumn >> equalSelfPlusSparseColumn: aSparseColumn times: aNumber [ 
	super equalSelfPlusSparseVector: aSparseColumn times: aNumber
]

{ #category : #'basic ops -' }
SparseColumn >> minusSparseColumn: aSparseColumn [ 
	^super minusSparseVector: aSparseColumn
]

{ #category : #accessing }
SparseColumn >> ncol [
	^1
]

{ #category : #accessing }
SparseColumn >> nrow [
	"Answer the number of elements in the full vector or matrix."

	^fullsize
]

{ #category : #'basic ops +' }
SparseColumn >> plusSparseColumn: aSparseColumn [ 
	^super plusSparseVector: aSparseColumn
]

{ #category : #'basic ops -' }
SparseColumn >> times: alpha minusSparseColumn: aSparseColumn [ 
	^super times: alpha minusSparseVector: aSparseColumn
]

{ #category : #'basic ops +' }
SparseColumn >> times: alpha plusSparseColumn: aSparseColumn [ 
	^super times: alpha plusSparseVector: aSparseColumn
]

{ #category : #'basic ops' }
SparseColumn >> transpose [
	"Return a row with the same elements."
	"This method is much faster than the obvious way."

	^self copy changeClassToThatOf: (SparseRow new: 0)
]
