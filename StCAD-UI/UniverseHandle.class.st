Class {
	#name : #UniverseHandle,
	#superclass : #Handle,
	#category : #'StCAD-UI-StCAD-UI-Basic'
}

{ #category : #'VisualWorks metadata' }
UniverseHandle class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
UniverseHandle >> aSpatialItem [
	^aSpatialItem
]

{ #category : #accessing }
UniverseHandle >> aSpatialItem: anObject [
	aSpatialItem := anObject
]
