Class {
	#name : #ToolTracker,
	#superclass : #ScrollingTracker,
	#instVars : [
		'aTool',
		'rvFirstv'
	],
	#category : #'StCAD-UI-StCAD-UI-Basic'
}

{ #category : #'VisualWorks metadata' }
ToolTracker class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'UI'
	)

]

{ #category : #private }
ToolTracker >> setUpFor: aMouseButtonEvent [ 
	rvFirstv := controller aOpenGLPointFor: aMouseButtonEvent
]
