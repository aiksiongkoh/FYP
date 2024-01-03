"
Based on Numerical Recipes in C, 2nd Edition, page 383.
""Globally Convergent Methods for Nonlinear Systems of Equations.""
y(x) = 0
y(xold) + pypx(xold)*dx + ... = 0
pypx*dx = -y
dx = -pypxInverse*y
xnew = xold + lam*dx              0 < lam =< 1

How to choose lam?
Define scalar function
func = 0.5*|y|^2 = 0.5*yT*y
grad(func) = yT*pypx
grad(func)*dx = (yT*pypx)*(-pypxInverse*y) = -yT*y = -2*func(xold)

Let lam = 1
Acceptance criterion
func(xnew) =< func(xold) + alp*grad(func)*(xnew - xold)               alp = 1.0d-4
or
func(xnew) =< func(xold) + alp*grad(func)*(lam*dx)
func(xnew) =< func(xold) + alp*lam*grad(func)*dx
func(xnew) =< func(xold) - 2*alp*lam*func(xold)
func(xnew)/func(xold) =< 1 - 2*alp*lam

If not accepted
lamPast = lam
Define scalar function
g(lam) = func(xold + lam*dx)
gp(lam) = dgdlam(lam) = grad(func)*dx = -2*func(xold)
g(0) = func(xold)
g(1) = func(xold + dx)
gp(lam) = -2*g(0)
Form quadratic 
g(lam) ~= (g(1) - g(0) - gp(0))*lam^2 + gp(0)*lam + g(0)
g(lam) ~= (g(1) + g(0))*lam^2 - 2*g(0)*lam + g(0)
At minimum
lam = -gp(0)/(2*(g(1) - g(0) - gp(0)))
lam = g(0)/(g(1) + g(0))
Limit 
0.1 =< lam =< 0.5
Apply acceptance criterion, if not accepted,
lamPast = lam
Form cubic
g(lam) = a*lam^3 + b*lam^2 + gp(0)*lam + g(0)
g(lam) = a*lam^3 + b*lam^2 + 2*g(0)*lam + g(0)
Solve for a and b
rhs1 = g(lam) - gp(0)*lam - g(0)
rhs2 = g(lamPast) - gp(0)*lamPast - g(0)
rhs1 = g(lam) + 2*g(0)*lam - g(0) = g(lam) + (2*lam - 1)*g(0)
rhs2 = g(lamPast) + 2*g(0)*lamPast - g(0) = g(lamPast) + (2*lamPast - 1)*g(0)
factor = 1/(lam - lamPast)
a = factor*(rhs1/lam^2 - rhs2/lamPast^2)
b = factor*(-rhs1*lamPast/lam^2 + rhs2*lam/lamPast^2)
At minimum
lam = (-b + sqrt(b^2 - 3*a*gp(0)))/(3*a)
lam = (-b + sqrt(b^2 + 6*a*g(0)))/(3*a)
Limit 
0.1*lamPast =< lam =< 0.5*lamPast


"
Class {
	#name : #NewtonRaphson,
	#superclass : #Solver,
	#instVars : [
		'system',
		'xold',
		'x',
		'dx',
		'dxNorm',
		'dxNorms',
		'dxTol',
		'y',
		'yNorm',
		'yNormOld',
		'yNorms',
		'yNormTol',
		'pypx',
		'iterNo',
		'iterMax',
		'nDivergence',
		'nBackTracking',
		'twoAlp',
		'lam'
	],
	#category : #'StCAD-Math-StMathNewtonRaphson'
}

{ #category : #solving }
NewtonRaphson >> askSystemToUpdate [
	system updateForNewtonRaphson
]

{ #category : #solving }
NewtonRaphson >> calcDXNormImproveRootCalcYNorm [
	self calcdxNorm.
	dxNorms add: dxNorm.
	xold := x.
	self xEqualxoldPlusdx.
	self passRootToSystem.
	self askSystemToUpdate.
	Processor yield.
	self fillY.
	self calcyNorm.
	yNorms add: yNorm.
	yNormOld := yNorm
]

{ #category : #solving }
NewtonRaphson >> calcDXNormImproveRootMinimizeYNorm [
	self calcdxNorm.
	dxNorms add: dxNorm.
	xold := x.
	self xEqualxoldPlusdx.
	self passRootToSystem.
	self askSystemToUpdate.
	Processor yield.
	self fillY.
	self calcyNorm.
	yNorm > yNormTol ifTrue: [yNorm / yNormOld <= (1.0d - twoAlp) ifFalse: [self doBackTracking]].
	yNorms add: yNorm.
	yNormOld := yNorm
]

{ #category : #solving }
NewtonRaphson >> calcdxNorm [
	self subclassResponsibility
]

{ #category : #solving }
NewtonRaphson >> calcyNorm [
	self subclassResponsibility
]

{ #category : #solving }
NewtonRaphson >> doBackTracking [
	"Ref: Numerical Recipies in C, 2nd Ed. p. 383-5."
	"Use gprime(0) = -2*g(0)."

	| g0 glam lamPast glamPast rhs1 rhs2 factor lamSq lamPastSq a b lamMin lamMax |
	g0 := yNormOld.
	glam := yNorm.
	lamPast := 1.0d.
	nBackTracking := nBackTracking + 1.
	lam := g0 / (glam + g0).
	lam := lam max: 0.1d.
	self xEqualxoldPlusdxTimeslam.
	self passRootToSystem.
	self askSystemToUpdate.
	self fillY.
	self calcyNorm.
	[yNorm / yNormOld <= (1.0d - (twoAlp * lam))]
		whileFalse: 
			[glamPast := glam.
			glam := yNorm.
			rhs1 := glam + (2.0d * lam - 1.0d * g0).
			rhs2 := glamPast + (2.0d * lamPast - 1.0d * g0).
			factor := 1.0d / (lam - lamPast).
			lamSq := lam * lam.
			lamPastSq := lamPast * lamPast.
			a := factor * (rhs1 / lamSq - (rhs2 / lamPastSq)).
			b := factor * (0.0d - rhs1 * lamPast / lamSq + (rhs2 * lam / lamPastSq)).
			lamPast := lam.
			nBackTracking := nBackTracking + 1.
			lam := 0.0d - b + (b * b + (6.0d * a * g0)) sqrt / (3.0d * a).
			lamMin := 0.1d * lamPast.
			lamMax := 0.5d * lamPast.
			lam < lamMin
				ifTrue: [lam := lamMin]
				ifFalse: [lam > lamMax ifTrue: [lam := lamMax]].
			self xEqualxoldPlusdxTimeslam.
			self passRootToSystem.
			self askSystemToUpdate.
			self fillY.
			self calcyNorm].
	self dxEqualdxTimeslam
]

{ #category : #solving }
NewtonRaphson >> dxEqualdxTimeslam [
	"New dx is found from backtracking."

	dxNorms removeLast.
	self calcdxNorm.
	dxNorms add: dxNorm
]

{ #category : #accessing }
NewtonRaphson >> dxTol: tol [ 
	dxTol := tol
]

{ #category : #solving }
NewtonRaphson >> fillPyPx [
	self subclassResponsibility
]

{ #category : #solving }
NewtonRaphson >> fillY [
	self subclassResponsibility
]

{ #category : #solving }
NewtonRaphson >> incrementIterNo [
	iterNo := iterNo + 1.
	iterNo > iterMax
		ifTrue: 
			[self reportStats.
			MaximumIterationError raiseSignal]
]

{ #category : #'initialize-release' }
NewtonRaphson >> initialize [
	super initialize.
	dxNorms := OrderedCollection new.
	dxTol := MachineAccuracy OfDoubleTimesFour.
	yNorms := OrderedCollection new.
	yNormTol := 1.0d-30 "StMMachineAccuracy OfDoubleTimesFour".
	iterMax := 100.
	twoAlp := 2.0d-4
]

{ #category : #'initialize-release' }
NewtonRaphson >> initializeLocally [
	"setIndices is a fast way of clearing anOrderedCollection."

	iterNo := 0.
	nDivergence := 0.
	nBackTracking := 0.
	dxNorms setIndices.
	yNorms setIndices.
	yNormOld := MachineAccuracy OfLargestDouble
]

{ #category : #solving }
NewtonRaphson >> isConverged [
	^self isConvergedToNumericalLimit
]

{ #category : #solving }
NewtonRaphson >> isConvergedToNumericalLimit [
	"worthIterating is less stringent with IterNo."

	"nDivergenceMax is the number of small divergences allowed."

	| tooLargeTol smallEnoughTol nDecade dxNormIterNo dxNormIterNoOld farTooLargeError worthIterating stillConverging nDivergenceMax |
	tooLargeTol := 1.0d-2.
	smallEnoughTol := MachineAccuracy OfDouble.
	nDecade := (tooLargeTol / smallEnoughTol) log.
	nDivergenceMax := 3.
	dxNormIterNo := dxNorms at: iterNo.
	^iterNo > 1 
		ifTrue: 
			[dxNormIterNoOld := dxNorms at: iterNo - 1.
			farTooLargeError := dxNormIterNo > tooLargeTol.
			worthIterating := dxNormIterNo 
						> (smallEnoughTol * (10.0d raisedTo: (iterNo - 1) / iterMax * nDecade)).
			stillConverging := dxNormIterNo < (0.5 * dxNormIterNoOld) 
						ifTrue: [true]
						ifFalse: 
							[farTooLargeError ifFalse: [nDivergence := nDivergence + 1].
							nDivergence < nDivergenceMax].
			(farTooLargeError | (worthIterating & stillConverging)) not]
		ifFalse: 
			[worthIterating := dxNormIterNo > smallEnoughTol.
			worthIterating not]
]

{ #category : #solving }
NewtonRaphson >> isConvergedToNumericalLimit1 [
	"worthIterating is less stringent with IterNo."
	"nDivergenceMax is the number of small divergences allowed."

	| tooLargeTol smallEnoughTol nDecade dxNormIterNo dxNormIterNoOld farTooLargeError worthIterating stillConverging nDivergenceMax |
	tooLargeTol := 1.0d.
	smallEnoughTol := 1.0d-18.
	nDecade := (tooLargeTol / smallEnoughTol) log.
	nDivergenceMax := 3.
	dxNormIterNo := dxNorms at: iterNo.
	^iterNo > 1
		ifTrue: 
			[dxNormIterNoOld := dxNorms at: iterNo - 1.
			farTooLargeError := dxNormIterNo > tooLargeTol.
			worthIterating := dxNormIterNo > (smallEnoughTol * (10.0d raisedTo: iterNo - 1 / iterMax * nDecade)).
			stillConverging := dxNormIterNo < dxNormIterNoOld
						ifTrue: [true]
						ifFalse: 
							[farTooLargeError ifFalse: [nDivergence := nDivergence + 1].
							nDivergence < nDivergenceMax].
			(farTooLargeError | (worthIterating & stillConverging)) not]
		ifFalse: 
			[worthIterating := dxNormIterNo > smallEnoughTol.
			worthIterating not]
]

{ #category : #solving }
NewtonRaphson >> isConvergedToNumericalLimit2 [
	"worthIterating is less stringent with IterNo."

	"nDivergenceMax is the number of small divergences allowed."

	| tooLargeTol smallEnoughTol nDecade dxNormIterNo dxNormIterNoOld farTooLargeError worthIterating stillConverging nDivergenceMax |
	tooLargeTol := 1.0d.
	smallEnoughTol := MachineAccuracy OfDouble.
	nDecade := (tooLargeTol / smallEnoughTol) log.
	nDivergenceMax := 3.
	dxNormIterNo := dxNorms at: iterNo.
	^iterNo > 1 
		ifTrue: 
			[dxNormIterNoOld := dxNorms at: iterNo - 1.
			farTooLargeError := dxNormIterNo > tooLargeTol.
			worthIterating := dxNormIterNo 
						> (smallEnoughTol * (10.0d raisedTo: (iterNo - 1) / iterMax * nDecade)).
			stillConverging := dxNormIterNo < (0.5 * dxNormIterNoOld) 
						ifTrue: [true]
						ifFalse: 
							[farTooLargeError ifFalse: [nDivergence := nDivergence + 1].
							nDivergence < nDivergenceMax].
			(farTooLargeError | (worthIterating & stillConverging)) not]
		ifFalse: 
			[worthIterating := dxNormIterNo > smallEnoughTol.
			worthIterating not]
]

{ #category : #accessing }
NewtonRaphson >> iterMax: integer [ 
	iterMax := integer
]

{ #category : #solving }
NewtonRaphson >> iterate [
	"
	Do not skip matrix solution even when yNorm is very small. 
	This avoids unexpected behaviors when convergence is still 
	possible. 
	
	Do not skip redundant constraint removal even when yNorm is 
	zero. 
	"

	iterNo := 0.
	self fillY.
	self calcyNorm.
	yNorms add: yNorm.
	
	[self incrementIterNo.
	self fillPyPx.
	self solveEquations.
	self calcDXNormImproveRootCalcYNorm.
	self isConverged] whileFalse
]

{ #category : #solving }
NewtonRaphson >> iterateWithBackTracking [
	iterNo := 0.
	self fillY.
	self calcyNorm.
	yNorms add: yNorm.
	yNorm < yNormTol ifTrue: ["Initial x is root."
		^self].
	
	[self incrementIterNo.
	self fillPyPx.
	self solveEquations.
	self calcDXNormImproveRootMinimizeYNorm.
	self isConverged] whileFalse
]

{ #category : #solving }
NewtonRaphson >> passRootToSystem [
	system dx: dx x: x
]

{ #category : #solving }
NewtonRaphson >> postRun [
	system postNewtonRaphson
]

{ #category : #solving }
NewtonRaphson >> preRun [
	system preNewtonRaphson
]

{ #category : #solving }
NewtonRaphson >> reportStats [
	statistics at: #iterNo put: iterNo.
	system useNewtonRaphsonStats: statistics
]

{ #category : #solving }
NewtonRaphson >> run [
	self preRun.
	self initializeLocally.
	self initializeGlobally.
	self iterate.
	self finalize.
	self reportStats.
	self postRun.
	^x
]

{ #category : #solving }
NewtonRaphson >> runWithBackTracking [
	self preRun.
	self initializeLocally.
	self initializeGlobally.
	self iterateWithBackTracking.
	self finalize.
	self reportStats.
	self postRun.
	^x
]

{ #category : #solving }
NewtonRaphson >> solveEquations [
	self subclassResponsibility
]

{ #category : #accessing }
NewtonRaphson >> system: sys [ 
	system := sys
]

{ #category : #accessing }
NewtonRaphson >> x [
	^x
]

{ #category : #accessing }
NewtonRaphson >> x: aObject [ 
	x := aObject
]

{ #category : #solving }
NewtonRaphson >> xEqualxoldPlusdx [
	self subclassResponsibility
]

{ #category : #solving }
NewtonRaphson >> xEqualxoldPlusdxTimeslam [
	self subclassResponsibility
]

{ #category : #accessing }
NewtonRaphson >> yNormTol: tol [ 
	yNormTol := tol
]
