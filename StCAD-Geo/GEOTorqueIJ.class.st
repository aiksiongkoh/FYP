Class {
	#name : #GEOTorqueIJ,
	#superclass : #GEOFunctionIJ,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'VisualWorks metadata' }
GEOTorqueIJ class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
GEOTorqueIJ >> dimension [
	^'torque'
]

{ #category : #DYN }
GEOTorqueIJ >> mbdUnit [
	^self mbdUnits torque
]
