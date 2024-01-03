Class {
	#name : #MbDEulerAngles,
	#superclass : #EulerAngles,
	#type : #variable,
	#category : #'StCAD-MbD-MbDBasic'
}

{ #category : #calc }
MbDEulerAngles >> differentiateWRT: var [ 
	| answer |
	answer := MbDEulerAnglesDot with: self.
	1 to: 3
		do: 
			[:i | 
			| angle angleVel |
			angle := self at: i.
			angleVel := (angle differentiateWRT: var) simplified.
			answer at: i put: angleVel].
	^answer
]
