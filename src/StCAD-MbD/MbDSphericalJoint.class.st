Class {
	#name : #MbDSphericalJoint,
	#superclass : #MbDJoint,
	#category : #'StCAD-MbD-MbDJoint'
}

{ #category : #accessing }
MbDSphericalJoint >> classString [
	"Used to access the descriptive name of the joint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: Spherical Joint '
]

{ #category : #'initialize-release' }
MbDSphericalJoint >> initializeGlobally [
	constraints isEmpty
		ifTrue: 
			[self owns: (MbDAtPointConstraintIJ withFrmI: frmI frmJ: frmJ axis: 1).
			self owns: (MbDAtPointConstraintIJ withFrmI: frmI frmJ: frmJ axis: 2).
			self owns: (MbDAtPointConstraintIJ withFrmI: frmI frmJ: frmJ axis: 3).
			TheMbDSystem hasChanged: true]
		ifFalse: [super initializeGlobally]
]
