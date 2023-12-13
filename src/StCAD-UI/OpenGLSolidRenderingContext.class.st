Class {
	#name : #OpenGLSolidRenderingContext,
	#superclass : #OpenGLRenderingContext,
	#category : #'StCAD-UI-StCAD-UI-App'
}

{ #category : #'VisualWorks metadata' }
OpenGLSolidRenderingContext class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #displaying }
OpenGLSolidRenderingContext >> displayFaceUse: aFaceUse [ 
	^self displayFaceUse: aFaceUse displayMode: OpenGLInterface GLU_FILL

	"	^self displayFaceUse: aFaceUse
		displayMode: OpenGLInterface GLU_OUTLINE_POLYGON"

	"	^self displayFaceUse: aFaceUse
		displayMode: OpenGLInterface GLU_OUTLINE_PATCH"
]

{ #category : #displaying }
OpenGLSolidRenderingContext >> displayPolyface: crfpf [ 
	"JunOpenGL3dNonConvexPolygon does not have the last vertex repeated."

	| cVertex nonConvexPolygon normalVector |
	cVertex := Array new: crfpf size - 1.
	1 to: crfpf size - 1
		do: [:i | cVertex at: i put: (crfpf at: i) asJun3dPoint].
	nonConvexPolygon := JunOpenGL3dNonConvexPolygon vertexes: cVertex.
	normalVector := nonConvexPolygon normalVector.
	self activate: 
			[OpenGLInterface glBegin: OpenGLInterface GL_TRIANGLES.
			OpenGLInterface 
				glNormal3d: normalVector x asDouble
				with: normalVector y asDouble
				with: normalVector z asDouble.
			nonConvexPolygon triangles do: 
					[:triangle | 
					triangle do: 
							[:a3dPoint | 
							| a2dPoint |
							(textureCoordinateBlock notNil 
								and: [(a2dPoint := textureCoordinateBlock value: a3dPoint) notNil]) 
									ifTrue: 
										[OpenGLInterface glTexCoord2d: a2dPoint x asDouble with: a2dPoint y asDouble].
							OpenGLInterface 
								glVertex3d: a3dPoint x asDouble
								with: a3dPoint y asDouble
								with: a3dPoint z asDouble]].
			OpenGLInterface glEnd]
]

{ #category : #displaying }
OpenGLSolidRenderingContext >> displayPolygon: aCollectionOfPoints [ 
	| normalVector |
"	self debugShow: (OpenGLInterface glEnable: OpenGLInterface GL_DEPTH_TEST).
	OpenGLInterface glDepthFunc: OpenGLInterface GL_ALWAYS."
	normalVector := self normalVectorOfPoints: aCollectionOfPoints.
	normalVector isNil ifTrue: [^nil].
	self displayPolygon: aCollectionOfPoints normalVector: normalVector.
"	self debugShow: OpenGLInterface glGetError"
]
