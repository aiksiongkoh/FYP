Class {
	#name : #Integrator,
	#superclass : #Solver,
	#instVars : [
		'system',
		'direction'
	],
	#category : #'StCAD-Math-StMathIntegrator'
}

{ #category : #'class initialization' }
Integrator class >> initSignals [
	IntegratorError notifierString: #'StM: Integrator error'; nameClass: self message: #integratorError.
	DiscontinuityError notifierString: #'StM: A discontinuity is found.'; nameClass: self message: #discontinuityError.
	TooManyTriesError notifierString: #'StM: Number of tries exceeded.'; nameClass: self message: #tooManyTriesError.
	TooSmallStepSizeError notifierString: #'StM: Step size is too small.'; nameClass: self message: #tooSmallStepSizeError
]

{ #category : #'class initialization' }
Integrator class >> initialize [
	"StMIntegrator initialize."

	self initSignals
]

{ #category : #'VisualWorks metadata' }
Integrator class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #accessing }
Integrator >> direction [
	^direction
]

{ #category : #accessing }
Integrator >> direction: double [ 
	direction := double
]

{ #category : #output }
Integrator >> logString: string [ 
	system logString: string
]

{ #category : #output }
Integrator >> logString: string withArgument: string1 [ 
	system logString: string withArgument: string1
]

{ #category : #output }
Integrator >> logString: string withArguments: arrayOfStrings [ 
	system logString: string withArguments: arrayOfStrings
]

{ #category : #accessing }
Integrator >> system: object [ 
	system := object
]
