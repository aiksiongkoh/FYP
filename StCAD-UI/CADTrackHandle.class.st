"
Modified for 3D rotation and tilting.

Instance Variables:
change	<Action>	(change evaluateWithArguments: #(owner frozenOwner radialVector)) defines the action of the tracking the mouse.

hotSpot	<Action>	(hotSpot value: self) defines the hot spot for the handle interaction.
"
Class {
	#name : #CADTrackHandle,
	#superclass : #GFTrackHandle,
	#instVars : [
		'hotSpot'
	],
	#category : #'StCAD-UI-CAD'
}

{ #category : #'VisualWorks metadata' }
CADTrackHandle class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'Polymorphic'
	)

]

{ #category : #accessing }
CADTrackHandle >> containsPoint: aPoint [ 
	^(self hotRect expandByScalar: 2)
		containsPoint: aPoint
]

{ #category : #accessing }
CADTrackHandle >> displayBox [
	^(displayGO == nil
		ifTrue: [self hotRect]
		ifFalse: [displayGO displayBox translatedBy: self origin])
		expandByScalar: 2
]

{ #category : #accessing }
CADTrackHandle >> displayWith: aPen [ 
	displayGO == nil
		ifFalse: 
			[displayGO basicTranslateBy: self origin.
			displayGO displayWith: aPen.
			displayGO basicTranslateBy: self origin negated].
	aPen setLineWidthTo: 1; blackFill; white; centerHandleAt: self hotSpot sizeInPixel: HandleSize
]

{ #category : #accessing }
CADTrackHandle >> hotRect [
	"Hot rectangle to trigger the handle. Need be the origin."

	| center halfSide rect |
	center := self hotSpot.
	halfSide := HandleSize // 2.
	rect := center - halfSide corner: center + halfSide.
	^rect
]

{ #category : #accessing }
CADTrackHandle >> hotSpot [
	"Center of hot rectangle to trigger the handle. Need not be the origin."

	^hotSpot == nil
		ifTrue: [self origin]
		ifFalse: [hotSpot value: self]
]

{ #category : #accessing }
CADTrackHandle >> hotSpot: block [ 
	hotSpot := block
]

{ #category : #accessing }
CADTrackHandle >> origin [
	"Location of handle origin in drawing coordinates."

	^locator asPoint
]

{ #category : #accessing }
CADTrackHandle >> trackMouse: anInterface [ 
	| owner frozenOwner rDoriginD rDfirstD rDoldD arguments |
	owner := self owner.
	frozenOwner := owner frozenCopy.
	rDoriginD := self origin.
	rDfirstD := rDoldD := anInterface cursorPointSnapped: snapToGrid limit: limit.
	arguments := Array new: 6.
	arguments at: 1 put: owner.
	arguments at: 2 put: frozenOwner.
	arguments at: 3 put: rDoriginD.
	arguments at: 4 put: rDfirstD.
	anInterface
		trackMouse: 
			[:rDnewD | 
			change == nil
				ifFalse: 
					[arguments at: 5 put: rDoldD.
					arguments at: 6 put: rDnewD.
					change evaluateWithArguments: arguments].
			anInterface repairDamage.
			rDoldD := rDnewD]
		uponRelease: []
		until: anInterface display buttonUpCheckBlock
		scroll: scrollFlag
		preScrollDo: nil
		snapToGrid: snapToGrid
		limit: limit
]
