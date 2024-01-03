Class {
	#name : #GEOForceIJ,
	#superclass : #GEOFunctionIJ,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOForceIJ >> dimension [
	^'force'
]

{ #category : #DYN }
GEOForceIJ >> mbdUnit [
	^self mbdUnits force
]
