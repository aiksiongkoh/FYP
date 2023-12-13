Class {
	#name : #CADNMTGO,
	#superclass : #CADGraphicObject,
	#category : #'StCAD-UI-CADGraphicObject'
}

{ #category : #'VisualWorks metadata' }
CADNMTGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #calc }
CADNMTGO >> updateProjection: projectionFrame [

	| aModel aModelRefFrame rOMO aAOM cCorner block rDcP aRectangle |
	aModel := self metaObject.
	aModelRefFrame := aModel aRefFrame.
	rOMO := aModelRefFrame rOfO.
	aAOM := aModelRefFrame aAOf.
	cCorner := aModel aBoundingBox cCorner.
	block := [ :aCorner | 
	         | rOcO |
	         rOcO := rOMO + (aAOM timesFullColumn: aCorner).
	         projectionFrame rDpPxfromrOpO: rOcO ].
	rDcP := block value: cCorner first.
	aRectangle := Graphics_Rectangle origin: rDcP copy corner: rDcP copy. "VW_TRANSLATION:Graphics.Rectangle:Graphics_Rectangle"
	2 to: cCorner size do: [ :i | 
	aRectangle expandToBound: (block value: (cCorner at: i)) ].
	self visibleArea: aRectangle
]
