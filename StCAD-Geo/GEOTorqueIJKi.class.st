Class {
	#name : #GEOTorqueIJKi,
	#superclass : #GEOFunctionIJKi,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'VisualWorks metadata' }
GEOTorqueIJKi class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
GEOTorqueIJKi >> dimension [
	^'torque'
]

{ #category : #DYN }
GEOTorqueIJKi >> mbdUnit [
	^self mbdUnits torque
]
