Class {
	#name : #GEORobotAxis,
	#superclass : #GEOKineIJ,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'VisualWorks metadata' }
GEORobotAxis class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #testing }
GEORobotAxis >> isRobotAxis [
	^true
]
