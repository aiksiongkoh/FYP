"
Missing comment
"
Class {
	#name : #GeoFrame,
	#superclass : #CartesianFrame,
	#category : #'StCAD-MbD-StCAD-MbD-Basic'
}

{ #category : #'VisualWorks metadata' }
GeoFrame class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'ops on self' }
GeoFrame >> beSymbolic [
	| cEulerAngle cEulerAngleVel cEulerAngleAcc |
	rFfF := FullColumn 
				with: (Parameter name: #rpmp1)
				with: (Parameter name: #rpmp2)
				with: (Parameter name: #rpmp3).
	self cEulerAngle: (EulerAngles 
				with: (Parameter name: #bryantpm1)
				with: (Parameter name: #bryantpm2)
				with: (Parameter name: #bryantpm3)).
	cEulerAngle := self cEulerAngle.
	cEulerAngle calcSymbolic.
	aAFf := cEulerAngle aA.
	rOfO := (self rOFO + (self aAOF timesFullColumn: rFfF)) simplified.
	aAOf := (self aAOF timesFullMatrix: aAFf) simplified.
	vFfF := (rFfF differentiateWRT: self aTime) simplified.
	cEulerAngleVel := (cEulerAngle differentiateWRT: self aTime) simplified.
	cEulerAngleVel calcSymbolic.
	omeFfF := cEulerAngleVel omeF.
	vOfO := (rOfO differentiateWRT: self aTime) simplified.
	omeOfO := (self omeOFO + (self aAOF timesFullColumn: omeFfF)) simplified.
	aFfF := (vFfF differentiateWRT: self aTime) simplified.
	cEulerAngleAcc := (cEulerAngleVel differentiateWRT: self aTime) simplified.
	cEulerAngleAcc calcSymbolic.
	alpFfF := cEulerAngleAcc alpF.
	aOfO := (vOfO differentiateWRT: self aTime) simplified.
	alpOfO := (omeOfO differentiateWRT: self aTime) simplified.
	body beSymbolic.
	cSub do: [:aFrame | aFrame beSymbolic]
]

{ #category : #accessing }
GeoFrame >> cEulerAngle [
	^self triggerEvent: #cEulerAngle
]

{ #category : #accessing }
GeoFrame >> cEulerAngle: acEulerAngle [ 
	self removeActionsForEvent: #cEulerAngle.
	acEulerAngle notNil 
		ifTrue: 
			[self 
				when: #cEulerAngle
				ask: acEulerAngle
				perform: #yourself]
]
