Class {
	#name : #GEOProjectionFrame2,
	#superclass : #GEOCartesianFrame2,
	#instVars : [
		'rOPO',
		'aAOP',
		'aAOPT',
		'pixelPerMetre'
	],
	#category : #'StCAD-Geo-GEO'
}

{ #category : #'VisualWorks metadata' }
GEOProjectionFrame2 class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
GEOProjectionFrame2 >> aAOP [
	aAOP == nil ifTrue: [self calc].
	^aAOP
]

{ #category : #accessing }
GEOProjectionFrame2 >> aAOPT [
	aAOPT == nil ifTrue: [self calc].
	^aAOPT
]

{ #category : #accessing }
GEOProjectionFrame2 >> aParallelCameraWithBounds: aRect [ 
	"
	ProjectionFrame x is to the right. ProjectionFrame y is down.	
	OpenGL x is to the right. OpenGL y is up.
	"

	| aCamera aCameraRefFrame openglAFf rDoriginPx rDcornerPx rPoriginP rPcornerP rCoriginC rCcornerC height aCamerarFfF |
	aCamera := ParallelCamera new.
	aCameraRefFrame := aCamera aRefFrame.
	aCameraRefFrame rFfF: rFfF copy.
	openglAFf := FullMatrix rotationMatrixFromxDir: (aAFf column: 1)
				yDir: (aAFf column: 2) negated.
	aCameraRefFrame aAFf: openglAFf.
	rDoriginPx := FullColumn 
				with: aRect origin x asDouble
				with: aRect origin y asDouble
				with: 0.0d.
	rDcornerPx := FullColumn 
				with: aRect corner x asDouble
				with: aRect corner y asDouble
				with: 0.0d.
	rPoriginP := self rPpPfromrDpPx: rDoriginPx.
	rPcornerP := self rPpPfromrDpPx: rDcornerPx.
	rCoriginC := rPoriginP
				y: rPoriginP y negated;
				yourself.
	rCcornerC := rPcornerP
				y: rPcornerP y negated;
				yourself.
	aCamera left: (rCoriginC x min: rCcornerC x).
	aCamera right: (rCoriginC x max: rCcornerC x).
	aCamera bottom: (rCoriginC y min: rCcornerC y).
	aCamera top: (rCoriginC y max: rCcornerC y).
	height := (rCcornerC y - rCoriginC y) abs.
	aCamera near: 1.0d * height.
	aCamera far: 100.0d * height.
	aCamerarFfF := aCameraRefFrame rFpFfromrfpf: (FullColumn 
						with: 0.0d
						with: 0.0d
						with: 10.0d * height).
	aCameraRefFrame rFfF: aCamerarFfF.
	^aCamera
]

{ #category : #accessing }
GEOProjectionFrame2 >> aParallelCameraWithBounds: aRect inPreferredRect: aDrawingRect [ 
	"
	ProjectionFrame x is to the right. ProjectionFrame y is down.	
	OpenGL x is to the right. OpenGL y is up.
	"

	| aCamera aCameraRefFrame openglAFf rDoriginPx rDcornerPx rPoriginP rPcornerP rCoriginC rCcornerC height aCamerarFfF |
	aCamera := ParallelCamera new.
	aCameraRefFrame := aCamera aRefFrame.
	aCameraRefFrame rFfF: rFfF copy.
	openglAFf := FullMatrix rotationMatrixFromxDir: (aAFf column: 1)
				yDir: (aAFf column: 2) negated.
	aCameraRefFrame aAFf: openglAFf.
	rDoriginPx := FullColumn 
				with: aRect origin x asDouble
				with: aRect origin y asDouble
				with: 0.0d.
	rDcornerPx := FullColumn 
				with: aRect corner x asDouble
				with: aRect corner y asDouble
				with: 0.0d.
	rPoriginP := self rPpPfromrDpPx: rDoriginPx.
	rPcornerP := self rPpPfromrDpPx: rDcornerPx.
	rCoriginC := rPoriginP
				y: rPoriginP y negated;
				yourself.
	rCcornerC := rPcornerP
				y: rPcornerP y negated;
				yourself.
	aCamera left: (rCoriginC x min: rCcornerC x).
	aCamera right: (rCoriginC x max: rCcornerC x).
	aCamera bottom: (rCoriginC y min: rCcornerC y).
	aCamera top: (rCoriginC y max: rCcornerC y).
	height := aDrawingRect extent y / pixelPerMetre.
	aCamera near: 1.0d * height.
	aCamera far: 100.0d * height.
	aCamerarFfF := aCameraRefFrame rFpFfromrfpf: (FullColumn 
						with: 0.0d
						with: 0.0d
						with: 10.0d * height).
	aCameraRefFrame rFfF: aCamerarFfF.
	^aCamera
]

{ #category : #accessing }
GEOProjectionFrame2 >> aPerspectiveCameraWithBounds: aRect [ 
	"
	ProjectionFrame x is to the right. ProjectionFrame y is down.	
	OpenGL x is to the right. OpenGL y is up.
	"

	| aCamera aCameraRefFrame openglAFf rDoriginPx rDcornerPx rPoriginP rPcornerP rCoriginC rCcornerC left right bottom top height ratio distance aCamerarFfF |
	aCamera := PerspectiveCamera new.
	aCameraRefFrame := aCamera aRefFrame.
	aCameraRefFrame rFfF: rFfF copy.
	openglAFf := FullMatrix rotationMatrixFromxDir: (aAFf column: 1)
				yDir: (aAFf column: 2) negated.
	aCameraRefFrame aAFf: openglAFf.
	rDoriginPx := FullColumn 
				with: aRect origin x asDouble
				with: aRect origin y asDouble
				with: 0.0d.
	rDcornerPx := FullColumn 
				with: aRect corner x asDouble
				with: aRect corner y asDouble
				with: 0.0d.
	rPoriginP := self rPpPfromrDpPx: rDoriginPx.
	rPcornerP := self rPpPfromrDpPx: rDcornerPx.
	rCoriginC := rPoriginP
				y: rPoriginP y negated;
				yourself.
	rCcornerC := rPcornerP
				y: rPcornerP y negated;
				yourself.
	left := rCoriginC x min: rCcornerC x.
	right := rCoriginC x max: rCcornerC x.
	bottom := rCoriginC y min: rCcornerC y.
	top := rCoriginC y max: rCcornerC y.
	height := (rCcornerC y - rCoriginC y) abs.
	ratio := 5.0d.
	distance := ratio * height.
	aCamera height: height.
	aCamera distance: distance.
	aCamerarFfF := aCameraRefFrame rFpFfromrfpf: (FullColumn 
						with: (left + right) / 2
						with: (bottom + top) / 2
						with: distance).
	aCameraRefFrame rFfF: aCamerarFfF.
	aCamera calc.
	^aCamera
]

{ #category : #calc }
GEOProjectionFrame2 >> calc [
	rOfO := rFfF.
	aAOf := aAFf.
	rOPO := rOfO.
	aAOP := aAOf.
	aAOPT := aAOP transpose
]

{ #category : #change }
GEOProjectionFrame2 >> changed [
	rOPO := nil.
	aAOP := nil.
	aAOPT := nil.
	super changed
]

{ #category : #accessing }
GEOProjectionFrame2 >> fixedAtRef [
	"Fix at world origin."
	"Convert y axis from pointing up to pointing down."

	rFfF := (FullColumn zero: 3).
	aAFf := FullMatrix
				rotationMatrixFromOrigin: (FullColumn zero: 3)
				zPoint: (FullColumn
						with: 1.0d
						with: 1.0d
						with: -1.0d)
				xPoint: (FullColumn
						with: 1.0d
						with: -1.0d
						with: 0.0d).
	self changed
]

{ #category : #testing }
GEOProjectionFrame2 >> isInterface [
	^true
]

{ #category : #accessing }
GEOProjectionFrame2 >> metrePerPixel [
	^pixelPerMetre reciprocal
]

{ #category : #accessing }
GEOProjectionFrame2 >> pixelPerMetre [
	^pixelPerMetre
]

{ #category : #accessing }
GEOProjectionFrame2 >> pixelPerMetre: scale [ 
	pixelPerMetre := scale asDouble.
	self changed
]

{ #category : #accessing }
GEOProjectionFrame2 >> positionMemento [

	| aMemento |
	aMemento := Polymorphic_GFMemento originator: self. "VW_TRANSLATION:Polymorphic.GFMemento:Polymorphic_GFMemento"
	aMemento
		addActionSelector: #rFfF:aAFf:pixelPerMetre:
		arguments:
		(Array with: rFfF copy with: aAFf copy with: pixelPerMetre).
	^ aMemento
]

{ #category : #accessing }
GEOProjectionFrame2 >> rDPPx [
	^0 @ 0
]

{ #category : #accessing }
GEOProjectionFrame2 >> rDpPxfromrOpO: rOpO [ 
	^self rDpPxfromrPpP: (self rPpPfromrOpO: rOpO)
]

{ #category : #accessing }
GEOProjectionFrame2 >> rDpPxfromrPpP: rPpP [ 
	"rDpPx is in 2D integer coordinates."

	^((rPpP at: 1)
		* pixelPerMetre) rounded @ ((rPpP at: 2)
			* pixelPerMetre) rounded
]

{ #category : #accessing }
GEOProjectionFrame2 >> rFfF: r aAFf: aA pixelPerMetre: scale [ 
	rFfF := r.
	aAFf := aA.
	pixelPerMetre := scale asDouble.
	self changed
]

{ #category : #accessing }
GEOProjectionFrame2 >> rFfF: r pixelPerMetre: scale [ 
	rFfF := r.
	pixelPerMetre := scale asDouble.
	self changed
]

{ #category : #accessing }
GEOProjectionFrame2 >> rOPO [
	rOPO == nil ifTrue: [self calc].
	^rOPO
]

{ #category : #accessing }
GEOProjectionFrame2 >> rOpOfromrPpP: rPpP [ 
	^self rOPO + (self aAOP timesFullColumn: rPpP)
]

{ #category : #accessing }
GEOProjectionFrame2 >> rPpPfromrDpPx: rDpPx [ 
	^FullColumn
		with: rDpPx x / pixelPerMetre
		with: rDpPx y / pixelPerMetre
		with: 0.0d
]

{ #category : #accessing }
GEOProjectionFrame2 >> rPpPfromrOpO: rOpO [ 
	^self aAOPT timesFullColumn: rOpO - self rOPO
]

{ #category : #accessing }
GEOProjectionFrame2 >> refFrame: aFrame [ 
	"aFrame should be the WorldFrame."

	refFrame := aFrame
]
