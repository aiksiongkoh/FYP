Class {
	#name : #GFDrawing,
	#superclass : #GFCompositeGO,
	#instVars : [
		'firstGO',
		'lastGO',
		'coordSystem',
		'displayGrid',
		'gridColor'
	],
	#category : #'GF/ST Base-GFST'
}

{ #category : #'VisualWorks metadata' }
GFDrawing class >> visualWorksMetadata [

	^ #(
		'namespace' 'Polymorphic'
		'superclassNamespace' 'Polymorphic'
	)

]
