Class {
	#name : #OpenGLWireframeRenderingContext,
	#superclass : #OpenGLRenderingContext,
	#category : #'StCAD-UI-StCAD-UI-App'
}

{ #category : #'VisualWorks metadata' }
OpenGLWireframeRenderingContext class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #displaying }
OpenGLWireframeRenderingContext >> displayFaceUse: aFaceUse [ 
	^self displayFaceUse: aFaceUse
		displayMode: OpenGLInterface GLU_OUTLINE_POLYGON
]

{ #category : #displaying }
OpenGLWireframeRenderingContext >> displayPolygon: aCollectionOfPoints [ 
	self displaySeeThroughWireframe: aCollectionOfPoints
]
