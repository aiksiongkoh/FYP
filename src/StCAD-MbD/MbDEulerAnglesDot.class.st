Class {
	#name : #MbDEulerAnglesDot,
	#superclass : #EulerAnglesDot,
	#type : #variable,
	#category : #'StCAD-MbD-MbDBasic'
}

{ #category : #'VisualWorks metadata' }
MbDEulerAnglesDot class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #calc }
MbDEulerAnglesDot >> differentiateWRT: var [ 
	| answer |
	answer := MbDEulerAnglesDDot with: self.
	1 to: 3
		do: 
			[:i | 
			| angleVel angleAcc |
			angleVel := self at: i.
			angleAcc := (angleVel differentiateWRT: var) simplified.
			answer at: i put: angleAcc].
	^answer
]

{ #category : #'basic ops' }
MbDEulerAnglesDot >> simplified [
	| answer |
	answer := super simplified.
	answer initialize: aEulerAngles.
	^answer
]
