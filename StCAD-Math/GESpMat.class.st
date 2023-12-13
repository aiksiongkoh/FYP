"
Sparse matrix solvers.

Instance Variables:

markowitzPivotRowCount	<Integer>	number of non zeros in row minus one.
markowitzPivotColCount	<Integer>	number of non zeros in column minus one.
privateIndicesOfNonZerosInPivotRow	<OrderedCollection>	depends on implementation of IdentityDictionary.
rowPositionsOfNonZerosInPivotColumn	<OrderedCollection>	
"
Class {
	#name : #GESpMat,
	#superclass : #MatrixGaussElimination,
	#instVars : [
		'markowitzPivotRowCount',
		'markowitzPivotColCount',
		'privateIndicesOfNonZerosInPivotRow',
		'rowPositionsOfNonZerosInPivotColumn'
	],
	#category : #'StCAD-Math-StMathMatrixSolver'
}

{ #category : #'VisualWorks metadata' }
GESpMat class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'forward elimination' }
GESpMat >> privateIndicesOfNonZerosInPivotRow: pivotRow withoutKey: discardKey [ 
	"pivotRow is aStMSparseRow."

	| count index key |
	count := 0.
	index := 1.
	markowitzPivotRowCount := pivotRow tally - 1.
	privateIndicesOfNonZerosInPivotRow setIndices.
	[count < markowitzPivotRowCount]
		whileTrue: 
			[key := pivotRow basicAt: index.
			key == nil ifFalse: [key == discardKey
					ifFalse: 
						[count := count + 1.
						privateIndicesOfNonZerosInPivotRow add: index]].
			index := index + 1]
]
