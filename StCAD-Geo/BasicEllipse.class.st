Class {
	#name : #BasicEllipse,
	#superclass : #BasicCurve2D,
	#instVars : [
		'xRadius',
		'yRadius'
	],
	#category : #'StCAD-Geo'
}

{ #category : #'VisualWorks metadata' }
BasicEllipse class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
