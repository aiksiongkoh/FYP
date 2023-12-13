Class {
	#name : #ExtrudedFeature,
	#superclass : #SketchedFeature,
	#instVars : [
		'zStart',
		'zEnd'
	],
	#category : #'StCAD-NMT-StCAD-NMT-Basic'
}

{ #category : #'VisualWorks metadata' }
ExtrudedFeature class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
ExtrudedFeature >> asTreeNode [
	| stream |
	stream := String new writeStream.
	stream nextPutAll: 'Extrusion'.
	stream space.
	stream print: zStart.
	stream space.
	stream print: zEnd.
	^(super asTreeNode)
		displayString: stream contents;
		addChild: aSketch;
		yourself
]

{ #category : #ops }
ExtrudedFeature >> buildIn: aPartModel [ 
	aPartModel buildExtrudedFeature: self
]

{ #category : #accessing }
ExtrudedFeature >> createModel [
	| aSketchFaceUse aMakePrism |
	aSketchFaceUse := aSketch aSketchFaceUse.
	aMakePrism := (MakePrism new)
				aSketchFaceUse: aSketchFaceUse;
				zStart: zStart;
				zEnd: zEnd;
				do.
	self aModel: aMakePrism newModel
]

{ #category : #accessing }
ExtrudedFeature >> model1 [
	| crGpolylineG aMakePrism aSketchRefFrame crSpointS crPTopPointP crPBottomPointP |
	crGpolylineG := aSketch asPolylines.
	aSketchRefFrame := aSketch aRefFrame.
	crGpolylineG do: 
			[:polyline | 
			crSpointS := polyline crFpointF.
			crPTopPointP := crSpointS collect: 
							[:point | 
							| newPoint |
							newPoint := point copy.
							newPoint at: 3 put: zEnd.
							aSketchRefFrame rFpFfromrfpf: newPoint].
			crPBottomPointP := crSpointS collect: 
							[:point | 
							| newPoint |
							newPoint := point copy.
							newPoint at: 3 put: zStart.
							aSketchRefFrame rFpFfromrfpf: newPoint].
			aMakePrism := MakePrism cTopPoint: crPTopPointP
						cBottomPoint: crPBottomPointP.
			aMakePrism do].
	^aMakePrism newModel
]

{ #category : #accessing }
ExtrudedFeature >> zEnd [
	^zEnd
]

{ #category : #accessing }
ExtrudedFeature >> zEnd: anObject [
	zEnd := anObject
]

{ #category : #accessing }
ExtrudedFeature >> zStart [
	^zStart
]

{ #category : #accessing }
ExtrudedFeature >> zStart: anObject [
	zStart := anObject
]
