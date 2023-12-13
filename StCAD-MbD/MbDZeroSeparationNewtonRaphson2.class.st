Class {
	#name : #MbDZeroSeparationNewtonRaphson2,
	#superclass : #MbDTimeNewtonRaphson2,
	#category : #'StCAD-MbD-MbDSolver'
}

{ #category : #'VisualWorks metadata' }
MbDZeroSeparationNewtonRaphson2 class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #solving }
MbDZeroSeparationNewtonRaphson2 >> fillPyPx [
	pypx := system separationDerivative: 1 at: x
]

{ #category : #solving }
MbDZeroSeparationNewtonRaphson2 >> fillY [
	y := system separationAt: x
]
