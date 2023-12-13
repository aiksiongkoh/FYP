Class {
	#name : #RefSurface,
	#superclass : #RefCurve,
	#category : #'StCAD-MbD-StCAD-MbD-Basic'
}

{ #category : #accessing }
RefSurface class >> aRefFrameClass [
	^SurfaceFrame
]

{ #category : #'VisualWorks metadata' }
RefSurface class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]
