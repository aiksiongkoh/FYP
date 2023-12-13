Class {
	#name : #RefGeo,
	#superclass : #SpatialItem,
	#category : #'StCAD-MbD-StCAD-MbD-Basic'
}

{ #category : #'VisualWorks metadata' }
RefGeo class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #accessing }
RefGeo >> addEndFrame: aEndFrame [ 
	self addRefFrame: aEndFrame
]
