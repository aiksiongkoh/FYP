Class {
	#name : #PerspectiveCamera,
	#superclass : #Camera,
	#instVars : [
		'distance',
		'height',
		'viewFactor'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
PerspectiveCamera class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
PerspectiveCamera >> aRenderingContextOn: aRetainedMedium [ 
	| dict aRenderingContext |
	dict := IdentityDictionary new: 5.
	dict at: #solid put: OpenGLSolidRenderingContext.
	dict at: #hiddenline put: OpenGLHiddenLineRenderingContext.
	dict at: #wireframe put: OpenGLWireframeRenderingContext.
	aRenderingContext := (dict at: presentation) on: aRetainedMedium.
	aRenderingContext clear.
	aRenderingContext obeyPerspectiveCamera: self.
	^aRenderingContext
]

{ #category : #calc }
PerspectiveCamera >> calc [
	near := distance / viewFactor.
	far := distance * viewFactor
]

{ #category : #accessing }
PerspectiveCamera >> distance: anObject [ 
	distance := anObject.
	self calc
]

{ #category : #accessing }
PerspectiveCamera >> fovy [
	^JunAngle fromRad: (height / 2 / distance) arcTan * 2
]

{ #category : #accessing }
PerspectiveCamera >> height [
	^height
]

{ #category : #accessing }
PerspectiveCamera >> height: anObject [ 
	height := anObject
]

{ #category : #'initialize-release' }
PerspectiveCamera >> initialize [

	| aAFf rFfF |
	self aRefFrame: CartesianFrame new.
	distance := self defaultDistance.
	height := distance / self ratio.
	viewFactor := self defaultViewFactor.
	near := distance / viewFactor.
	far := distance * viewFactor.
	aAFf := FullMatrix
		        rotationMatrixFromzDir:
		        (FullColumn with: -1.0 d with: -1.0 d with: 1.0 d)
		        xDir: (FullColumn with: 1.0 d with: -1.0 d with: 0.0 d).
	rFfF := aAFf timesFullColumn:
		        (FullColumn with: 0.0 d with: 0.0 d with: distance).
	aRefFrame rFfF: rFfF aAFf: aAFf.
	shading := self defaultShading.
	presentation := self defaultPresentation.
	lineSmoothBoolean := false.
	polygonSmoothBoolean := false.
	cLighting := StCAD_Misc_OrderedSet new. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	self privateCalcBoundingBox
]

{ #category : #testing }
PerspectiveCamera >> isPerspective [
	^true
]

{ #category : #'menubar items' }
PerspectiveCamera >> menuViewYupQuadmpm [
	| rFfocusF reyefocus ufocuseyeF rFeyeF uFupF |
	rFfocusF := aRefFrame rFpFfromrfpf: (FullColumn
						with: 0.0d
						with: 0.0d
						with: distance negated).
	reyefocus := distance.
	ufocuseyeF := (FullColumn with: -1.0d with: 1.0d with: -1.0d)
				normalizeSelf.
	rFeyeF := rFfocusF plusFullColumn: ufocuseyeF times: reyefocus.
	uFupF := FullColumn with: 0.0d with: 1.0d with: 0.0d.
	aRefFrame rFfF: rFeyeF
		aAFf: (FullMatrix rotationMatrixFromzDir: ufocuseyeF yDir: uFupF).
]

{ #category : #'menubar items' }
PerspectiveCamera >> menuViewYupXright [
	| rFfocusF reyefocus ufocuseyeF rFeyeF uFupF |
	rFfocusF := aRefFrame rFpFfromrfpf: (FullColumn
						with: 0.0d
						with: 0.0d
						with: distance negated).
	reyefocus := distance.
	ufocuseyeF := FullColumn with: 0.0d with: 0.0d with: 1.0d.
	rFeyeF := rFfocusF plusFullColumn: ufocuseyeF times: reyefocus.
	uFupF := FullColumn with: 0.0d with: 1.0d with: 0.0d.
	aRefFrame rFfF: rFeyeF
		aAFf: (FullMatrix rotationMatrixFromzDir: ufocuseyeF yDir: uFupF).
]

{ #category : #'menubar items' }
PerspectiveCamera >> menuViewZupQuadmmp [
	| rFfocusF reyefocus ufocuseyeF rFeyeF uFupF |
	rFfocusF := aRefFrame rFpFfromrfpf: (FullColumn
						with: 0.0d
						with: 0.0d
						with: distance negated).
	reyefocus := distance.
	ufocuseyeF := (FullColumn with: -1.0d with: -1.0d with: 1.0d)
				normalizeSelf.
	rFeyeF := rFfocusF plusFullColumn: ufocuseyeF times: reyefocus.
	uFupF := FullColumn with: 0.0d with: 0.0d with: 1.0d.
	aRefFrame rFfF: rFeyeF
		aAFf: (FullMatrix rotationMatrixFromzDir: ufocuseyeF yDir: uFupF).
]

{ #category : #projection }
PerspectiveCamera >> pickAt: rvGLpvGL aContext: aContext [ 
	aContext pickAt: rvGLpvGL aPerspectiveCamera: self
]

{ #category : #calc }
PerspectiveCamera >> privateCalcBoundingBox [
	aBoundingBox := BoundingBox origin: (FullColumn zero: 3)
				corner: (FullColumn zero: 3).
	self privateCalcBoundingBox: self cItemWithBoundingBox
]

{ #category : #projection }
PerspectiveCamera >> projectOn: aRenderingContext [ 
	super projectOn: aRenderingContext.
	aRenderingContext perspective: self
]

{ #category : #accessing }
PerspectiveCamera >> sightPoint [
	^aRefFrame rOpOfromrfpf: (FullColumn 
				with: 0.0d
				with: 0.0d
				with: distance negated)
]

{ #category : #accessing }
PerspectiveCamera >> viewFactor [
	^viewFactor
]

{ #category : #accessing }
PerspectiveCamera >> viewFactor: anObject [ 
	viewFactor := anObject.
	self calc
]
