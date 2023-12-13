Class {
	#name : #CADSelectionTrackHandle,
	#superclass : #CADTrackHandle,
	#category : #'StCAD-UI-CAD'
}

{ #category : #'VisualWorks metadata' }
CADSelectionTrackHandle class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #calc }
CADSelectionTrackHandle >> storeMementoForInterface: anInterface [ 
	| gos mems mem |
	(anInterface isNil or: [mementoType isNil])
		ifTrue: [^self].
	mems := (gos := anInterface selections) collect: [:each | each perform: mementoType].
	mem := GFMemento originator: self.
	1 to: mems size do: [:i | mem
			addActionReceiver: (gos at: i)
			selector: #restoreFrom:
			with: (mems at: i)].
	locator receiver storeMemento: mem for: self
]

{ #category : #calc }
CADSelectionTrackHandle >> trackMouse: anInterface [ 
	"	Transcript cr; show: 'CADSelectionTrackHandle>trackMouse:'."
	| selections owner frozenOwner rDoriginD rDfirstD rDoldD arguments |
	selections := anInterface selections.
	owner := self owner.
	frozenOwner := owner frozenCopy.
	rDoriginD := self origin.
	rDfirstD := rDoldD := anInterface cursorPointSnapped: snapToGrid limit: limit.
	arguments := Array new: 7.
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
					selections
						do: 
							[:selection | 
							arguments at: 7 put: selection.
							change evaluateWithArguments: arguments]].
			anInterface repairDamage.
			rDoldD := rDnewD]
		uponRelease: nil
		until: anInterface display buttonUpCheckBlock
		scroll: scrollFlag
		preScrollDo: nil
		snapToGrid: snapToGrid
		limit: limit
]
