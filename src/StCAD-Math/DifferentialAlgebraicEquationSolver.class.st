Class {
	#name : #DifferentialAlgebraicEquationSolver,
	#superclass : #Solver,
	#instVars : [
		'n',
		't',
		'y',
		'ydot',
		'aF',
		'pFpy',
		'pFpydot',
		'tstart',
		'tend',
		'hout',
		'hmin',
		'hmax',
		'orderMax',
		'iterMax',
		'relativeTol',
		'absoluteTol',
		'touts',
		'youts',
		'ydotouts'
	],
	#category : #'StCAD-Math-StMathIntegrator'
}

{ #category : #'instance creation' }
DifferentialAlgebraicEquationSolver class >> new: size [ 
	^super new initialize: size
]

{ #category : #'VisualWorks metadata' }
DifferentialAlgebraicEquationSolver class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #accessing }
DifferentialAlgebraicEquationSolver >> aFAt: i put: eqn [ 
	aF at: i put: eqn
]

{ #category : #accessing }
DifferentialAlgebraicEquationSolver >> absoluteTol: double [ 
	absoluteTol := double
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> checkForDiscontinuity [
	"Do nothing."
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> correctorAbsoluteTolerance [
	^self toleranceVectorFrom: absoluteTol
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> correctorRelativeTolerance [
	^self toleranceVectorFrom: relativeTol
]

{ #category : #accessing }
DifferentialAlgebraicEquationSolver >> endTime [
	^tend
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> fillF: col [ 
	1 to: n do: [:i | col at: i put: (aF at: i) value asDouble]
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> fillY: col [ 
	1 to: n do: [:i | col at: i put: (y at: i) value asDouble]
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> fillYdot: col [ 
	1 to: n do: [:i | col at: i put: (ydot at: i) value asDouble]
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> fillpFpy: mat [ 
	| rowi pFipy |
	1 to: n
		do: 
			[:i | 
			rowi := mat at: i.
			pFipy := pFpy at: i.
			pFipy keysAndValuesDo: [:j :pFipyj | rowi at: j put: pFipyj value asDouble]]
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> fillpFpydot: mat [ 
	| rowi pFipydot |
	1 to: n
		do: 
			[:i | 
			rowi := mat at: i.
			pFipydot := pFpydot at: i.
			pFipydot keysAndValuesDo: [:j :pFipydotj | rowi at: j put: pFipydotj value asDouble]]
]

{ #category : #accessing }
DifferentialAlgebraicEquationSolver >> firstOutputTime [
	^tstart
]

{ #category : #accessing }
DifferentialAlgebraicEquationSolver >> hmax: double [ 
	hmax := double
]

{ #category : #accessing }
DifferentialAlgebraicEquationSolver >> hmin: double [ 
	hmin := double
]

{ #category : #accessing }
DifferentialAlgebraicEquationSolver >> hout: double [ 
	hout := double
]

{ #category : #'initialize-release' }
DifferentialAlgebraicEquationSolver >> initialize: size [ 
	n := size.
	y := FullColumn new: size.
	ydot := FullColumn new: size.
	aF := FullColumn new: size.
	pFpy := SparseMatrix new: size by: size.
	pFpydot := SparseMatrix new: size by: size.
	touts := OrderedCollection new.
	youts := OrderedCollection new.
	ydotouts := OrderedCollection new
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> integrationAbsoluteTolerance [
	"Answer integrationAbsoluteTolerance vector with nil for algebraic equations."

	^self integrationToleranceVectorFrom: absoluteTol
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> integrationRelativeTolerance [
	"Answer integrationRelativeTolerance vector with nil for algebraic equations."

	^self integrationToleranceVectorFrom: relativeTol
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> integrationToleranceVectorFrom: tol [ 
	"Answer integrationTolerance vector with nil for algebraic equations."

	| answer |
	answer := self toleranceVectorFrom: tol.
	1 to: n do: [:i | (pFpydot at: i) isZero ifTrue: [answer at: i put: nil]].
	^answer
]

{ #category : #accessing }
DifferentialAlgebraicEquationSolver >> iterMax [
	^iterMax
]

{ #category : #accessing }
DifferentialAlgebraicEquationSolver >> iterMax: integer [ 
	iterMax := integer
]

{ #category : #output }
DifferentialAlgebraicEquationSolver >> logString: string [ 
	Transcript show: string mbdMessage
]

{ #category : #output }
DifferentialAlgebraicEquationSolver >> logString: string withArgument: string1 [ 
	Transcript show: (string mbdMessage expandWithArgument: string1)
]

{ #category : #output }
DifferentialAlgebraicEquationSolver >> logString: string withArguments: arrayOfStrings [ 
	Transcript show: (string mbdMessage expandWithArguments: arrayOfStrings)
]

{ #category : #accessing }
DifferentialAlgebraicEquationSolver >> maxStepSize [
	^hmax
]

{ #category : #accessing }
DifferentialAlgebraicEquationSolver >> minStepSize [
	^hmin
]

{ #category : #accessing }
DifferentialAlgebraicEquationSolver >> n [
	^n
]

{ #category : #accessing }
DifferentialAlgebraicEquationSolver >> neqn [
	^n
]

{ #category : #accessing }
DifferentialAlgebraicEquationSolver >> orderMax [
	^orderMax
]

{ #category : #accessing }
DifferentialAlgebraicEquationSolver >> orderMax: integer [ 
	orderMax := integer
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> output [
	"Do nothing."

	touts add: t value.
	youts add: (y collect: [:yi | yi value]).
	ydotouts add: (ydot collect: [:ydoti | ydoti value])
]

{ #category : #output }
DifferentialAlgebraicEquationSolver >> outputOnFile: aString [ 
	| writeStream block numberString |
	writeStream := aString asFilename writeStream.
	block := 
			[:var :string | 
			| varname |
			varname := var name.
			varname := varname isNil
						ifTrue: [string]
						ifFalse: [varname asString].
			writeStream nextPutAll: varname; nextPut: $,].
	block value: t value: 't'.
	1 to: n do: [:j | block value: (y at: j)
			value: 'y' , j printString].
	1 to: n do: [:j | block value: (ydot at: j)
			value: 'ydot' , j printString].
	writeStream cr.
	block := 
			[:number | 
			numberString := number asDouble printString.
			numberString last == $d
				ifTrue: [numberString replaceAll: $d with: Character space]
				ifFalse: [numberString replaceAll: $d with: $e].
			writeStream nextPutAll: numberString.
			writeStream nextPut: $,].
	1 to: touts size
		do: 
			[:i | 
			| youti ydotouti |
			block value: (touts at: i).
			youti := youts at: i.
			ydotouti := ydotouts at: i.
			1 to: n do: [:j | block value: (youti at: j)].
			1 to: n do: [:j | block value: (ydotouti at: j)].
			writeStream cr].
	writeStream flush; close
]

{ #category : #accessing }
DifferentialAlgebraicEquationSolver >> outputStepSize [
	^hout
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> postDAECorrector [
	"Do nothing."
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> postDAEFirstStep [
	"Do nothing."
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> postDAEIntegrator [
	"Do nothing."
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> postDAEOutput [
	"Do nothing."
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> postDAEPredictor [
	"Do nothing."
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> postDAEStep [
	"Do nothing."
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> preDAECorrector [
	"Do nothing."
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> preDAEFirstStep [
	"Do nothing."
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> preDAEIntegrator [
	(y detect: [:yi | yi value isReal not]
		ifNone: [false])
		ifTrue: [self error: 'Variables must have initial values.'].
	(aF detect: [:aFi | aFi value isReal not]
		ifNone: [false])
		ifTrue: [self error: 'Equations must be valid.'].
	1 to: n
		do: 
			[:i | 
			| pFipy pFipydot aFi |
			pFipy := pFpy at: i.
			pFipydot := pFpydot at: i.
			aFi := aF at: i.
			1 to: n
				do: 
					[:j | 
					| pFipyj pFipydotj |
					pFipyj := (aFi partialDifferentiateWRT: (y at: j)) simplified.
					pFipyj isZero ifFalse: [pFipy at: j put: pFipyj].
					pFipydotj := (aFi partialDifferentiateWRT: (ydot at: j)) simplified.
					pFipydotj isZero ifFalse: [pFipydot at: j put: pFipydotj]]]
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> preDAEOutput [
	"Do nothing."
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> preDAEPredictor [
	"Do nothing."
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> preDAEStep [
	"Do nothing."
]

{ #category : #accessing }
DifferentialAlgebraicEquationSolver >> relativeTol: double [ 
	relativeTol := double
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> run [
	| daeIntegrator |
	daeIntegrator := DAEIntegrator new.
	daeIntegrator system: self.
	daeIntegrator run
]

{ #category : #accessing }
DifferentialAlgebraicEquationSolver >> startTime [
	^tstart
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> suggestSmallerOrAcceptFirstStepSize: hnew [ 
	"Default is return hnew."
	"Best to do nothing so as not to disrupt the starting algorithm."

	^hnew
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> suggestSmallerOrAcceptStepSize: hnew [ 
	"Default is return hnew."
	"Best to do nothing so as not to disrupt the algorithm."

	^hnew
]

{ #category : #accessing }
DifferentialAlgebraicEquationSolver >> t: var [ 
	t := var
]

{ #category : #accessing }
DifferentialAlgebraicEquationSolver >> tend: double [ 
	tend := double
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> time: aDouble [ 
	t value: aDouble
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> toleranceVectorFrom: tol [ 
	"Answer tolerance vector."
	"tol may be number or array."
	"nil elements are not used in tolerance calculations."

	| answer toli |
	answer := FullColumn new: n.
	tol isReal
		ifTrue: [answer atAllPut: tol asDouble]
		ifFalse: [tol isSequenceable
				ifTrue: [tol size == n
						ifTrue: [1 to: n
								do: 
									[:i | 
									toli := tol at: i.
									toli isReal ifTrue: [answer at: i put: toli asDouble]]]
						ifFalse: [self error: 'Tolerance vector must have equal dimension as equation set.']]
				ifFalse: [self error: 'Tolerance value is not properly defined.']].
	^answer
]

{ #category : #accessing }
DifferentialAlgebraicEquationSolver >> tstart: double [ 
	tstart := double
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> updateForDAECorrector [
	"Do nothing."
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> useDAEStats: stats [ 
	"Do nothing."
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> useDAEStepStats: stats [ 
	"Do nothing."
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> useDAETrialStepStats: stats [ 
	| array |
	array := Array new: 6.
	array at: 1 put: (stats at: #istep) printString.
	array at: 2 put: (stats at: #t) asFloat printString.
	array at: 3 put: (stats at: #order) printString.
	array at: 4 put: (stats at: #h) asFloat printString.
	array at: 5 put: (stats at: #corIterNo) printString.
	array at: 6 put: (stats at: #truncError) asFloat printString.
	self logString: #'StM: \%1 , t=%2 , o=%3 , h=%4 , it=%5 , e=%6' withArguments: array
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> y: col [ 
	1 to: n do: [:i | (y at: i)
			value: (col at: i)]
]

{ #category : #accessing }
DifferentialAlgebraicEquationSolver >> yAt: i put: var [ 
	y at: i put: var
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> yddot: col [ 
	"Do nothing."
]

{ #category : #solving }
DifferentialAlgebraicEquationSolver >> ydot: col [ 
	1 to: n do: [:i | (ydot at: i)
			value: (col at: i)]
]

{ #category : #accessing }
DifferentialAlgebraicEquationSolver >> ydotAt: i put: var [ 
	ydot at: i put: var
]
