Class {
	#name : #BasicNURBSComplexSurface,
	#superclass : #BasicNURBSSurface,
	#instVars : [
		'uIsCyclic',
		'vIsCyclic',
		'tolSingularity',
		'u0isSingular',
		'u1isSingular',
		'v0isSingular',
		'v1isSingular'
	],
	#category : #'StCAD-Geo'
}

{ #category : #'VisualWorks metadata' }
BasicNURBSComplexSurface class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
