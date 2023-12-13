Extension { #name : #OrderedCollection }

{ #category : #'*StCAD-Misc-adding' }
OrderedCollection >> addOneOrMore: oneOrMore [

	^oneOrMore isSequenceable
		ifTrue: [self addAllLast: oneOrMore]
		ifFalse: [self addLast: oneOrMore]
]
