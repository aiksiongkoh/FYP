Class {
	#name : #GEOTorqueIJKi,
	#superclass : #GEOFunctionIJKi,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOTorqueIJKi >> dimension [
	^'torque'
]

{ #category : #DYN }
GEOTorqueIJKi >> mbdUnit [
	^self mbdUnits torque
]
