Class {
	#name : #MbDReaction,
	#superclass : #MbDItem,
	#instVars : [
		'joint'
	],
	#category : #'StCAD-MbD-MbDReaction'
}

{ #category : #'VisualWorks metadata' }
MbDReaction class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #evaluating }
MbDReaction >> differentiateWRT: variable [ 
	^self == variable
		ifTrue: [Constant with: 1]
		ifFalse: [Constant with: 0]
]

{ #category : #accessing }
MbDReaction >> joint: aJoint [ 
	joint := aJoint
]

{ #category : #accessing }
MbDReaction >> partFrameI [
	^joint partFrameI
]

{ #category : #accessing }
MbDReaction >> partFrameJ [
	^joint partFrameJ
]

{ #category : #accIC }
MbDReaction >> postAccICIteration [
	self calcPostDynCorrectorIteration
]

{ #category : #collision }
MbDReaction >> postCollisionCorrectorIteration [
	self calcPostDynCorrectorIteration
]

{ #category : #collision }
MbDReaction >> postCollisionPredictor [
	self calcPostDynCorrectorIteration
]

{ #category : #'initialize-release' }
MbDReaction >> simplified [
	"Do nothing."
]

{ #category : #'initialize-release' }
MbDReaction >> useEquationNumbers [
	"Do nothing."
]
