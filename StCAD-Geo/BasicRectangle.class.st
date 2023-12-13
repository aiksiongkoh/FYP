Class {
	#name : #BasicRectangle,
	#superclass : #BasicCurve2D,
	#instVars : [
		'xLength',
		'yLength'
	],
	#category : #'StCAD-Geo'
}

{ #category : #'VisualWorks metadata' }
BasicRectangle class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
