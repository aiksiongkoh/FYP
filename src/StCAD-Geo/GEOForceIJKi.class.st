Class {
	#name : #GEOForceIJKi,
	#superclass : #GEOFunctionIJKi,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #accessing }
GEOForceIJKi >> dimension [
	^'force'
]

{ #category : #DYN }
GEOForceIJKi >> mbdUnit [
	^self mbdUnits force
]
