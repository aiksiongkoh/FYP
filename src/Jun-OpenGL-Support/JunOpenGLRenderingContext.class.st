Class {
	#name : #JunOpenGLRenderingContext,
	#superclass : #JunOpenGLResource,
	#instVars : [
		'medium',
		'handle',
		'paint',
		'alpha',
		'lineWidth',
		'pointSize',
		'projection',
		'shading',
		'lightIndex',
		'lightStates',
		'nurbsSamplingTolerance',
		'presentation',
		'transformation',
		'texture',
		'textureCoordinateBlock',
		'textureCoordinateIndex',
		'depthMask',
		'lineStippleFactor',
		'lineStipplePattern',
		'polygonStipple',
		'lineSmooth',
		'polygonSmooth',
		'cullFace',
		'ambientLight',
		'lights',
		'materialAmbient',
		'materialDiffuse',
		'materialEmission',
		'materialShininess',
		'materialSpecular',
		'fogColor',
		'fogExpDensity',
		'fogExp2Density',
		'fogLinearDensity',
		'enableDisables',
		'viewport',
		'backgroundColor'
	],
	#classInstVars : [
		'enhancements'
	],
	#category : #'Jun-OpenGL-Support'
}

{ #category : #'VisualWorks metadata' }
JunOpenGLRenderingContext class >> visualWorksMetadata [

	^ #(
		'namespace' 'Jun'
		'superclassNamespace' 'Jun'
	)

]
