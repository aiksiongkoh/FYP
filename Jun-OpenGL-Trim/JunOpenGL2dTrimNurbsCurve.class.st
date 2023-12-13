Class {
	#name : #JunOpenGL2dTrimNurbsCurve,
	#superclass : #JunOpenGL2dTrimCurve,
	#instVars : [
		'knotVector',
		'controlPoints',
		'weights'
	],
	#category : #'Jun-OpenGL-Trim'
}

{ #category : #'VisualWorks metadata' }
JunOpenGL2dTrimNurbsCurve class >> visualWorksMetadata [

	^ #(
		'namespace' 'Jun'
		'superclassNamespace' 'Jun'
	)

]
