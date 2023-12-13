Class {
	#name : #JunOpenGL3dNurbsSurface,
	#superclass : #JunOpenGL3dPrimitiveObject,
	#instVars : [
		'stipple',
		'texture',
		'controlPoints',
		'uKnotVector',
		'vKnotVector',
		'weights',
		'trimCurves'
	],
	#category : #'Jun-OpenGL-Objects'
}

{ #category : #'VisualWorks metadata' }
JunOpenGL3dNurbsSurface class >> visualWorksMetadata [

	^ #(
		'namespace' 'Jun'
		'superclassNamespace' 'Jun'
	)

]
