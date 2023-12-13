Class {
	#name : #StartingBasicDAEIntegrator,
	#superclass : #BasicDAEIntegrator,
	#instVars : [
		'startingBDF'
	],
	#category : #'StCAD-Math-StMathIntegrator'
}

{ #category : #'VisualWorks metadata' }
StartingBasicDAEIntegrator class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #run }
StartingBasicDAEIntegrator >> calcOperatorMatrix [
	super calcOperatorMatrix.
	startingBDF calcOperatorMatrix
]

{ #category : #accessing }
StartingBasicDAEIntegrator >> correctorBDF [
	^startingBDF
]

{ #category : #run }
StartingBasicDAEIntegrator >> dyOrderPlusOnedt [
	^startingBDF
		derivative: order + 1
		present: y
		past: ypast
		presentDerivative: ydot
		pastDerivative: ydotpast
]

{ #category : #accessing }
StartingBasicDAEIntegrator >> iStep: integer [ 
	super iStep: integer.
	startingBDF iStep: integer.
	istep > orderMax
		ifTrue: 
			[startingBDF changeClassToThatOf: StableBackwardDifference basicNew.
			self changeClassToThatOf: NormalBasicDAEIntegrator basicNew]
]

{ #category : #'initialize-release' }
StartingBasicDAEIntegrator >> initialize [
	super initialize.
	startingBDF := StableStartingBDF new.
	startingBDF timeNodes: tpast
]

{ #category : #'initialize-release' }
StartingBasicDAEIntegrator >> initializeLocally [
	super initializeLocally.
	startingBDF initializeLocally
]

{ #category : #accessing }
StartingBasicDAEIntegrator >> order: integer [ 
	super order: integer.
	startingBDF order: integer + 1
]

{ #category : #accessing }
StartingBasicDAEIntegrator >> time: double [ 
	super time: double.
	startingBDF time: double
]

{ #category : #accessing }
StartingBasicDAEIntegrator >> yDeriv: integer [ 
	^startingBDF
		derivative: integer
		present: y
		past: ypast
		presentDerivative: ydot
		pastDerivative: ydotpast
]

{ #category : #accessing }
StartingBasicDAEIntegrator >> yDeriv: integer at: time [ 
	^startingBDF
		derivative: integer
		at: time
		present: y
		past: ypast
		presentDerivative: ydot
		pastDerivative: ydotpast
]
