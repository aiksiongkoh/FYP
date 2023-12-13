Class {
	#name : #CADWorldFrameGO,
	#superclass : #CADFrameGO,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #'VisualWorks metadata' }
CADWorldFrameGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
CADWorldFrameGO >> axisLength: double [ 
	axisLength := 5 * double
]

{ #category : #accessing }
CADWorldFrameGO >> geoObject: geoFrame [ 
	super geoObject: geoFrame.
	self disableInteraction
]

{ #category : #accessing }
CADWorldFrameGO >> geoRefFrame [
	^self metaObject
]

{ #category : #calc }
CADWorldFrameGO >> graphicsIntersecting: rDpD collectIn: set [ 
	"Do nothing."
]

{ #category : #'initialize-release' }
CADWorldFrameGO >> initialize [
	super initialize.
	lineWidth := 1
]
