Class {
	#name : #RotateUniverseHandle,
	#superclass : #UniverseHandle,
	#category : #'StCAD-UI-StCAD-UI-Basic'
}

{ #category : #'VisualWorks metadata' }
RotateUniverseHandle class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #displaying }
RotateUniverseHandle >> renderOn: aRenderingContext [ 
	aRenderingContext displayRotateHandle: self
]

{ #category : #accessing }
RotateUniverseHandle >> selectionTracker [
	| rOcenterO aCameraFrame rFcenterF |
	rOcenterO := aSpatialItem aRefFrame 
				rOpOfromrfpf: aSpatialItem aBoundingBox center.
	aCameraFrame := aView aCamera aRefFrame.
	rFcenterF := aCameraFrame rFpFfromrOpO: rOcenterO.
	^(RotateTracker new)
		setController: aView controller;
		aHandle: self;
		aFrame: aCameraFrame;
		rFcenterF: rFcenterF;
		direction: -1;
		yourself
]
