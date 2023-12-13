Class {
	#name : #Extrapolator,
	#superclass : #DifferenceOperator,
	#category : #'StCAD-Math-StMathDifferenceOperator'
}

{ #category : #'VisualWorks metadata' }
Extrapolator class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #calc }
Extrapolator class >> with: x1 [
    ^x1
]

{ #category : #calc }
Extrapolator class >> with: x1 and: x2 [
    "Extrapolate to present with past values."

    ^2.0 * x1 - x2
]

{ #category : #calc }
Extrapolator class >> with: x1 and: x2 and: x3 [
    ^3.0 * x1 - (3.0 * x2) + x3
]

{ #category : #calc }
Extrapolator class >> with: x1 and: x2 and: x3 and: x4 [
    ^4.0 * x1 - (6.0 * x2) + (4.0 * x3) - x4
]

{ #category : #calc }
Extrapolator class >> with: x1 and: x2 and: x3 and: x4 and: x5 [
    ^5.0 * x1 - (10.0 * x2) + (10.0 * x3) - (5.0 * x4) + x5
]

{ #category : #calc }
Extrapolator class >> with: x1 and: x2 and: x3 and: x4 and: x5 and: x6 [
    ^6.0 * x1 - (15.0 * x2) + (20.0 * x3) - (15.0 * x4) + (6.0 * x5) - x6
]

{ #category : #calc }
Extrapolator >> formTaylorMatrix [
	"
	For method order 3: 
	|	1	(t1 - t)	(t1 - t)^2/2!		(t1 - t)^3/3!	|	|q(t)	|	=	|q(t1)	| 
	|	1	(t2 - t)	(t2 - t)^2/2!		(t2 - t)^3/3!	|	|qd(t)	|		|q(t2)	| 
	|	1	(t3 - t)	(t3 - t)^2/2!		(t3 - t)^3/3!	|	|qdd(t)	|		|q(t3)	| 
	|	1	(t4 - t)	(t4 - t)^2/2!		(t4 - t)^3/3!	|	|qddd(t)|		|q(t4)	| 
	"

	self instanciateTaylorMatrix.
	1 to: order + 1 do: [:i | self
			formTaylorRow: i
			withTimeNode: i
			derivative: 0]
]
