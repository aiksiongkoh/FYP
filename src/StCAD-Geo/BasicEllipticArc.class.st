Class {
	#name : #BasicEllipticArc,
	#superclass : #BasicEllipse,
	#instVars : [
		'theStart',
		'theEnd'
	],
	#category : #'StCAD-Geo'
}

{ #category : #'VisualWorks metadata' }
BasicEllipticArc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
