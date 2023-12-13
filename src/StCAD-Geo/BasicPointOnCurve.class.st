Class {
	#name : #BasicPointOnCurve,
	#superclass : #BasicPoint,
	#instVars : [
		'aCurve',
		'u'
	],
	#category : #'StCAD-Geo'
}

{ #category : #'VisualWorks metadata' }
BasicPointOnCurve class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
