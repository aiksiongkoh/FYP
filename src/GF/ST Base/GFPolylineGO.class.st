Class {
	#name : #GFPolylineGO,
	#superclass : #GFDirectedPathGO,
	#instVars : [
		'points',
		'origin',
		'extent',
		'closed',
		'fillColor'
	],
	#category : #'GF/ST Base-GFST'
}

{ #category : #'VisualWorks metadata' }
GFPolylineGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'Polymorphic'
		'superclassNamespace' 'Polymorphic'
	)

]
