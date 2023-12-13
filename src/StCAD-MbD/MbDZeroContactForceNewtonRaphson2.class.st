Class {
	#name : #MbDZeroContactForceNewtonRaphson2,
	#superclass : #MbDTimeNewtonRaphson2,
	#category : #'StCAD-MbD-MbDSolver'
}

{ #category : #'VisualWorks metadata' }
MbDZeroContactForceNewtonRaphson2 class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #solving }
MbDZeroContactForceNewtonRaphson2 >> fillPyPx [
	pypx := system contactForceDerivative: 1 at: x
]

{ #category : #solving }
MbDZeroContactForceNewtonRaphson2 >> fillY [
	y := system contactForceAt: x
]
