Class {
	#name : #MbDReactionComp,
	#superclass : #MbDReaction,
	#instVars : [
		'axis',
		'efrmK'
	],
	#category : #'StCAD-MbD-MbDReaction'
}

{ #category : #'VisualWorks metadata' }
MbDReactionComp class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDReactionComp class >> withJoint: joint efrmK: aefrmK axis: aaxis [ 
	^self new
		withJoint: joint
		efrmK: aefrmK
		axis: aaxis
]

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
