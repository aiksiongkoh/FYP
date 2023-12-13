Class {
	#name : #JunOpenGLProjection,
	#superclass : #Object,
	#instVars : [
		'eyePoint',
		'sightPoint',
		'upVector',
		'near',
		'far',
		'viewFactor'
	],
	#category : #'Jun-OpenGL-Projection'
}

{ #category : #'VisualWorks metadata' }
JunOpenGLProjection class >> visualWorksMetadata [

	^ #(
		'namespace' 'Jun'
	)

]
