Class {
	#name : #GEOTimePosVelAccDynData,
	#superclass : #GEOTimePosVelAccData,
	#instVars : [
		'rfpf',
		'aAfp',
		'mass',
		'aJpp'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'VisualWorks metadata' }
GEOTimePosVelAccDynData class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
GEOTimePosVelAccDynData >> aAfp: mat [ 
	aAfp := mat
]

{ #category : #accessing }
GEOTimePosVelAccDynData >> aJpp: mat [ 
	aJpp := mat
]

{ #category : #accessing }
GEOTimePosVelAccDynData >> angularKineticEnergy [
	| omeOpp |
	omeOpp := aAOf transpose timesFullColumn: omeOfO.
	^(omeOpp dot: (aJpp timesFullColumn: omeOpp))
		/ 2.0d
]

{ #category : #accessing }
GEOTimePosVelAccDynData >> angularMomentum [
	^self angularMomentump length
]

{ #category : #accessing }
GEOTimePosVelAccDynData >> angularMomentumO1 [
	^(aAOf row: 1)
		dot: self angularMomentump
]

{ #category : #accessing }
GEOTimePosVelAccDynData >> angularMomentumO2 [
	^(aAOf row: 2)
		dot: self angularMomentump
]

{ #category : #accessing }
GEOTimePosVelAccDynData >> angularMomentumO3 [
	^(aAOf row: 3)
		dot: self angularMomentump
]

{ #category : #accessing }
GEOTimePosVelAccDynData >> angularMomentump [
	| omeOpp |
	omeOpp := aAOf transpose timesFullColumn: omeOfO.
	^aJpp timesFullColumn: omeOpp
]

{ #category : #accessing }
GEOTimePosVelAccDynData >> dataTypes [
	| answer |
	answer := super dataTypes.
	answer add: #linearMomentumO1.
	answer add: #linearMomentumO2.
	answer add: #linearMomentumO3.
	answer add: #linearMomentum.
	answer add: #angularMomentumO1.
	answer add: #angularMomentumO2.
	answer add: #angularMomentumO3.
	answer add: #angularMomentum.
	answer add: #inertialForceO1.
	answer add: #inertialForceO2.
	answer add: #inertialForceO3.
	answer add: #inertialForce.
	answer add: #inertialTorqueO1.
	answer add: #inertialTorqueO2.
	answer add: #inertialTorqueO3.
	answer add: #inertialTorque.
	answer add: #linearKineticEnergy.
	answer add: #angularKineticEnergy.
	answer add: #totalKineticEnergy.
	^answer
]

{ #category : #accessing }
GEOTimePosVelAccDynData >> inertialForce [
	^aOfO length * mass
]

{ #category : #accessing }
GEOTimePosVelAccDynData >> inertialForceO1 [
	^(aOfO at: 1)
		* mass negated
]

{ #category : #accessing }
GEOTimePosVelAccDynData >> inertialForceO2 [
	^(aOfO at: 2)
		* mass negated
]

{ #category : #accessing }
GEOTimePosVelAccDynData >> inertialForceO3 [
	^(aOfO at: 3)
		* mass negated
]

{ #category : #accessing }
GEOTimePosVelAccDynData >> inertialTorque [
	^self inertialTorquep length
]

{ #category : #accessing }
GEOTimePosVelAccDynData >> inertialTorqueO1 [
	^(aAOf row: 1)
		dot: self inertialTorquep
]

{ #category : #accessing }
GEOTimePosVelAccDynData >> inertialTorqueO2 [
	^(aAOf row: 2)
		dot: self inertialTorquep
]

{ #category : #accessing }
GEOTimePosVelAccDynData >> inertialTorqueO3 [
	^(aAOf row: 3)
		dot: self inertialTorquep
]

{ #category : #accessing }
GEOTimePosVelAccDynData >> inertialTorquep [
	| omeOpp alpOpp |
	omeOpp := aAOf transpose timesFullColumn: omeOfO.
	alpOpp := aAOf transpose timesFullColumn: alpOfO.
	^((aJpp timesFullColumn: alpOpp)
		+ (omeOpp cross: (aJpp timesFullColumn: omeOpp))) negated
]

{ #category : #accessing }
GEOTimePosVelAccDynData >> linearKineticEnergy [
	^vOfO sumOfSquares * mass / 2.0d
]

{ #category : #accessing }
GEOTimePosVelAccDynData >> linearMomentum [
	^vOfO length * mass
]

{ #category : #accessing }
GEOTimePosVelAccDynData >> linearMomentumO1 [
	^(vOfO at: 1)
		* mass
]

{ #category : #accessing }
GEOTimePosVelAccDynData >> linearMomentumO2 [
	^(vOfO at: 2)
		* mass
]

{ #category : #accessing }
GEOTimePosVelAccDynData >> linearMomentumO3 [
	^(vOfO at: 3)
		* mass
]

{ #category : #accessing }
GEOTimePosVelAccDynData >> mass: double [ 
	mass := double
]

{ #category : #accessing }
GEOTimePosVelAccDynData >> rfpf: col [ 
	rfpf := col
]

{ #category : #accessing }
GEOTimePosVelAccDynData >> totalKineticEnergy [
	^self linearKineticEnergy + self angularKineticEnergy
]
