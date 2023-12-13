Class {
	#name : #OpenGLHiddenLineRenderingContext,
	#superclass : #OpenGLRenderingContext,
	#category : #'StCAD-UI-StCAD-UI-App'
}

{ #category : #'VisualWorks metadata' }
OpenGLHiddenLineRenderingContext class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #displaying }
OpenGLHiddenLineRenderingContext >> displayPolygon: aCollectionOfPoints [ 
	self displayHiddenLineRendering: aCollectionOfPoints
]
