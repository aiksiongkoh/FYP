Extension { #name : #Collection }

{ #category : #'*StCAD-Misc-StCAD-Misc' }
Collection >> printVerboseOn: aStream [ 
	| tooMany |
	tooMany := aStream position + self maxPrint.
	aStream
		print: self class;
		nextPutAll: ' ('.
	self do: 
			[:element | 
			aStream
				cr;
				cr.
			aStream position > tooMany 
				ifTrue: 
					[aStream nextPutAll: (#etc << #dialogs >> '...etc...') asString , ')'.
					^self].
			element printVerboseOn: aStream].
	aStream
		cr;
		nextPut: $)
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
Collection >> soleItem [
	| size |
	size := self size.
	^size == 0 
		ifTrue: [nil]
		ifFalse: 
			[size == 1 
				ifTrue: [self asArray at: 1]
				ifFalse: [self error: 'There is more than one item.']]
]
