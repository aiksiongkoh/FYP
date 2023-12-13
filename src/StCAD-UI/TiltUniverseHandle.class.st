Class {
	#name : #TiltUniverseHandle,
	#superclass : #UniverseHandle,
	#category : #'StCAD-UI-StCAD-UI-Basic'
}

{ #category : #'VisualWorks metadata' }
TiltUniverseHandle class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #displaying }
TiltUniverseHandle >> renderOn: aRenderingContext [ 
	aRenderingContext displayTiltHandle: self
]

{ #category : #accessing }
TiltUniverseHandle >> selectionTracker [
	| rOcenterO aCameraFrame rFcenterF |
	rOcenterO := aSpatialItem aRefFrame 
				rOpOfromrfpf: aSpatialItem aBoundingBox center.
	aCameraFrame := aView aCamera aRefFrame.
	rFcenterF := aCameraFrame rFpFfromrOpO: rOcenterO.
	^(TiltTracker new)
		setController: aView controller;
		aHandle: self;
		aFrame: aCameraFrame;
		rFcenterF: rFcenterF;
		direction: -1;
		yourself
]
