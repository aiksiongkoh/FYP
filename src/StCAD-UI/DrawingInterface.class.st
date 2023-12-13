Class {
	#name : #DrawingInterface,
	#superclass : #CADDrawingInterface,
	#category : #'StCAD-UI-StCAD-UI-Basic'
}

{ #category : #'VisualWorks metadata' }
DrawingInterface class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
DrawingInterface >> boundingBox [
	| answer |
	answer := worldFrame boundingBox.
	geoRootItem notNil ifTrue: [answer merge: geoRootItem boundingBox].
	^answer
]

{ #category : #handles }
DrawingInterface >> hideHandles [
	"Do nothing for now."
]

{ #category : #'initialize-release' }
DrawingInterface >> initialize [

	palette := nil.
	selections := OrderedCollection new.
	handles := OrderedCollection new.
	drawing := self class drawingClass new.
	drawing container: self.
	display := nil.
	hideHandles := 0.
	memento := Polymorphic_GFBoundedStack bound: 15. "VW_TRANSLATION:Polymorphic.GFBoundedStack:Polymorphic_GFBoundedStack"
	selectedGEOs := GEOSelections new.
	worldFrame := GEOWorldFrame2 new.
	worldFrame refFrame: self.
	worldFrame fixedAtRef.
	projectionFrame := nil
]

{ #category : #accessing }
DrawingInterface >> renderOn: aRenderingContext [ 
	worldFrame renderOn: aRenderingContext.
	geoRootItem notNil ifTrue: [geoRootItem renderOn: aRenderingContext]
]
