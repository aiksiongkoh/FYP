Class {
	#name : #Sum,
	#superclass : #'Function_cArg',
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #'VisualWorks metadata' }
Sum class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'instance creation' }
Sum class >> with: arg1 plus: arg2 [ 
	^super with: arg1 with: arg2
]

{ #category : #'instance creation' }
Sum class >> with: arg1 plus: arg2 plus: arg3 [ 
	^super
		with: arg1
		with: arg2
		with: arg3
]

{ #category : #'StCAD-UI' }
Sum >> cadStringOn: aStream [ 
	| nterms |
	nterms := terms size.
	nterms > 1 ifTrue: [aStream nextPut: $(].
	1 to: nterms
		do: 
			[:i | 
			i > 1 ifTrue: [aStream nextPutAll: ' + '].
			(terms at: i)
				cadStringOn: aStream].
	nterms > 1 ifTrue: [aStream nextPut: $)]
]

{ #category : #evaluating }
Sum >> differentiateWRT: variable [ 
	| derivatives answer |
	derivatives := terms collect: [:term | term differentiateWRT: variable].
	answer := self class new.
	answer terms: derivatives.
	^answer
]

{ #category : #evaluating }
Sum >> expandUntil: set [ 
	| stream term newTerms newSize |
	^(set includes: self)
		ifTrue: [self]
		ifFalse: 
			[stream := OrderedCollection new writeStream.
			1 to: terms size
				do: 
					[:i | 
					term := (terms at: i)
								expandUntil: set.
					term isSum
						ifTrue: [stream nextPutAll: term terms]
						ifFalse: [stream nextPut: term]].
			newTerms := stream contents.
			newSize := newTerms size.
			newSize == 0
				ifTrue: [Constant with: 0]
				ifFalse: [newSize == 1
						ifTrue: [newTerms at: 1]
						ifFalse: [(self class new) terms: newTerms; yourself]]]
]

{ #category : #testing }
Sum >> isSum [
	^true
]

{ #category : #evaluating }
Sum >> partialDifferentiateWRT: variable [ 
	| derivatives answer |
	derivatives := terms collect: [:term | term partialDifferentiateWRT: variable].
	answer := self class new.
	answer terms: derivatives.
	^answer
]

{ #category : #printing }
Sum >> printOn: aStream [ 
	aStream nextPut: $(.
	terms ifNotNil: 
			[terms do: [:term | term printOn: aStream]
				separatedBy: [aStream nextPutAll: ' + ']].
	aStream nextPut: $)
]

{ #category : #evaluating }
Sum >> simplifyUntil: set [ 
	| newTerms constant term newSize |
	^(set includes: self)
		ifTrue: [self]
		ifFalse: 
			[newTerms := OrderedCollection new.
			constant := 0.0d.
			1 to: terms size
				do: 
					[:i | 
					term := (terms at: i)
								simplifyUntil: set.
					term isConstant
						ifTrue: [constant := constant + term value]
						ifFalse: [newTerms add: term]].
			constant ~= 0 ifTrue: [newTerms addFirst: (Constant with: constant)].
			newSize := newTerms size.
			newSize == 0
				ifTrue: [Constant with: 0]
				ifFalse: [newSize == 1
						ifTrue: [newTerms at: 1]
						ifFalse: [(self class new) terms: newTerms; yourself]]]
]

{ #category : #accessing }
Sum >> timesFunction: aFunction [ 
	^aFunction timesSum: self
]

{ #category : #accessing }
Sum >> timesProduct: aProduct [ 
	^aProduct timesSum: self
]

{ #category : #accessing }
Sum >> timesSum: aSum [ 
	"(a + b)*(A + B + C) = (a*A + a*B + a*C + b*A + b*B + b*C)"

	| answer sumTERMs termTERM |
	answer := Sum new.
	sumTERMs := aSum terms.
	terms do: [:term | sumTERMs
			do: 
				[:sumTERM | 
				termTERM := sumTERM isProduct
							ifTrue: [term timesProduct: sumTERM]
							ifFalse: [term timesFunction: sumTERM].
				answer terms add: termTERM]].
	^answer
]

{ #category : #evaluating }
Sum >> value [
	| answer |
	answer := 0.0d.
	terms do: [:term | answer := answer + term value].
	^answer
]
