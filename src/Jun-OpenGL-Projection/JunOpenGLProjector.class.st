Class {
	#name : #JunOpenGLProjector,
	#superclass : #Object,
	#instVars : [
		'projection',
		'shading',
		'presentation',
		'lights',
		'lineSmoothBoolean',
		'polygonSmoothBoolean'
	],
	#category : #'Jun-OpenGL-Projection'
}

{ #category : #'VisualWorks metadata' }
JunOpenGLProjector class >> visualWorksMetadata [

	^ #(
		'namespace' 'Jun'
	)

]
