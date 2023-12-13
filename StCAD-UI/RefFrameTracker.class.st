Class {
	#name : #RefFrameTracker,
	#superclass : #HandleTracker,
	#instVars : [
		'aFrame',
		'frozenFrame',
		'rFcenterF',
		'direction',
		'rvFirstv',
		'rvOldv'
	],
	#category : #'StCAD-UI-StCAD-UI-Basic'
}

{ #category : #'VisualWorks metadata' }
RefFrameTracker class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
RefFrameTracker >> aFrame [
	^aFrame
]

{ #category : #accessing }
RefFrameTracker >> aFrame: anObject [
	aFrame := anObject
]

{ #category : #accessing }
RefFrameTracker >> direction [
	^direction
]

{ #category : #accessing }
RefFrameTracker >> direction: anObject [
	direction := anObject
]

{ #category : #private }
RefFrameTracker >> finishSelectionFor: aPoint [ 
	super finishSelectionFor: aPoint
]

{ #category : #accessing }
RefFrameTracker >> rFcenterF [
	^rFcenterF
]

{ #category : #accessing }
RefFrameTracker >> rFcenterF: anObject [
	rFcenterF := anObject
]

{ #category : #private }
RefFrameTracker >> setUpFor: aMouseButtonEvent [ 
	frozenFrame := aFrame frozenCopy.
	rvFirstv := controller aOpenGLPointFor: aMouseButtonEvent.
	rvOldv := rvFirstv copy
]
