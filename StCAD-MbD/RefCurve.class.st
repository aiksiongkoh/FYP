Class {
	#name : #RefCurve,
	#superclass : #RefGeo,
	#instVars : [
		'rfEqnf'
	],
	#category : #'StCAD-MbD-StCAD-MbD-Basic'
}

{ #category : #accessing }
RefCurve class >> aRefFrameClass [
	^CurveFrame
]

{ #category : #'VisualWorks metadata' }
RefCurve class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]
