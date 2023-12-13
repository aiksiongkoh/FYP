Class {
	#name : #EulerAngles,
	#superclass : #EulerArray,
	#type : #variable,
	#instVars : [
		'rotOrder',
		'cA',
		'aA'
	],
	#category : #'StCAD-Math-StMathArray'
}

{ #category : #'instance creation' }
EulerAngles class >> new [
	^(super new: 3) initialize
]

{ #category : #'instance creation' }
EulerAngles class >> symbolic: firstObject with: secondObject with: thirdObject [ 
	^self 
		with: firstObject
		with: secondObject
		with: thirdObject
]

{ #category : #'VisualWorks metadata' }
EulerAngles class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'instance creation' }
EulerAngles class >> with: firstObject with: secondObject with: thirdObject [ 
	^(super 
		with: firstObject
		with: secondObject
		with: thirdObject)
		initialize;
		yourself
]

{ #category : #accessing }
EulerAngles >> aA [
	^aA
]

{ #category : #accessing }
EulerAngles >> aTime [
	self do: [:aAngle | aAngle aIndependentVariable ifNotNil: [:aVar | ^aVar]].
	^nil
]

{ #category : #accessing }
EulerAngles >> cA [
	^cA
]

{ #category : #calc }
EulerAngles >> calc [
	cA := Array new: 3.
	1 to: 3
		do: 
			[:i | 
			| axis angle matA |
			axis := rotOrder at: i.
			angle := (self at: i) value.
			matA := axis == 1 
						ifTrue: [FullMatrix rotatex: angle]
						ifFalse: 
							[axis == 2 
								ifTrue: [FullMatrix rotatey: angle]
								ifFalse: 
									[axis == 3 
										ifTrue: [FullMatrix rotatez: angle]
										ifFalse: 
											[self 
												error: 'Euler angle rotation order must be any permutation of 1,2,3 without consecutive repeats.']]].
			cA at: i put: matA].
	aA := (cA at: 1) timesFullMatrix: ((cA at: 2) timesFullMatrix: (cA at: 3))
]

{ #category : #calc }
EulerAngles >> calcSymbolic [
	cA := Array new: 3.
	1 to: 3
		do: 
			[:i | 
			| axis angle matA |
			axis := rotOrder at: i.
			angle := self at: i.
			matA := axis == 1 
						ifTrue: [FullMatrix rotateSymbolicx: angle]
						ifFalse: 
							[axis == 2 
								ifTrue: [FullMatrix rotateSymbolicy: angle]
								ifFalse: 
									[axis == 3 
										ifTrue: [FullMatrix rotateSymbolicz: angle]
										ifFalse: 
											[self 
												error: 'Euler angle rotation order must be any permutation of 1,2,3 without consecutive repeats.']]].
			cA at: i put: matA].
	aA := ((cA at: 1) 
				timesFullMatrix: ((cA at: 2) timesFullMatrix: (cA at: 3))) simplified
]

{ #category : #calc }
EulerAngles >> differentiateWRT: var [ 
	| answer |
	answer := EulerAnglesDot with: self.
	1 to: 3
		do: 
			[:i | 
			| angle angleVel |
			angle := self at: i.
			angleVel := (angle differentiateWRT: var) simplified.
			answer at: i put: angleVel].
	^answer
]

{ #category : #'initialize-release' }
EulerAngles >> initialize [
	rotOrder := Array 
				with: 1
				with: 2
				with: 3
]

{ #category : #accessing }
EulerAngles >> rotOrder [
	^rotOrder
]

{ #category : #accessing }
EulerAngles >> rotOrder: col [ 
	rotOrder := col
]
