Class {
	#name : #OpenGLRetainedMedium,
	#superclass : #JunOpenGLRetainedMedium,
	#category : #'StCAD-UI-StCAD-UI-App'
}

{ #category : #'VisualWorks metadata' }
OpenGLRetainedMedium class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'Jun'
	)

]

{ #category : #accessing }
OpenGLRetainedMedium >> bounds [
	^0 @ 0 extent: extent
]

{ #category : #accessing }
OpenGLRetainedMedium >> calcViewBoxFor: aBoundingBox with: projection [ 
	^self renderingContext calcViewBoxFor: aBoundingBox with: projection
]

{ #category : #displaying }
OpenGLRetainedMedium >> displayViewRectangle: arg1 [
	"Dummy method template.  This was installed by the debugger
	define method command."

	^self halt
]

{ #category : #testing }
OpenGLRetainedMedium >> isOpenGL [
	^true
]

{ #category : #displaying }
OpenGLRetainedMedium >> makeCamera: aCamera fit: aBoundingBox [ 
	| aCameraRefFrame aBoundingBoxC height distance rOfocusO rOeyeO |
	aCameraRefFrame := aCamera aRefFrame.
	aBoundingBoxC := aBoundingBox inRefFrame: aCameraRefFrame.
	height := 1.25d * aBoundingBoxC extent y.
	distance := aCamera ratio * height.
	rOfocusO := aBoundingBox center.
	rOeyeO := rOfocusO 
				plusFullColumn: (aCameraRefFrame aAOf timesFullColumn: (FullColumn 
								with: 0.0d
								with: 0.0d
								with: distance)).
	aCamera eyePoint: rOeyeO.
	aCamera distance: distance.
	aCamera height: height
]

{ #category : #accessing }
OpenGLRetainedMedium >> renderingContext [
	^OpenGLRenderingContext on: self
]

{ #category : #displaying }
OpenGLRetainedMedium >> scrollCamera: aCamera by: aPoint [ 
	self renderingContext scrollCamera: aCamera by: aPoint
]
