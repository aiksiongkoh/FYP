Class {
	#name : #FrameGO,
	#superclass : #CADMarkerGO,
	#category : #'StCAD-UI-UI'
}

{ #category : #'VisualWorks metadata' }
FrameGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.PDMS'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #'VisualWorks metadata' }
FrameGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.MOSES'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #'VisualWorks metadata' }
FrameGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.POVRay'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
FrameGO >> axisLength [
	^2 * AxisLength
]

{ #category : #accessing }
FrameGO >> axisLength: double [ 
	axisLength := 2 * double
]

{ #category : #accessing }
FrameGO >> axisLength: double [ 
	axisLength := 2 * double
]

{ #category : #accessing }
FrameGO >> defaultHandles [
	| handle |
	handle := self defaultPositionHandle.
	handle displayImage: (GFTextGO text: '  R').
	^Array with: handle
]

{ #category : #accessing }
FrameGO >> defaultHandles [
	| handle |
	handle := self defaultPositionHandle.
	handle displayImage: (GFTextGO text: '  M').
	^Array with: handle
]
