Class {
	#name : #CADDrawing,
	#superclass : #GFDrawing,
	#category : #'StCAD-UI-CAD'
}

{ #category : #'VisualWorks metadata' }
CADDrawing class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'Polymorphic'
	)

]

{ #category : #accessing }
CADDrawing >> cornerToOriginOffset [
	^visibleArea origin negated
]

{ #category : #accessing }
CADDrawing >> damage: aGO during: aBlock [ 
	"Damage aGO during the evaluation of aBlock"

	| newGORect scrollArea oldScrollArea |
	aGO willDamage.
	aBlock value.
	newGORect := aGO damaged.
	scrollArea := self drawingRect.
	oldScrollArea := scrollArea copy.
	scrollArea quadrupleToContain: newGORect.
	(oldScrollArea origin = scrollArea origin and: [oldScrollArea corner = scrollArea corner])
		ifFalse: 
			["ScrollArea has expanded."
			self drawingRect: scrollArea.
			coordSystem setOrigin: scrollArea origin negated.
			coordSystem scale: 1 @ 1.
			coordSystem extent: scrollArea extent.	"Do not change view point, but scrollbars will be updated."
			self interface scrollTopCorner: 0 @ 0]
]

{ #category : #accessing }
CADDrawing >> damageAll [
	self damageRegion: self drawingRect
]

{ #category : #accessing }
CADDrawing >> drawingRect [
	^visibleArea
]

{ #category : #accessing }
CADDrawing >> drawingRect: aRect [ 
	visibleArea := aRect
]

{ #category : #accessing }
CADDrawing >> graphicsIntersecting: rDpD collectIn: set [ 
	graphicObjects do: [:aGO | aGO graphicsIntersecting: rDpD collectIn: set]
]

{ #category : #accessing }
CADDrawing >> initialize [
	"Read documentation in CADApp"

	| basicLengthInPixel |
	showVisibleArea := false.
	visibleAreaLineColor := self class defaultLineColor.
	basicLengthInPixel := 800.
	visibleArea := basicLengthInPixel negated @ basicLengthInPixel negated corner: basicLengthInPixel @ basicLengthInPixel.
	coordSystem := CADCoordinateControl new.
	coordSystem drawing: self.
	coordSystem setOrigin: visibleArea origin negated.
	coordSystem scale: 1 @ 1.
	coordSystem extent: visibleArea extent.
	graphicObjects := SortedCollection new.
	displayGrid := false.
	gridColor := Color black
]

{ #category : #accessing }
CADDrawing >> installInInterface: cadInterface [ 
	cadInterface projectWorldFrame
]

{ #category : #accessing }
CADDrawing >> preferredBounds [
	^self drawingRect
]

{ #category : #display }
CADDrawing >> projectOn: projectionFrame animateWith: aPen [ 
	graphicObjects do: [:each | each projectOn: projectionFrame animateWith: aPen]
]

{ #category : #accessing }
CADDrawing >> quietlyUpdateProjection: projectionFrame [ 
	graphicObjects do: [:cadGO | cadGO quietlyUpdateProjection: projectionFrame]
]

{ #category : #accessing }
CADDrawing >> rSDPx [
	^visibleArea origin negated
]

{ #category : #accessing }
CADDrawing >> rTopLeftOfDrawingToDrawingOriginInPixels [
	^visibleArea origin negated
]

{ #category : #accessing }
CADDrawing >> updateProjection: projectionFrame [ 
	graphicObjects do: [:cadGO | cadGO updateProjection: projectionFrame]
]
