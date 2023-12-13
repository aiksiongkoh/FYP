Extension { #name : #Point }

{ #category : #'*StCAD-UI-StCAD-UI' }
Point >> fitSelfInRect: aBoundingRect [ 
	aBoundingRect isDefined 
		ifTrue: 
			[aBoundingRect origin: (self min: aBoundingRect origin)
				corner: (self max: aBoundingRect corner)]
		ifFalse: [aBoundingRect origin: self copy corner: self copy]
]
