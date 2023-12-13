Class {
	#name : #TiltTracker,
	#superclass : #RefFrameTracker,
	#category : #'StCAD-UI-StCAD-UI-Basic'
}

{ #category : #'VisualWorks metadata' }
TiltTracker class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #private }
TiltTracker >> doSelectionTrackingOperationAt: rvNewv [ 
	| radialVector |
	radialVector := (controller aOpenGLPointFor: rvNewv) - rvFirstv.
	radialVector isZero 
		ifFalse: 
			[| pixelPerDegree aView rvtiltv rCtiltC aCameraFrame aAOC aAFC rFtiltF thetaF newFrame |
			pixelPerDegree := 1.
			aView := aHandle aView.
			rvtiltv := radialVector y negated @ radialVector x.
			rCtiltC := aView rCpCfromrvpv: rvtiltv.
			aCameraFrame := aView aCamera aRefFrame.
			aAOC := aFrame == aCameraFrame 
						ifTrue: [frozenFrame aAOf]
						ifFalse: [aCameraFrame aAOf].
			aAFC := frozenFrame aAOF transpose timesFullMatrix: aAOC.
			rFtiltF := aAFC timesFullColumn: rCtiltC.
			thetaF := (radialVector r / pixelPerDegree) degreesToRadians.
			newFrame := frozenFrame copy.
			newFrame 
				rotateAt_rFpvF: rFcenterF
				axisF: rFtiltF
				theta: thetaF * direction.
			aFrame copyrFfFandAFfFrom: newFrame.
			aView calcBoundsAndRedisplay: aHandle aSpatialItem]
]
