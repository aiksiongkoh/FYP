"
Missing comment
"
Class {
	#name : #AssemblyFrame,
	#superclass : #CartesianFrame,
	#instVars : [
		'cEulerAngle',
		'cEulerAngleVel',
		'cEulerAngleAcc'
	],
	#category : #'StCAD-MbD-StCAD-MbD-Basic'
}

{ #category : #'VisualWorks metadata' }
AssemblyFrame class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'ops on self' }
AssemblyFrame >> beSymbolic [
	| block |
	block := 
			[:name | 
			(DependentVariable name: name)
				x: self aTime;
				yourself].
	rFfF := FullColumn 
				with: (block value: #rOaO1)
				with: (block value: #rOaO2)
				with: (block value: #rOaO3).
	cEulerAngle := EulerAngles 
				symbolic: (block value: #bryant1)
				with: (block value: #bryant2)
				with: (block value: #bryant3).
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
