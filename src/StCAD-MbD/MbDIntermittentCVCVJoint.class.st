Class {
	#name : #MbDIntermittentCVCVJoint,
	#superclass : #MbDCVCVJoint,
	#instVars : [
		'tstart',
		'contactForce',
		'contactForcePast',
		'separation',
		'separationPast',
		'interpolator',
		'newtonRaphson',
		'leastSquaresFit',
		'unusedConstraints',
		'coeffRestitution',
		'impactVelocity',
		'impactVelocityPast',
		'impulseStart',
		'normalImpulse'
	],
	#category : #'StCAD-MbD-MbDJoint'
}

{ #category : #accessing }
MbDIntermittentCVCVJoint >> aIeJeOIez [
	| aAjOIe aIeJeO |
	aAjOIe := frmI aAjOe: 3.
	aIeJeO := frmJ aOeO minusFullColumn: frmI aOeO.
	^aAjOIe dot: aIeJeO
]

{ #category : #accessing }
MbDIntermittentCVCVJoint >> coeffRestitution: aDouble [ 
	coeffRestitution := [aDouble asDouble]
				on: MessageNotUnderstood do: [:ex | 0.0d]
]

{ #category : #'initialize-release' }
MbDIntermittentCVCVJoint >> connectsI: mkrII toJ: mkrJJ [ 
	super connectsI: mkrII toJ: mkrJJ.
	frmI isOnClosedCurve
		ifFalse: 
			[self logString: #'MbD: \Intermittent curve-curve contact requires the curve for %1 be closed.' withArgument: frmI name printString.
			SimulationStoppingError raiseSignal]
]

{ #category : #accessing }
MbDIntermittentCVCVJoint >> contactForceTol [
	^1.0d-5
]

{ #category : #accessing }
MbDIntermittentCVCVJoint >> impactVelocityTol [
	^1.0d-6
]

{ #category : #'initialize-release' }
MbDIntermittentCVCVJoint >> initialize [
	super initialize.
	contactForcePast := OrderedCollection new.
	separationPast := OrderedCollection new.
	impactVelocityPast := OrderedCollection new.
	unusedConstraints := OrderedCollection new
]

{ #category : #accessing }
MbDIntermittentCVCVJoint >> interpolator [
	^interpolator
]

{ #category : #accIC }
MbDIntermittentCVCVJoint >> postAccIC [
	self recordContactForceAndSeparationDistance
]

{ #category : #dynamic }
MbDIntermittentCVCVJoint >> postDynOutput [
	self recordContactForceAndSeparationDistance.
	rIeJe postDynOutput
]

{ #category : #dynamic }
MbDIntermittentCVCVJoint >> postDynStep [
	self recordContactForceAndSeparationDistance.
	rIeJe postDynStep
]

{ #category : #dynamic }
MbDIntermittentCVCVJoint >> preDyn [
	super preDyn.
	interpolator := TheMbDSystem mbdSystemSolver opBDF.
	leastSquaresFit := LeastSquaresFitPolynomial new
]

{ #category : #dynamic }
MbDIntermittentCVCVJoint >> preDynOutput [
	self recordContactForceAndSeparationDistance.
	rIeJe preDynOutput
]

{ #category : #accessing }
MbDIntermittentCVCVJoint >> separationTol [
	^1.0d-4
]

{ #category : #dynamic }
MbDIntermittentCVCVJoint >> storeDynState [
	contactForcePast addFirst: contactForce.
	separationPast addFirst: separation.
	[interpolator timeNodes size < contactForcePast size]
		whileTrue: 
			[contactForcePast removeLast.
			separationPast removeLast]
]

{ #category : #accessing }
MbDIntermittentCVCVJoint >> tstart [
	^tstart
]

{ #category : #accessing }
MbDIntermittentCVCVJoint >> tstart: aDouble [ 
	tstart := aDouble
]

{ #category : #accessing }
MbDIntermittentCVCVJoint >> vIeJeOIez [
	| aAjOIe vIeJeO |
	aAjOIe := frmI aAjOe: 3.
	vIeJeO := frmJ vOeO minusFullColumn: frmI vOeO.
	^aAjOIe dot: vIeJeO
]
