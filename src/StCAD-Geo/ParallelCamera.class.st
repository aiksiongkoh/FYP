Class {
	#name : #ParallelCamera,
	#superclass : #Camera,
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #'VisualWorks metadata' }
ParallelCamera class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
ParallelCamera >> aRenderingContextExtent: extent [ 
	| dict aRenderingContext |
	dict := IdentityDictionary new: 5.
	dict at: #solid put: OpenGLSolidRenderingContext.
	dict at: #hiddenline put: OpenGLHiddenLineRenderingContext.
	dict at: #wireframe put: OpenGLWireframeRenderingContext.
	aRenderingContext := (dict at: presentation) extent: extent.
	aRenderingContext clear.
	aRenderingContext obeyParallelCamera: self.
	^aRenderingContext
]

{ #category : #accessing }
ParallelCamera >> aRenderingContextOn: aRetainedMedium [ 
	| dict aRenderingContext |
	dict := IdentityDictionary new: 5.
	dict at: #solid put: OpenGLSolidRenderingContext.
	dict at: #hiddenline put: OpenGLHiddenLineRenderingContext.
	dict at: #wireframe put: OpenGLWireframeRenderingContext.
	aRenderingContext := (dict at: presentation) on: aRetainedMedium.
	aRenderingContext clear.
	aRenderingContext obeyParallelCamera: self.
	^aRenderingContext
]

{ #category : #'initialize-release' }
ParallelCamera >> initialize [

	| aAFf rFfF |
	self aRefFrame: CartesianFrame new.
	aAFf := FullMatrix
		        rotationMatrixFromzDir:
		        (FullColumn with: -1.0 d with: -1.0 d with: 1.0 d)
		        xDir: (FullColumn with: 1.0 d with: -1.0 d with: 0.0 d).
	rFfF := aAFf timesFullColumn:
		        (FullColumn with: 0.0 d with: 0.0 d with: 0.0 d).
	aRefFrame rFfF: rFfF aAFf: aAFf.
	shading := self defaultShading.
	presentation := self defaultPresentation.
	lineSmoothBoolean := false.
	polygonSmoothBoolean := false.
	cLighting := StCAD_Misc_OrderedSet new. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	self privateCalcBoundingBox
]

{ #category : #accessing }
ParallelCamera >> lineSmoothBoolean1 [
	^lineSmoothBoolean
]

{ #category : #accessing }
ParallelCamera >> lineSmoothBoolean1: anObject [
	lineSmoothBoolean := anObject
]

{ #category : #projection }
ParallelCamera >> projectOn: aRenderingContext [ 
	super projectOn: aRenderingContext.
	aRenderingContext parallelProjection: self
]

{ #category : #accessing }
ParallelCamera >> sightPoint [
	^aRefFrame rOpOfromrfpf: (FullColumn 
				with: 0.0d
				with: 0.0d
				with: 1.0d negated)
]
