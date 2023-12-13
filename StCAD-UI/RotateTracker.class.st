Class {
	#name : #RotateTracker,
	#superclass : #RefFrameTracker,
	#category : #'StCAD-UI-StCAD-UI-Basic'
}

{ #category : #'VisualWorks metadata' }
RotateTracker class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #private }
RotateTracker >> doSelectionTrackingOperationAt: rvNewv [ 
	| radialVector |
	radialVector := 100 @ 0 + (controller aOpenGLPointFor: rvNewv) - rvFirstv.
	radialVector isZero 
		ifFalse: 
			[| aView rCrotateC aCameraFrame aAOC aAFC rFrotateF thetaF newFrame |
			aView := aHandle aView.
			rCrotateC := frozenFrame unitz.
			aCameraFrame := aView aCamera aRefFrame.
			aAOC := aFrame == aCameraFrame 
						ifTrue: [frozenFrame aAOf]
						ifFalse: [aCameraFrame aAOf].
			aAFC := frozenFrame aAOF transpose timesFullMatrix: aAOC.
			rFrotateF := aAFC timesFullColumn: rCrotateC.
			thetaF := radialVector theta asDouble.
			newFrame := frozenFrame copy.
			newFrame 
				rotateAt_rFpvF: rFcenterF
				axisF: rFrotateF
				theta: thetaF * direction.
			aFrame copyrFfFandAFfFrom: newFrame.
			aView calcBoundsAndRedisplay: aHandle aSpatialItem]
]
