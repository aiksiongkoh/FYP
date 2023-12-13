Extension { #name : #OrderedCollection }

{ #category : #'*StCAD-UI-StCAD-UI' }
OrderedCollection >> conflict: aRectangle [ 
	"Replaces the one in GF/ST."

	^self select: [:each | each intersects: aRectangle]
]
