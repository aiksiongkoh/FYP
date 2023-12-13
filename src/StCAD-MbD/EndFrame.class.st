"
Missing comment
"
Class {
	#name : #EndFrame,
	#superclass : #CartesianFrame,
	#category : #'StCAD-MbD-StCAD-MbD-Basic'
}

{ #category : #'VisualWorks metadata' }
EndFrame class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'ops on self' }
EndFrame >> beSymbolic [
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
	rOfO := aSup rOfO copy.
	aAOf := aSup aAOf copy.
	vFfF := zero copy.
	omeFfF := zero copy.
	vOfO := aSup vOfO copy.
	omeOfO := aSup omeOfO copy.
	aFfF := zero copy.
	alpFfF := zero copy.
	aOfO := aSup aOfO copy.
	alpOfO := aSup alpOfO copy
]
