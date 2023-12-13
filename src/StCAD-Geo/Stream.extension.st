Extension { #name : #Stream }

{ #category : #'*StCAD-Geo-StCAD-Geo' }
Stream >> storeLevel: level title: title [ 
	self tabToLevel: level; nextPutAll: title; cr
]

{ #category : #'*StCAD-Geo-StCAD-Geo' }
Stream >> storeLevel: level title: title object: object [ 
	self tabToLevel: level; nextPutAll: title; cr.
	object notNil
		ifTrue: [object storeOn: self level: level + 1]
		ifFalse: [self tabToLevel: level + 1; nextPutAll: '0'; cr]
]

{ #category : #'*StCAD-Geo-StCAD-Geo' }
Stream >> storePOVLevel: level title: title [ 
	self tabToLevel: level; nextPutAll: title; cr
]

{ #category : #'*StCAD-Geo-StCAD-Geo' }
Stream >> storePOVLevel: level title: title object: object [ 
	self tabToLevel: level; nextPutAll: title; cr.
	object notNil
		ifTrue: [object storePOVOn: self level: level + 1]
		ifFalse: [self tabToLevel: level + 1; nextPutAll: '0'; cr]
]

{ #category : #'*StCAD-Geo-StCAD-Geo' }
Stream >> storePOVTitle: title series: series [ 
	| string |
	string := '#declare <1s> = array[<2s>]{' expandMacrosWith: title
				with: series size printForExport.
	self
		nextPutAll: string;
		cr.
	series storePOVOn: self level: 1.
	self
		nextPut: $};
		cr
]

{ #category : #'*StCAD-Geo-StCAD-Geo' }
Stream >> storeTitle: title input: input series: series [ 
	| inputData |
	inputData := input isReal
				ifTrue: [input printForExport]
				ifFalse: [input isString
						ifTrue: [input]
						ifFalse: [input printString]].
	self nextPutAll: title; tab; nextPutAll: inputData; tab.
	series storeOn: self level: 1
]

{ #category : #'*StCAD-Geo-StCAD-Geo' }
Stream >> tabToLevel: level [ 
	level - 1 timesRepeat: [self tab]
]
