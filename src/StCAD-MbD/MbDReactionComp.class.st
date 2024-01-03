Class {
	#name : #MbDReactionComp,
	#superclass : #MbDReaction,
	#instVars : [
		'axis',
		'efrmK'
	],
	#category : #'StCAD-MbD-MbDReaction'
}

{ #category : #accessing }
MbDReactionComp >> partFrameK [
	^efrmK partFrame
]

{ #category : #'initialize-release' }
MbDReactionComp >> withJoint: aJoint efrmK: aefrmK axis: aaxis [ 
	joint := aJoint.
	efrmK := aefrmK.
	axis := aaxis
]
