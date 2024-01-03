Class {
	#name : #GEOTorqueIJ,
	#superclass : #GEOFunctionIJ,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOTorqueIJ >> dimension [
	^'torque'
]

{ #category : #DYN }
GEOTorqueIJ >> mbdUnit [
	^self mbdUnits torque
]
