Class {
	#name : #DAECorrector,
	#superclass : #VectorNewtonRaphson,
	#category : #'StCAD-Math-StMathNewtonRaphson'
}

{ #category : #'VisualWorks metadata' }
DAECorrector class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #solving }
DAECorrector >> askSystemToUpdate [
	system updateForDAECorrector
]

{ #category : #solving }
DAECorrector >> calcdxNorm [
	"Subclasses can modify calculation of dxNorm."

	dxNorm := system corErrorNormFrom: dx wrt: x
]

{ #category : #solving }
DAECorrector >> fillPyPx [
	pypx := system calcG
]

{ #category : #solving }
DAECorrector >> fillY [
	y := system fillF
]

{ #category : #solving }
DAECorrector >> handleSingularMatrix [
	(matrixSolver isMemberOf: GESpMatParPvMarkoFast) 
		ifTrue: 
			[matrixSolver := GESpMatParPvPrecise new.
			self solveEquations]
		ifFalse: 
			[(matrixSolver isMemberOf: GESpMatParPvPrecise) 
				ifTrue: [SingularMatrixError raiseSignal]
				ifFalse: [self halt: 'Check this.']]
]

{ #category : #'initialize-release' }
DAECorrector >> initialize [
	super initialize.
	statistics := IdentityDictionary new
]

{ #category : #'initialize-release' }
DAECorrector >> initializeGlobally [
	iterMax := system iterMax.
	x := system y.
	matrixSolver := self matrixSolverClass new
]

{ #category : #solving }
DAECorrector >> isConverged [
	^system isConvergedFor: iterNo and: dxNorms
]

{ #category : #solving }
DAECorrector >> logSingularMatrixMessage [
	self logString: #'MbD: \Singular matrix encountered.'
]

{ #category : #accessing }
DAECorrector >> matrixSolverClass [
	"	^OldFasterSpMatGEParPv2"

	"	^StMGESpMatParPvPrecise3"

	^GESpMatParPvMarkoFast
]

{ #category : #solving }
DAECorrector >> passRootToSystem [
	system y: x
]

{ #category : #solving }
DAECorrector >> postRun [
	system postDAECorrector
]

{ #category : #solving }
DAECorrector >> preRun [
	system preDAECorrector
]

{ #category : #solving }
DAECorrector >> reportStats [
	statistics at: #iterNo put: iterNo.
	system useDAECorrectorStats: statistics
]
