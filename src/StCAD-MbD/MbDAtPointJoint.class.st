Class {
	#name : #MbDAtPointJoint,
	#superclass : #MbDSphericalJoint,
	#category : #'StCAD-MbD-MbDJoint'
}

{ #category : #accessing }
MbDAtPointJoint >> classString [
	"Used to access the descriptive name of the joint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: AtPoint Joint '
]
