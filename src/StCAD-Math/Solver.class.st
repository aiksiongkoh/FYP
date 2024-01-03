"
messages	<IdentityDictionary> Stores messages to be passed out for various conditions encountered. Initialized by the user.
	statistics	<IdentityDictionary> Stores statistics of the solution process.
"
Class {
	#name : #Solver,
	#superclass : #Object,
	#instVars : [
		'statistics'
	],
	#category : #'StCAD-Math-StMathMatrixSolver'
}

{ #category : #'initialize-release' }
Solver >> initialize [
	"Do nothing."
]

{ #category : #'initialize-release' }
Solver >> initializeGlobally [
	self subclassResponsibility
]

{ #category : #'initialize-release' }
Solver >> initializeLocally [
	"Default is do nothing."
]
