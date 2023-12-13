Extension { #name : #SequenceableCollection }

{ #category : #'*StCAD-Geo-StCAD-Geo' }
SequenceableCollection >> storeOn: aStream level: level [ 
	aStream tabToLevel: level.
	self size > 0
		ifTrue: 
			[aStream nextPutAll: (self at: 1) printForExport.
			2 to: self size do: [:i | aStream tab; nextPutAll: (self at: i) printForExport]].
	aStream cr
]

{ #category : #'*StCAD-Geo-StCAD-Geo' }
SequenceableCollection >> storePOVOn: aStream level: level [ 
	| block |
	aStream tabToLevel: level.
	self size > 0 
		ifTrue: 
			[block := 
					[:each | 
					aStream 
						nextPutAll: (each isDouble ifTrue: [each asFloat] ifFalse: [each]) 
								printForExport].
			block value: (self at: 1).
			2 to: self size
				do: 
					[:i | 
					aStream
						nextPut: $,;
						space.
					block value: (self at: i)]].
	aStream cr
]

{ #category : #'*StCAD-Geo-StCAD-Geo' }
SequenceableCollection >> storePOVOn: aStream level: level title: title [ 
	self isEmpty 
		ifFalse: 
			[aStream storePOVLevel: level title: title.
			self do: [:i | i storePOVOn: aStream level: level + 1]].
	^self
]
