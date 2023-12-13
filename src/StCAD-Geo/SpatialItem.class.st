"
SpatialItem 

Instance Variables:
	aRefFrame		<CartesianFrame>
	boundingBox	<BoundingBox>	in aRefFrame coordinates.
	name			<Symbol>
	aUI can used to store a UI object. It is stores in eventHandlers.


"
Class {
	#name : #SpatialItem,
	#superclass : #SubItem,
	#instVars : [
		'name',
		'aRefFrame',
		'aBoundingBox'
	],
	#category : #'StCAD-Geo-StCAD-Geo-Basic'
}

{ #category : #events }
SpatialItem class >> constructEventsTriggered [
	^(super constructEventsTriggered)
		add: #getUI;
		yourself
]

{ #category : #'VisualWorks metadata' }
SpatialItem class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
	)

]

{ #category : #accessing }
SpatialItem >> _aRefFrame: aaRefFrame [ 
	aRefFrame := aaRefFrame.
	aRefFrame body: self
]

{ #category : #accessing }
SpatialItem >> aBoundingBox [
	^aBoundingBox ifNil: 
			[self calcBoundingBox.
			aBoundingBox]
]

{ #category : #accessing }
SpatialItem >> aBoundingBox: anObject [
	aBoundingBox := anObject
]

{ #category : #accessing }
SpatialItem >> aBoundingBoxF [
	"In aRefFrame components."

	^self aBoundingBox inRefFrame: aRefFrame
]

{ #category : #accessing }
SpatialItem >> aRefFrame [
	^aRefFrame
]

{ #category : #accessing }
SpatialItem >> aRefFrame: aaRefFrame [ 
	aRefFrame := aaRefFrame.
	aRefFrame body: self
]

{ #category : #accessing }
SpatialItem >> aUI [
	^self triggerEvent: #getUI
]

{ #category : #accessing }
SpatialItem >> aUI: aUI [ 
	self removeActionsForEvent: #getUI.
	aUI ifNotNil: 
			[self 
				when: #getUI
				ask: aUI
				perform: #yourself]
]

{ #category : #accessing }
SpatialItem >> addMarkersIn: set [ 
	"Do nothing."
]

{ #category : #accessing }
SpatialItem >> addRefFrame: argRefFrame [ 
	"Example usage:

	addSurface: aSurface 
		aSurface removeSup.
		super addRefFrame: aSurface aRefFrame.
		cSurface add: aSurface.
		aSurface aSup: self.
		^aSurface
	"

	aRefFrame addSub: argRefFrame
]

{ #category : #calc }
SpatialItem >> cItemWithBoundingBox [
	self subclassResponsibility
]

{ #category : #accessing }
SpatialItem >> cadObject [
	^self triggerEvent: #getCADObject
]

{ #category : #accessing }
SpatialItem >> cadObject: cadObject [ 
	self removeActionsForEvent: #getCADObject.
	cadObject notNil 
		ifTrue: 
			[self 
				when: #getCADObject
				ask: cadObject
				perform: #yourself]
]

{ #category : #calc }
SpatialItem >> calc [
	"Do nothing."
]

{ #category : #calc }
SpatialItem >> calcBoundingBox [
	self privateCalcBoundingBox.
	aSup ifNotNil: [aSup clearBoundingBox]
]

{ #category : #accessing }
SpatialItem >> container [
	^aSup
]

{ #category : #'initialize-release' }
SpatialItem >> initialize [

	super initialize.
	self aRefFrame: CartesianFrame new.
	aRefFrame fixedAtRef.
	aBoundingBox := StCAD_Misc_BoundingBox new "VW_TRANSLATION:StCAD.Misc.BoundingBox:StCAD_Misc_BoundingBox"
]

{ #category : #accessing }
SpatialItem >> interface [
	^aSup ifNotNil: [aSup interface]
]

{ #category : #accessing }
SpatialItem >> isFace [
	^false
]

{ #category : #accessing }
SpatialItem >> isSketch [
	^false
]

{ #category : #ops }
SpatialItem >> magnifySelf: aDouble [ 
	aRefFrame rFfF magnifySelf: aDouble.
	aBoundingBox magnifySelf: aDouble
]

{ #category : #accessing }
SpatialItem >> name [
	^name notNil ifTrue: [name] ifFalse: [self class asString asSymbol]
]

{ #category : #accessing }
SpatialItem >> name: anObject [ 
	name := anObject ifNotNil: [anObject asSymbol]
]

{ #category : #copying }
SpatialItem >> postCopy [
	super postCopy.
	name := nil.
	self aRefFrame: aRefFrame copy.
	self aBoundingBox: aBoundingBox copy
]

{ #category : #calc }
SpatialItem >> privateCalcBoundingBox [

	aBoundingBox := StCAD_Misc_BoundingBox new. "VW_TRANSLATION:StCAD.Misc.BoundingBox:StCAD_Misc_BoundingBox"
	self privateCalcBoundingBox: self cItemWithBoundingBox
]

{ #category : #calc }
SpatialItem >> privateCalcBoundingBox: cSpatialItem [ 
	cSpatialItem do: 
			[:aSpatialItem | 
			aSpatialItem 
				ifNotNil: [aBoundingBox expandToBound: aSpatialItem aBoundingBoxF]]
]

{ #category : #accessing }
SpatialItem >> rDfD [
	^self interface projectionFrame rDpPxfromrOpO: aRefFrame rOfO
]

{ #category : #accessing }
SpatialItem >> refFrame [
	^aRefFrame
]

{ #category : #accessing }
SpatialItem >> removeSub: aSub [ 
	aRefFrame removeSub: aSub aRefFrame
]

{ #category : #accessing }
SpatialItem >> treeNodesBlock [

	^ [ :items :displayString | 
	  | child list |
	  child := StCAD_UI_TreeNode new. "VW_TRANSLATION:StCAD.UI.TreeNode:StCAD_UI_TreeNode"
	  child geoItem: items.
	  list := Core_List new: items size. "VW_TRANSLATION:Core.List:Core_List"
	  items do: [ :item | list add: item asTreeNode ].
	  list sortWith: [ :node1 :node2 | 
		  node1 geoItem name <= node2 geoItem name ].
	  child children: list.
	  child displayString: displayString.
	  child ]
]
