Class {
	#name : #NormalBasicDAEIntegrator,
	#superclass : #BasicDAEIntegrator,
	#instVars : [
		'opBDFhigher'
	],
	#category : #'StCAD-Math-StMathIntegrator'
}

{ #category : #'VisualWorks metadata' }
NormalBasicDAEIntegrator class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #run }
NormalBasicDAEIntegrator >> calcOperatorMatrix [
	super calcOperatorMatrix.
	opBDFhigher calcOperatorMatrix
]

{ #category : #accessing }
NormalBasicDAEIntegrator >> correctorBDF [
	^opBDF
]

{ #category : #run }
NormalBasicDAEIntegrator >> dyOrderPlusOnedt [
	^opBDFhigher
		derivative: order + 1
		present: y
		past: ypast
]

{ #category : #accessing }
NormalBasicDAEIntegrator >> iStep: integer [ 
	super iStep: integer.
	opBDFhigher iStep: integer
]

{ #category : #'initialize-release' }
NormalBasicDAEIntegrator >> initialize [
	super initialize.
	opBDFhigher := StableBackwardDifference new.
	opBDFhigher timeNodes: tpast
]

{ #category : #'initialize-release' }
NormalBasicDAEIntegrator >> initializeLocally [
	"NormalBasicDAEIntegrator is not used for starting an integration."
	"Change to StartingBasicDAEIntegrator."

	super initializeLocally.
	opBDFhigher changeClassToThatOf: StableStartingBDF basicNew.
	opBDFhigher initializeLocally.
	self changeClassToThatOf: StartingBasicDAEIntegrator basicNew
]

{ #category : #accessing }
NormalBasicDAEIntegrator >> order: integer [ 
	super order: integer.
	opBDFhigher order: integer + 1
]

{ #category : #run }
NormalBasicDAEIntegrator >> selectOrder [
	self selectOrderNormal
]

{ #category : #accessing }
NormalBasicDAEIntegrator >> time: double [ 
	super time: double.
	opBDFhigher time: double
]

{ #category : #accessing }
NormalBasicDAEIntegrator >> yDeriv: integer [ 
	^opBDF
		derivative: integer
		present: y
		past: ypast
]

{ #category : #accessing }
NormalBasicDAEIntegrator >> yDeriv: integer at: time [ 
	^opBDF
		derivative: integer
		at: time
		present: y
		past: ypast
]
