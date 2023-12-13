Class {
	#name : #GFCoordinateControl,
	#superclass : #Object,
	#instVars : [
		'logicalUnit',
		'origin',
		'axisDirection',
		'scale',
		'extent',
		'grid',
		'useGrid'
	],
	#category : #'GF/ST Base-GFST-GFCoordinateSystem'
}

{ #category : #'VisualWorks metadata' }
GFCoordinateControl class >> visualWorksMetadata [

	^ #(
		'namespace' 'Polymorphic'
	)

]
