Class {
	#name : #MbDContactEndFrameqcs,
	#superclass : #MbDEndFrameqcs,
	#instVars : [
		'sPresent',
		'sPast',
		'sInterpolator'
	],
	#category : #'StCAD-MbD-MbDBasic'
}

{ #category : #'initialize-release' }
MbDContactEndFrameqcs >> becomeContactEndFrame [
	"Do nothing."
]

{ #category : #'initialize-release' }
MbDContactEndFrameqcs >> becomeNoContactEndFrame [
	self changeClassToThatOf: MbDNoContactEndFrameqcs basicNew
]

{ #category : #'initialize-release' }
MbDContactEndFrameqcs >> initialize [
	super initialize.
	sPast := OrderedCollection new
]

{ #category : #'initialize-release' }
MbDContactEndFrameqcs >> initializeLocally [
	super initializeLocally.
	sPresent := FullColumn new: sSize
]

{ #category : #dynamic }
MbDContactEndFrameqcs >> postDynStep [
	"sPresent is the true value of s at integrator time t."
	"s will be changed a lot for intermediate results."

	sPresent equalFullColumn: s
]

{ #category : #posIC }
MbDContactEndFrameqcs >> postPosIC [
	"sPresent is the true value of s at integrator time t."
	"s will be changed a lot for intermediate results."

	sPresent equalFullColumn: s
]

{ #category : #dynamic }
MbDContactEndFrameqcs >> preDyn [
	sInterpolator == nil ifTrue: [sInterpolator := TheMbDSystem mbdSystemSolver opBDF]
]

{ #category : #accessing }
MbDContactEndFrameqcs >> sDerivative: n at: tout [ 
	^sInterpolator
		derivative: n
		at: tout
		present: sPresent
		past: sPast
]

{ #category : #dynamic }
MbDContactEndFrameqcs >> storeDynState [
	sPast addFirst: sPresent.
	[sInterpolator timeNodes size < sPast size]
		whileTrue: [sPast removeLast]
]
