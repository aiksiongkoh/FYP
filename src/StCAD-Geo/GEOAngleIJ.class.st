Class {
	#name : #GEOAngleIJ,
	#superclass : #GEOFunctionIJ,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOAngleIJ >> dimension [
	^'angle'
]

{ #category : #DYN }
GEOAngleIJ >> mbdUnit [
	^self mbdUnits angle
]
