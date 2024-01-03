Class {
	#name : #Integrator,
	#superclass : #Solver,
	#instVars : [
		'system',
		'direction'
	],
	#category : #'StCAD-Math-StMathIntegrator'
}

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
