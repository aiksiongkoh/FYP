Class {
	#name : #GEOEulerAngleszyx,
	#superclass : #GEOEulerAngles,
	#type : #variable,
	#category : #'StCAD-Geo-GEO'
}

{ #category : #calc }
GEOEulerAngleszyx >> calc [
	| aA1 aA2 aA3 |
	aA1 := self rotatez: (self at: 1).
	aA2 := self rotatey: (self at: 2).
	aA3 := self rotatex: (self at: 3).
	aA := aA1 timesFullMatrix: (aA2 timesFullMatrix: aA3)
]
