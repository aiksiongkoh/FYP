Class {
	#name : #CADIndexedTrackHandle,
	#superclass : #CADTrackHandle,
	#instVars : [
		'index'
	],
	#category : #'StCAD-UI-CAD'
}

{ #category : #'VisualWorks metadata' }
CADIndexedTrackHandle class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : #accessing }
CADIndexedTrackHandle >> index [
	^index
]

{ #category : #accessing }
CADIndexedTrackHandle >> index: i [ 
	index := i
]

{ #category : #accessing }
CADIndexedTrackHandle >> popupMenu [
	locator receiver popupMenuIndexedTrackHandle: self
]

{ #category : #calc }
CADIndexedTrackHandle >> trackMouse: anInterface [ 
	| owner frozenOwner rDoriginD rDfirstD rDoldD arguments |
	owner := self owner.
	frozenOwner := owner frozenCopy.
	rDoriginD := self origin.
	rDfirstD := rDoldD := anInterface cursorPointSnapped: snapToGrid limit: limit.
	arguments := Array new: 7.
	arguments at: 1 put: owner.
	arguments at: 2 put: frozenOwner.
	arguments at: 3 put: rDoriginD.
	arguments at: 4 put: rDfirstD.
	arguments at: 7 put: index.
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
		uponRelease: nil
		until: anInterface display buttonUpCheckBlock
		scroll: scrollFlag
		preScrollDo: nil
		snapToGrid: snapToGrid
		limit: limit
]
