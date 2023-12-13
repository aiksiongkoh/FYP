Extension { #name : #Number }

{ #category : #'*StCAD-Math-StCAD-Math' }
Number >> asPrettyDouble [
	"1.1 asPrettyDouble gives 1.1d"
	"1.1 asDouble gives 1.1000000238419d"
	"1.1e-2 asPrettyDouble gives 0.011d"
	"1.1e-2 asDouble gives 0.010999999940395d"

	^Double readFrom: self printString readStream
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Number >> cyclic: n [ 
	"cyclic value from 1 to n."

	^(self - 1) \\ n + 1
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Number class >> importDouble: integerPart from: aStream [
	"Answer an instance of me as described on the stream, aStream."

	| value coercionClass possibleCoercionClass precision digit num den exp neg endOfNumber eChar |
	precision := 0.
	num := 0.
	den := 1.
	coercionClass := Integer.
	(aStream peekFor: $.)
		ifTrue: 
			["<integer>.<fraction>"
			(aStream atEnd not
				and: [aStream peek isDigit or: [#($e $d) includes: aStream peek asLowercase]])
					ifTrue: 
						[| atEnd |
						coercionClass := Float.
						[(atEnd := aStream atEnd) or: [(digit := aStream next) isDigit not]]
							whileFalse: 
								[num := num * 10 + digit digitValue.
								precision := precision + 1].
						den := 10 ** precision.
						atEnd ifFalse: [aStream skip: -1]]
					ifFalse: 
						["oops - just <integer>."
						"un-gobble the period"
						aStream skip: -1]].
	eChar := aStream peek.
	eChar == nil
		ifTrue: [possibleCoercionClass := nil]
		ifFalse: 
			[eChar := eChar asLowercase.
			possibleCoercionClass := self chooseFloatRepresentationFor: eChar.
			possibleCoercionClass == nil ifFalse: [aStream next]].
	exp := nil.
	possibleCoercionClass == nil
		ifFalse: 
			[coercionClass := possibleCoercionClass.
			endOfNumber := aStream position.
			neg := (aStream peekFor: $+) ifTrue: [false] ifFalse: [aStream peekFor: $-].
			((digit := aStream peek) notNil and: [digit isDigit])
				ifTrue: 
					[exp := self readIntegerFrom: aStream radix: 10.
					neg ifTrue: [exp := exp negated]]
				ifFalse: [aStream position: endOfNumber]].
	value := integerPart + (num / den).
	coercionClass := coercionClass == Integer
				ifTrue: [Integer]
				ifFalse: [Double].	"The exponent will be added in the next step."
	^self
		coerce: value
		to: coercionClass
		precision: precision
		exponent: exp
		exponentChar: eChar
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Number class >> importFrom: aStream [ 
	"Answer an instance of me as described on the stream, aStream."

	| value neg |
	(aStream atEnd or: [aStream peek isLetter])
		ifTrue: [^0].
	neg := (aStream peekFor: $+)
				ifTrue: [false]
				ifFalse: [aStream peekFor: $-].
	value := self readIntegerFrom: aStream radix: 10.
	value := self importDouble: value from: aStream.
	^neg
		ifTrue: [value negated]
		ifFalse: [value]
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Number >> isDouble [
	^false
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Number >> y: y z: z [

	^ StCAD_Math_FullColumn with: self with: y with: z "VW_TRANSLATION:StCAD.Math.FullColumn:StCAD_Math_FullColumn"
]

{ #category : #'*StCAD-Math-StCAD-Math' }
Number >> yd: y zd: z [

	^ StCAD_Math_FullColumn
		  with: self asDouble
		  with: y asDouble
		  with: z asDouble "VW_TRANSLATION:StCAD.Math.FullColumn:StCAD_Math_FullColumn"
]
