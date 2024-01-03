Class {
	#name : #MbDPointInPlaneJoint,
	#superclass : #MbDInPlaneJoint,
	#category : #'StCAD-MbD-MbDJoint'
}

{ #category : #accessing }
MbDPointInPlaneJoint >> classString [
	"Used to access the descriptive name of the joint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: InPlane Joint '
]

{ #category : #'initialize-release' }
MbDPointInPlaneJoint >> initializeGlobally [
	constraints isEmpty 
		ifTrue: 
			[self createTranslationConstraint.
			TheMbDSystem hasChanged: true]
		ifFalse: [super initializeGlobally]
]
