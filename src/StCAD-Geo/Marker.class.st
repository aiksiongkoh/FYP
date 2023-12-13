Class {
	#name : #Marker,
	#superclass : #SpatialItem,
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
Marker class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
Marker >> findMarkerNamed: nameComponents [ 
	self name = (nameComponents at: 1) ifFalse: [^nil].
	^self
]

{ #category : #accessing }
Marker >> findMarkerNamedOld: nameComponents [ 
	self name = (nameComponents at: 1) ifFalse: [^nil].
	^self
]

{ #category : #'initialize-release' }
Marker >> initialize [
	super initialize.
	self privateCalcBoundingBox
]

{ #category : #calc }
Marker >> privateCalcBoundingBox [
	aBoundingBox := BoundingBox origin: (FullColumn zero: 3)
				corner: (FullColumn zero: 3)
]
