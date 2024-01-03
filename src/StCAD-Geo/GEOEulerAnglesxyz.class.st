Class {
	#name : #GEOEulerAnglesxyz,
	#superclass : #GEOEulerAngles,
	#type : #variable,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #calc }
GEOEulerAnglesxyz >> calc [
	| aA1 aA2 aA3 |
	aA1 := self rotatex: (self at: 1).
	aA2 := self rotatey: (self at: 2).
	aA3 := self rotatez: (self at: 3).
	aA := aA1 timesFullMatrix: (aA2 timesFullMatrix: aA3)
]
