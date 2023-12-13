Class {
	#name : #GFDoubleBufferingGraphicsDisplaySystem,
	#superclass : #GFGraphicsDisplaySystem,
	#instVars : [
		'scratch',
		'pen'
	],
	#category : #'GF/ST Base-GFST-GFInterface-GFDisplay'
}

{ #category : #'VisualWorks metadata' }
GFDoubleBufferingGraphicsDisplaySystem class >> visualWorksMetadata [

	^ #(
		'namespace' 'Polymorphic'
		'superclassNamespace' 'Polymorphic'
	)

]
