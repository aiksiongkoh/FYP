"
Abstract class of all linear equations solvers.

Instance Variables:

m	<Integer>	row size of matrix.
n	<Integer>	column size of matrix.
matrixA	<StMRowTypeMatrix>	a kind of row type matrix.
answerX	<StMFullColumn>	solution.
rightHandSideB	<StMFullColumn>	right hand side vector.
rowOrder	<StMArray>	given row position as index, answer the original matrix row number.
colOrder	<StMArray>	given column position as index, answer the original matrix column number.
rowScalings	<StMFullColumn>	scaling factors to normalize each row so aij <= 1.0d.
pivotValues	<StMFullColumn>	values of pivots used.
singularPivotTolerance	<Double>	
millisecondsToRun	<Integer>	
"
Class {
	#name : #MatrixSolver,
	#superclass : #Solver,
	#instVars : [
		'm',
		'n',
		'matrixA',
		'answerX',
		'rightHandSideB',
		'rowOrder',
		'colOrder',
		'rowScalings',
		'pivotValues',
		'singularPivotTolerance',
		'millisecondsToRun'
	],
	#category : #'StCAD-Math-StMathMatrixSolver'
}

{ #category : #testing }
MatrixSolver class >> isAbstractClass [
	^true
]

{ #category : #'VisualWorks metadata' }
MatrixSolver class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #solution }
MatrixSolver >> basicSolve: aMatrix with: aVector saveOriginal: saveOriginal [ 
	self subclassResponsibility
]

{ #category : #accessing }
MatrixSolver >> colOrder [
	^colOrder
]

{ #category : #pivoting }
MatrixSolver >> doPivoting: p [ 
	"Matrices consist of rows of elements."
	"Row pivoting is actually carried out."
	"Column pivoting is done in-place."

	self subclassResponsibility
]

{ #category : #scaling }
MatrixSolver >> findScalingsForRows: i1 to: i2 [ 
	"Row element * scaling <= 1.0."

	| maxRowElement |
	rowScalings := FullColumn new: m.
	i1 to: i2
		do: 
			[:i | 
			maxRowElement := (matrixA at: i) maxElement.
			maxRowElement > 0 ifFalse: [SingularMatrixError raiseSignal].
			rowScalings at: i put: maxRowElement reciprocal]
]

{ #category : #'initialize-release' }
MatrixSolver >> initialize [
	super initialize.
	singularPivotTolerance := MachineAccuracy OfDoubleTimesFour
]

{ #category : #accessing }
MatrixSolver >> millisecondsToRun [
	^millisecondsToRun
]

{ #category : #accessing }
MatrixSolver >> pivotValues [
	^pivotValues
]

{ #category : #solution }
MatrixSolver >> postSolve [
	self subclassResponsibility
]

{ #category : #solution }
MatrixSolver >> preSolve: aMatrix with: aVector saveOriginal: saveOriginal [ 
	self subclassResponsibility
]

{ #category : #accessing }
MatrixSolver >> rhsZeroElement [
	| rhs1 |
	rhs1 := rightHandSideB at: 1.
	^rhs1 isSequenceable
		ifTrue: [rhs1 zeroCopy]
		ifFalse: [0.0d]
]

{ #category : #accessing }
MatrixSolver >> rowOrder [
	^rowOrder
]

{ #category : #accessing }
MatrixSolver >> singularPivotTolerance: double [ 
	singularPivotTolerance := double asDouble
]

{ #category : #solution }
MatrixSolver >> solve: aMatrix with: aVector saveOriginal: saveOriginal [ 
	self
		timedSolve: aMatrix
		with: aVector
		saveOriginal: saveOriginal.
	millisecondsToRun > 500 ifTrue: [ObjectMemory garbageCollect].
	^answerX
]

{ #category : #solution }
MatrixSolver >> timedSolve: aMatrix with: aVector saveOriginal: saveOriginal [ 
	millisecondsToRun := nil.
	millisecondsToRun := Time millisecondsToRun: [self
					basicSolve: aMatrix
					with: aVector
					saveOriginal: saveOriginal].
	"Transcript cr; show: millisecondsToRun printString."
	^answerX
]
