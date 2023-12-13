Class {
	#name : #BasicNURBSSurface,
	#superclass : #BasicSurface,
	#instVars : [
		'ccControlPoint',
		'ccWeight',
		'cuKnot',
		'cvKnot',
		'uDegree',
		'vDegree'
	],
	#category : #'StCAD-Geo'
}

{ #category : #'VisualWorks metadata' }
BasicNURBSSurface class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
