Class {
	#name : #Product,
	#superclass : #'Function_cArg',
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #'VisualWorks metadata' }
Product class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'instance creation' }
Product class >> with: arg1 times: arg2 [ 
	^super with: arg1 with: arg2
]

{ #category : #'instance creation' }
Product class >> with: arg1 times: arg2 times: arg3 [ 
	^super
		with: arg1
		with: arg2
		with: arg3
]

{ #category : #'StCAD-UI' }
Product >> cadStringOn: aStream [ 
	1 to: terms size
		do: 
			[:i | 
			i > 1 ifTrue: [aStream nextPutAll: '*'].
			(terms at: i)
				cadStringOn: aStream]
]

{ #category : #evaluating }
Product >> differentiateWRT: variable [ 
	"Apply chain rule of differentiation."
	"(xyz)' := x'yz + xy'z + xyz'."

	| derivatives derivativeTerms derivative newTermFunctions newTerm answer |
	derivatives := terms collect: [:term | term differentiateWRT: variable].
	derivativeTerms := OrderedCollection new.
	1 to: terms size
		do: 
			[:i | 
			derivative := derivatives at: i.
			newTermFunctions := terms shallowCopy.
			newTermFunctions at: i put: derivative.
			newTerm := Product new.
			newTerm terms: newTermFunctions.
			derivativeTerms add: newTerm].
	answer := Sum new.
	answer terms: derivativeTerms.
	^answer
]

{ #category : #evaluating }
Product >> expandUntil: set [ 
	| sumTerms stream term sumOfProductsOfSums factor |
	^(set includes: self)
		ifTrue: [self]
		ifFalse: 
			[sumTerms := OrderedCollection new.
			stream := OrderedCollection new writeStream.
			1 to: terms size
				do: 
					[:i | 
					term := (terms at: i)
								expandUntil: set.
					term isSum
						ifTrue: [sumTerms add: term]
						ifFalse: [term isProduct
								ifTrue: [stream nextPutAll: term terms]
								ifFalse: [stream nextPut: term]]].
			factor := Product new.
			factor terms: stream contents.
			sumOfProductsOfSums := Sum with: 1.
			sumTerms do: [:sumTerm | sumOfProductsOfSums := sumOfProductsOfSums timesSum: sumTerm].
			factor timesSum: sumOfProductsOfSums]
]

{ #category : #testing }
Product >> isProduct [
	^true
]

{ #category : #evaluating }
Product >> partialDifferentiateWRT: variable [ 
	"Apply chain rule of differentiation."
	"(xyz)' := x'yz + xy'z + xyz'."

	| derivatives derivativeTerms derivative newTermFunctions newTerm answer |
	derivatives := terms collect: [:term | term partialDifferentiateWRT: variable].
	derivativeTerms := OrderedCollection new.
	1 to: terms size
		do: 
			[:i | 
			derivative := derivatives at: i.
			newTermFunctions := terms shallowCopy.
			newTermFunctions at: i put: derivative.
			newTerm := Product new.
			newTerm terms: newTermFunctions.
			derivativeTerms add: newTerm].
	answer := Sum new.
	answer terms: derivativeTerms.
	^answer
]

{ #category : #printing }
Product >> printOn: aStream [ 
	terms ifNotNil: 
			[terms do: [:term | term printOn: aStream]
				separatedBy: [aStream nextPut: $*]]
]

{ #category : #evaluating }
Product >> simplifyUntil: set [ 
	| newTerms factor term newSize |
	^(set includes: self)
		ifTrue: [self]
		ifFalse: 
			[newTerms := OrderedCollection new.
			factor := 1.0d.
			1 to: terms size
				do: 
					[:i | 
					term := (terms at: i)
								simplifyUntil: set.
					term isConstant
						ifTrue: [factor := factor * term value]
						ifFalse: [newTerms add: term]].
			factor = 0
				ifTrue: [Constant with: 0]
				ifFalse: 
					[factor ~= 1 ifTrue: [newTerms addFirst: (Constant with: factor)].
					newSize := newTerms size.
					newSize == 0
						ifTrue: [Constant with: 1]
						ifFalse: [newSize == 1
								ifTrue: [newTerms at: 1]
								ifFalse: [(self class new) terms: newTerms; yourself]]]]
]

{ #category : #accessing }
Product >> timesFunction: aFunction [ 
	| answer |
	answer := self copy.
	answer terms add: aFunction copy.
	^answer
]

{ #category : #accessing }
Product >> timesProduct: aProduct [ 
	| answer |
	answer := self copy.
	answer terms addAll: aProduct copy terms.
	^answer
]

{ #category : #accessing }
Product >> timesSum: aSum [ 
	"(a*b*c)*(A + B + C) = (a*b*c*A + a*b*c*B + a*b*c*C)"

	| answer sumTERMs termTERM |
	answer := Sum new.
	sumTERMs := aSum terms.
	sumTERMs
		do: 
			[:sumTERM | 
			termTERM := sumTERM isProduct
						ifTrue: [self timesProduct: sumTERM]
						ifFalse: [self timesFunction: sumTERM].
			answer terms add: termTERM].
	^answer
]

{ #category : #evaluating }
Product >> value [
	| answer |
	answer := 1.0d.
	terms do: [:term | answer := answer * term value].
	^answer
]
