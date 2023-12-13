Class {
	#name : #RefSurface,
	#superclass : #RefCurve,
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
RefSurface class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
RefSurface >> rfSurfacef [
	^rfEqnf
]

{ #category : #accessing }
RefSurface >> rfSurfacef: anObject [ 
	rfEqnf := anObject
]
