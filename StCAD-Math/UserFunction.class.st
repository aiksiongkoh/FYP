"
CAD user units
The CAD user defines units for time, mass, aJ, length, angle, velocity, omega, acceleration, alpha, force, torque. Internally, GEO stores everything in SI units. We want to store all user inputs as formulas in text form so that user inputs are repeatable and not mutated by numerical errors. We also want to store past formulas for possible reuse or parametric study. 

What happens when the CAD user decided to change his units? 
We modify the formulas symbolically by the conversion factors and save the previous formulas.

What must a formula store?
A formula must store the text of the formula, its own unit, units for the functions and variables in the formula, past formulas and its container.


Instance Variables:

"
Class {
	#name : #UserFunction,
	#superclass : #Symbolic,
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #'binary storage' }
UserFunction class >> binaryReaderBlockForVersion: oldVersion format: oldFormat [ 
	"Change order from 
	'funcText' 'units' 
	'funcText' 'myUnit' 'units'"

	oldVersion == nil
		ifTrue: 
			[| inst |
			inst := BasicUserFunction basicNew.
			^
			[:oldObj | 
			| new |
			new := Array new: 3.
			new at: 1 put: (oldObj at: 1).
			new at: 2 put: 1.0d.
			new at: 3 put: (oldObj at: 2).
			oldObj become: new.
			oldObj changeClassToThatOf: inst]].
	^super binaryReaderBlockForVersion: oldVersion format: oldFormat
]

{ #category : #'binary storage' }
UserFunction class >> binaryRepresentationVersion [
	^30
]

{ #category : #'VisualWorks metadata' }
UserFunction class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #testing }
UserFunction >> isUserFunction [
	^true
]
