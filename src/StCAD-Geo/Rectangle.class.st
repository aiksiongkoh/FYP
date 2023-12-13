Class {
	#name : #Rectangle,
	#superclass : #Curve2D,
	#instVars : [
		'xLength',
		'yLength'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
Rectangle class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #'instancee creation' }
Rectangle class >> xLength: xLength yLength: yLength [ 
	^self new xLength: xLength yLength: yLength
]

{ #category : #accessing }
Rectangle >> crfpointf [
	| crfpointf |
	crfpointf := MathArray new: 5.
	crfpointf at: 1 put: (FullColumn zero: 3).
	crfpointf at: 2
		put: (FullColumn 
				with: xLength
				with: 0.0d
				with: 0.0d).
	crfpointf at: 3
		put: (FullColumn 
				with: xLength
				with: yLength
				with: 0.0d).
	crfpointf at: 4
		put: (FullColumn 
				with: 0.0d
				with: yLength
				with: 0.0d).
	crfpointf at: 5 put: (crfpointf at: 1).
	^crfpointf
]

{ #category : #ops }
Rectangle >> magnifySelf: aDouble [

	super magnifySelf: aDouble.
	xLength := xLength * aDouble.
	yLength := yLength * aDouble
]

{ #category : #calc }
Rectangle >> privateCalcBoundingBox [

	aBoundingBox := StCAD_Misc_BoundingBox
		                origin: (FullColumn zero: 3)
		                corner:
		                (FullColumn with: xLength with: yLength with: 0.0 d) "VW_TRANSLATION:StCAD.Misc.BoundingBox:StCAD_Misc_BoundingBox"
]

{ #category : #accessing }
Rectangle >> rfpointsf [
	| rfpointsf |
	rfpointsf := MathArray new: 5.
	rfpointsf at: 1 put: (FullColumn zero: 3).
	rfpointsf at: 2
		put: (FullColumn 
				with: xLength
				with: 0.0d
				with: 0.0d).
	rfpointsf at: 3
		put: (FullColumn 
				with: xLength
				with: yLength
				with: 0.0d).
	rfpointsf at: 4
		put: (FullColumn 
				with: 0.0d
				with: yLength
				with: 0.0d).
	rfpointsf at: 5 put: (rfpointsf at: 1).
	^rfpointsf
]

{ #category : #accessing }
Rectangle >> xLength [
	^xLength
]

{ #category : #accessing }
Rectangle >> xLength: anObject [
	xLength := anObject
]

{ #category : #accessing }
Rectangle >> xLength: argxLength yLength: argyLength [ 
	xLength := argxLength.
	yLength := argyLength
]

{ #category : #accessing }
Rectangle >> yLength [
	^yLength
]

{ #category : #accessing }
Rectangle >> yLength: anObject [
	yLength := anObject
]
