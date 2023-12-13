Class {
	#name : #SymbolicParser,
	#superclass : #ExternalLanguageParser,
	#instVars : [
		'variables'
	],
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #'VisualWorks metadata' }
SymbolicParser class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'Kernel'
	)

]

{ #category : #'error handling' }
SymbolicParser >> expected: aString [ 
	"Notify a problem at token 'here'"

	^self notify: aString , ' expected ->' at: mark
]

{ #category : #accessing }
SymbolicParser >> functions [
	^self intrinsicFunctions
]

{ #category : #'initialize-release' }
SymbolicParser >> initVariables [
	variables := IdentityDictionary new.
	self variablesSet do: [:item | variables at: item name asSymbol put: item]
]

{ #category : #accessing }
SymbolicParser >> intrinsicFunctions [
	"The methods 'intrinsic' and 'intrinsicFunctions' must have the same functions."

	| functions |
	functions := OrderedCollection new.
	functions add: ArcTan.
	functions add: ArcTan2.
	functions add: Cos.
	functions add: Exp.
	functions add: InverseOfSpectralDensity.
	functions add: Lg.
	functions add: Ln.
	functions add: Sin.
	functions add: GeneralSpline.
	functions add: Sqrt.
	functions add: Tan.
	^functions
]

{ #category : #'error handling' }
SymbolicParser >> notify: aString [ 
	"Notify problem at token before 'here'"

	^self notify: aString at: mark
]

{ #category : #scanning }
SymbolicParser >> signedNumber [
	"Recognize a possibly signed number."

	tokenType == #number
		ifTrue: 
			[stack addLast: token.
			self scanToken.
			^true].
	(token = $+ and: [hereChar notNil and: [hereChar isDigit or: [hereChar = $.]]])
		ifTrue: 
			["no intervening delimiters"
			self scanToken.
			stack addLast: token.
			self scanToken.
			^true].
	(token = $- and: [hereChar notNil and: [hereChar isDigit or: [hereChar = $.]]])
		ifTrue: 
			["no intervening delimiters"
			self scanToken.
			stack addLast: token negated.
			self scanToken.
			^true].
	^false
]

{ #category : #accessing }
SymbolicParser >> variables [
	^variables
]

{ #category : #'initialize-release' }
SymbolicParser >> variablesSet [
	| set |
	set := Set new.
	^set
]

{ #category : #scanning }
SymbolicParser >> xDigit [
	"form a number"

	tokenType := #number.
	hereChar == nil ifFalse: [source skip: -1].
	token := Number importFrom: source.
	hereChar := source next
]
