Class {
	#name : #MbDPTCVJoint,
	#superclass : #MbDSphericalJoint,
	#category : #'StCAD-MbD-MbDJoint'
}

{ #category : #accessing }
MbDPTCVJoint >> classString [
	"Used to access the descriptive name of the constraint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: Point-Curve contact '
]
