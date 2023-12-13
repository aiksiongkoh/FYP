Class {
	#name : #GFCompositeGO,
	#superclass : #GFGraphicObject,
	#instVars : [
		'displayBox',
		'graphicObjects',
		'visibleArea',
		'showVisibleArea',
		'visibleAreaLineColor'
	],
	#category : #'GF/ST Base-GFST'
}

{ #category : #'VisualWorks metadata' }
GFCompositeGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'Polymorphic'
		'superclassNamespace' 'Polymorphic'
	)

]
