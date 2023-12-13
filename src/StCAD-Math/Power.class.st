Class {
	#name : #Power,
	#superclass : #FunctionXY,
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #'VisualWorks metadata' }
Power class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'instance creation' }
Power class >> with: base raisedTo: exponent [ 
	^super new x: base y: exponent
]

{ #category : #'StCAD-UI' }
Power >> cadStringOn: aStream [ 
	x cadStringOn: aStream.
	aStream nextPutAll: '^'.
	y cadStringOn: aStream
]

{ #category : #evaluating }
Power >> differentiateWRTx [
	| ycopy |
	ycopy := y copy.
	^ycopy times: (x copy raisedTo: (ycopy plus: -1)) simplified
]

{ #category : #evaluating }
Power >> differentiateWRTy [
	^(self copy times: (Ln with: x copy)) simplified
]

{ #category : #evaluating }
Power >> simplifyUntil: set [ 
	| xx yy copy |
	(set includes: self)
		ifTrue: [^self].
	xx := x simplifyUntil: set.
	yy := y simplifyUntil: set.
	copy := self class with: xx with: yy.
	xx isConstant
		ifTrue: 
			[xx isZero ifTrue: [^Constant with: 0].
			xx isOne ifTrue: [^Constant with: 1].
			yy isConstant ifTrue: [^Constant with: copy value]]
		ifFalse: [yy isConstant
				ifTrue: 
					[yy isZero ifTrue: [^Constant with: 1].
					yy isOne ifTrue: [^xx]]].
	^copy
]

{ #category : #evaluating }
Power >> value [
	^x value raisedTo: y value
]
