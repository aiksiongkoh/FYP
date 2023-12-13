Class {
	#name : #GFGraphicObject,
	#superclass : #PsiEventModel,
	#instVars : [
		'container',
		'prev',
		'next'
	],
	#category : #'GF/ST Base-GFST'
}

{ #category : #'VisualWorks metadata' }
GFGraphicObject class >> visualWorksMetadata [

	^ #(
		'namespace' 'Polymorphic'
		'superclassNamespace' 'Polymorphic'
	)

]
