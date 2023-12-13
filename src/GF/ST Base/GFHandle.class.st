Class {
	#name : #GFHandle,
	#superclass : #Object,
	#instVars : [
		'description',
		'releaseAction',
		'locator',
		'mementoType',
		'displayGO',
		'snapToGrid',
		'limit'
	],
	#category : #'GF/ST Base-GFST-GFHandles'
}

{ #category : #'VisualWorks metadata' }
GFHandle class >> visualWorksMetadata [

	^ #(
		'namespace' 'Polymorphic'
	)

]
