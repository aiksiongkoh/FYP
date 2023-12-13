Class {
	#name : #GEOItem,
	#superclass : #Object,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'instance creation' }
GEOItem class >> new [
	^super new initialize
]

{ #category : #'VisualWorks metadata' }
GEOItem class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
	)

]

{ #category : #'initialize-release' }
GEOItem >> initialize [
	self subclassResponsibility
]

{ #category : #'initialize-release' }
GEOItem >> initializeGlobally [
	self subclassResponsibility
]

{ #category : #'initialize-release' }
GEOItem >> initializeLocally [
	self subclassResponsibility
]
