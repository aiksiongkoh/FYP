"
Missing comment
"
Class {
	#name : #PartFrame,
	#superclass : #CartesianFrame,
	#instVars : [
		'qE',
		'qEvel',
		'qEacc'
	],
	#category : #'StCAD-MbD-StCAD-MbD-Basic'
}

{ #category : #'VisualWorks metadata' }
PartFrame class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'ops on self' }
PartFrame >> beSymbolic [
	| block qEVel qEAcc |
	block := 
			[:name | 
			(DependentVariable name: name)
				x: self aTime;
				yourself].
	rFfF := FullColumn 
				with: (block value: #rapa1)
				with: (block value: #rapa2)
				with: (block value: #rapa3).
	qE := EulerParameters 
				symbolic: (block value: #E1)
				with: (block value: #E2)
				with: (block value: #E3)
				with: (block value: #E4).
	qE calcSymbolic.
	aAFf := qE aA.
	rOfO := (self rOFO + (self aAOF timesFullColumn: rFfF)) simplified.
	aAOf := (self aAOF timesFullMatrix: aAFf) simplified.
	vFfF := (rFfF differentiateWRT: self aTime) simplified.
	qEVel := (qE differentiateWRT: self aTime) simplified.
	qEVel calcSymbolic.
	omeFfF := qEVel omeF.
	vOfO := (rOfO differentiateWRT: self aTime) simplified.
	omeOfO := (self omeOFO + (self aAOF timesFullColumn: omeFfF)) simplified.
	aFfF := (vFfF differentiateWRT: self aTime) simplified.
	qEAcc := (qEVel differentiateWRT: self aTime) simplified.
	qEAcc calcSymbolic.
	alpFfF := qEAcc alpF.
	aOfO := (vOfO differentiateWRT: self aTime) simplified.
	alpOfO := (omeOfO differentiateWRT: self aTime) simplified.
	body beSymbolic.
	cSub do: [:aFrame | aFrame beSymbolic]
]

{ #category : #accessing }
PartFrame >> pAFfpE [
	^aAFf pvaluepE
]

{ #category : #accessing }
PartFrame >> pAOfpE [
	^aAOf pvaluepE
]

{ #category : #accessing }
PartFrame >> ppAFfpEpE [
	^aAFf ppvaluepEpE
]

{ #category : #accessing }
PartFrame >> ppAOfpEpE [
	^aAOf ppvaluepEpE
]

{ #category : #accessing }
PartFrame >> ppAOfptpE [
	^aAOf ppvalueptpE
]

{ #category : #accessing }
PartFrame >> pprFfFpXpX [
	^rFfF ppvaluepXpX
]

{ #category : #accessing }
PartFrame >> pprOfOpXpX [
	^rOfO ppvaluepXpX
]

{ #category : #accessing }
PartFrame >> pprOfOptpX [
	^rOfO ppvalueptpX
]

{ #category : #accessing }
PartFrame >> prFfFpX [
	^rFfF pvaluepX
]

{ #category : #accessing }
PartFrame >> prOfOpX [
	^rOfO pvaluepX
]
