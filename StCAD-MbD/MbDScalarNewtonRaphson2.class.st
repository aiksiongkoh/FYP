Class {
	#name : #MbDScalarNewtonRaphson2,
	#superclass : #ScalarNewtonRaphson,
	#category : #'StCAD-MbD-MbDSolver'
}

{ #category : #'VisualWorks metadata' }
MbDScalarNewtonRaphson2 class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #solving }
MbDScalarNewtonRaphson2 >> askSystemToUpdate [
	"Do nothing."
]

{ #category : #solving }
MbDScalarNewtonRaphson2 >> run [
	self preRun.
	self initializeLocally.
	self initializeGlobally.
	self iterate.
"	self finalize. "
"	self reportStats. "
"	self postRun."
	^x
]
