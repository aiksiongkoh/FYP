Class {
	#name : #RefPoint,
	#superclass : #RefGeo,
	#category : #'StCAD-MbD-StCAD-MbD-Basic'
}

{ #category : #accessing }
RefPoint class >> aRefFrameClass [
	^GeoFrame
]

{ #category : #'VisualWorks metadata' }
RefPoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]
