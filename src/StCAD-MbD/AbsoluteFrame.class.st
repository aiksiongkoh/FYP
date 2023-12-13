Class {
	#name : #AbsoluteFrame,
	#superclass : #CartesianFrame,
	#instVars : [
		'aTime'
	],
	#category : #'StCAD-MbD-StCAD-MbD-Basic'
}

{ #category : #'VisualWorks metadata' }
AbsoluteFrame class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
AbsoluteFrame >> aAddotOf [
	^self aAzero
]

{ #category : #accessing }
AbsoluteFrame >> aAdotOf [
	^self aAzero
]

{ #category : #accessing }
AbsoluteFrame >> aAzero [
	| zero answer |
	zero := Constant with: 0.0d.
	answer := FullMatrix new: 3 by: 3.
	answer do: [:aRow | aRow atAllPut: zero].
	^answer
]

{ #category : #accessing }
AbsoluteFrame >> aTime [
	^aTime
]

{ #category : #'ops on self' }
AbsoluteFrame >> beSymbolic [
	"beSymbolic must start here."

	| zero cEulerAngle |
	zero := FullColumn 
				with: (Constant with: 0)
				with: (Constant with: 0)
				with: (Constant with: 0).
	cEulerAngle := EulerAngles 
				symbolic: (Constant with: 0)
				with: (Constant with: 0)
				with: (Constant with: 0).
	cEulerAngle calcSymbolic.
	rFfF := zero copy.
	aAFf := cEulerAngle aA.
	rOfO := zero copy.
	aAOf := cEulerAngle aA.
	vFfF := zero copy.
	omeFfF := zero copy.
	vOfO := zero copy.
	omeOfO := zero copy.
	aFfF := zero copy.
	alpFfF := zero copy.
	aOfO := zero copy.
	alpOfO := zero copy.
	cSub do: [:aFrame | aFrame beSymbolic]
]

{ #category : #'initialize-release' }
AbsoluteFrame >> initialize [
	super initialize.
	aTime := MathTime new
]
