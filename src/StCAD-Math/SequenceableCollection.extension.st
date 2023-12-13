Extension { #name : #SequenceableCollection }

{ #category : #'*StCAD-Math-StCAD-Math' }
SequenceableCollection >> asFullColumn [

	| aStMFullColumn |
	aStMFullColumn := StCAD_Math_FullColumn new: self size. "VW_TRANSLATION:StCAD.Math.FullColumn:StCAD_Math_FullColumn"
	1 to: self size do: [ :index | 
	aStMFullColumn at: index put: (self at: index) ].
	^ aStMFullColumn
]

{ #category : #'*StCAD-Math-StCAD-Math' }
SequenceableCollection >> cyclic_at: i [ 
	"
	self cyclic_at: 0 = self at: n.
	self cyclic_at: n+1 = self at: 1.
	"

	^self at: (i - 1) \\ self size + 1
]

{ #category : #'*StCAD-Math-StCAD-Math' }
SequenceableCollection >> isDecreasing [
	| next previous |
	self size < 2 ifTrue: [self error: 'Vector has less than two elements.'].
	next := self at: 1.
	2 to: self size
		do: 
			[:i | 
			previous := next.
			next := self at: i.
			next < previous ifFalse: [^false]].
	^true
]

{ #category : #'*StCAD-Math-StCAD-Math' }
SequenceableCollection >> isDecreasingIfExceptionsAreLessThan: double [ 
	"Test if elements are decreasing."
	"Ok if spoilers are less than double."

	| next previous |
	self size < 2 ifTrue: [self error: 'Vector has less than two elements.'].
	next := self at: 1.
	2 to: self size
		do: 
			[:i | 
			previous := next.
			next := self at: i.
			next < previous ifFalse: [next < double ifFalse: [^false]]].
	^true
]

{ #category : #'*StCAD-Math-StCAD-Math' }
SequenceableCollection >> isIncreasing [
	| next previous |
	self size < 2 ifTrue: [self error: 'Vector has less than two elements.'].
	next := self at: 1.
	2 to: self size
		do: 
			[:i | 
			previous := next.
			next := self at: i.
			next > previous ifFalse: [^false]].
	^true
]
