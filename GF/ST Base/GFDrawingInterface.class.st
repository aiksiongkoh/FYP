Class {
	#name : #GFDrawingInterface,
	#superclass : #PsiEventModel,
	#instVars : [
		'palette',
		'selections',
		'handles',
		'drawing',
		'display',
		'hideHandles',
		'memento'
	],
	#category : #'GF/ST Base-GFST-GFInterface'
}

{ #category : #'VisualWorks metadata' }
GFDrawingInterface class >> visualWorksMetadata [

	^ #(
		'namespace' 'Polymorphic'
		'superclassNamespace' 'Polymorphic'
	)

]
