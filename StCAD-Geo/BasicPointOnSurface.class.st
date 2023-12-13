Class {
	#name : #BasicPointOnSurface,
	#superclass : #BasicPoint,
	#instVars : [
		'aSurface',
		'uv'
	],
	#category : #'StCAD-Geo'
}

{ #category : #'VisualWorks metadata' }
BasicPointOnSurface class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
