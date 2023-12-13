Extension { #name : #SequenceableCollection }

{ #category : #'*StCAD-Misc-StCAD-Misc' }
SequenceableCollection >> breakIntoSizeOf: newSize [ 
	"No padding is done to the tail piece."

	| selfSize nWholePiece remainder cPiece start |
	selfSize := self size.
	nWholePiece := selfSize // newSize.
	remainder := selfSize \\ newSize.
	cPiece := OrderedCollection new: nWholePiece + 1.
	start := 1.
	1 to: nWholePiece
		do: 
			[:index | 
			| newPiece end |
			end := start + newSize - 1.
			newPiece := self copyFrom: start to: end.
			cPiece add: newPiece.
			start := end + 1].
	remainder > 0 ifTrue: [cPiece add: (self copyFrom: start to: selfSize)].
	^cPiece
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
SequenceableCollection >> breakIntoSizeOf: newSize padWith: padding [ 
	"Padding is done to the tail piece."

	| selfSize nWholePiece remainder cPiece start |
	selfSize := self size.
	nWholePiece := selfSize // newSize.
	remainder := selfSize \\ newSize.
	cPiece := OrderedCollection new: nWholePiece + 1.
	start := 1.
	1 to: nWholePiece
		do: 
			[:index | 
			| newPiece end |
			end := start + newSize - 1.
			newPiece := self copyFrom: start to: end.
			cPiece add: newPiece.
			start := end + 1].
	remainder > 0 
		ifTrue: 
			[| tailPiece |
			tailPiece := (self species withSize: newSize) 
						replaceFrom: 1
						to: remainder
						with: self
						startingAt: start.
			remainder + 1 to: newSize do: [:i | tailPiece at: i put: padding].
			cPiece add: tailPiece].
	^cPiece
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
SequenceableCollection >> concatenateCollections [
	"Receiver is a collection of similar collections. Return the concatenated collection."

	| totalSize answer start |
	totalSize := self inject: 0 into: [:subTotal :next | subTotal + next size].
	answer := (self at: 1) species withSize: totalSize.
	start := 1.
	self do: 
			[:aCollection | 
			| end |
			end := start + aCollection size - 1.
			answer 
				replaceFrom: start
				to: end
				with: aCollection
				startingAt: 1.
			start := end + 1].
	^answer
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
SequenceableCollection >> concatenateCollectionsWith: aObject [ 
	"Receiver is a collection of similar collections. Return the concatenated collection."

	| aStream |
	aStream := String new writeStream.
	self do: [:aString | aStream nextPutAll: aString]
		separatedBy: [aStream nextPut: aObject].
	^aStream contents
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
SequenceableCollection >> copyWrapFrom: start to: stop [ 
	| newSize answer nStartToEnd |
	^start <= stop 
		ifTrue: 
			[newSize := stop - start + 1.
			answer := self species withSize: newSize.
			answer 
				replaceFrom: 1
				to: newSize
				with: self
				startingAt: start]
		ifFalse: 
			["Copy to the end, cycle to the beginning and continue copying to stop"

			nStartToEnd := self size - start + 1.
			newSize := nStartToEnd + stop.
			answer := self species withSize: newSize.
			answer 
				replaceFrom: 1
				to: nStartToEnd
				with: self
				startingAt: start.
			answer 
				replaceFrom: nStartToEnd + 1
				to: newSize
				with: self
				startingAt: 1]
]

{ #category : #'*StCAD-Misc-StCAD-DEV' }
SequenceableCollection class >> example1 [
	"self example1."

	| string |
	string := '12345678901234567890'.
	(string breakIntoSizeOf: 7) inspect.
	(string breakIntoSizeOf: 14) inspect.
	(string breakIntoSizeOf: 21) inspect
]

{ #category : #'*StCAD-Misc-StCAD-DEV' }
SequenceableCollection class >> example2 [
	"self example2."

	| string |
	string := '12345678901234567890'.
	(string breakIntoSizeOf: 7 padWith: Character space) inspect.
	(string breakIntoSizeOf: 14 padWith: Character space) inspect.
	(string breakIntoSizeOf: 21 padWith: Character space) inspect
]

{ #category : #'*StCAD-Misc-StCAD-DEV' }
SequenceableCollection class >> example3 [
	"self example3."

	| string1 string2 string3 string4 |
	string1 := '1234567890'.
	string2 := '123456789012345'.
	string3 := '678901234567890'.
	string4 := '12345678901234567890'.
	^(Array 
		with: string1
		with: string2
		with: string3
		with: string4) concatenateCollections
]

{ #category : #'*StCAD-Misc-StCAD-DEV' }
SequenceableCollection class >> example3a [
	"self example3a."

	| string |
	string := '12345678901234567890'.
	(string breakIntoSizeOf: 7) concatenateCollections inspect.
	(string breakIntoSizeOf: 14) concatenateCollections inspect.
	(string breakIntoSizeOf: 21) concatenateCollections inspect
]

{ #category : #'*StCAD-Misc-StCAD-DEV' }
SequenceableCollection class >> example3b [
	"self example3b."

	| string |
	string := '12345678901234567890'.
	(string breakIntoSizeOf: 7 padWith: Character space) 
		concatenateCollections inspect.
	(string breakIntoSizeOf: 14 padWith: Character space) 
		concatenateCollections inspect.
	(string breakIntoSizeOf: 21 padWith: Character space) 
		concatenateCollections inspect
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
SequenceableCollection >> middle [
	self emptyCheck.
	^self at: self size // 2 + 1
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
SequenceableCollection >> replaceFrom: start with: replacement from: repStart to: repStop [ 
	"This destructively replaces elements from start to stop in the 
	receiver starting at index, repStart, in the collection, replacement. 
	Answer the receiver. No range checks are performed, but 
	overlapping replacements are handled correctly."

	^self 
		replaceFrom: start
		to: start + repStop - repStart
		with: replacement
		startingAt: repStart
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
SequenceableCollection >> replaceFrom: start withCyclic: replacement from: repStart to: repStop [ 
	^repStart <= repStop 
		ifTrue: 
			[self 
				replaceFrom: start
				to: start + repStop - repStart
				with: replacement
				startingAt: repStart]
		ifFalse: 
			["Copy to the end, cycle to the beginning and continue copying to repStop"

			| repSize startPLUSrepSizeMINUSrepStart |
			repSize := replacement size.
			startPLUSrepSizeMINUSrepStart := start + repSize - repStart.
			self 
				replaceFrom: start
				to: startPLUSrepSizeMINUSrepStart
				with: replacement
				startingAt: repStart.
			self 
				replaceFrom: startPLUSrepSizeMINUSrepStart + 1
				to: startPLUSrepSizeMINUSrepStart + repStop
				with: replacement
				startingAt: 1]
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
SequenceableCollection >> with: aCollection parallelCollect: aBlock [ 
	| n newCollection |
	(n := self size) == aCollection size 
		ifFalse: [self error: #'Parallel collections should match.' << #koh].
	newCollection := self species withSize: n.
	1 to: n
		do: 
			[:i | 
			newCollection at: i
				put: (aBlock value: (self at: i) value: (aCollection at: i))].
	^newCollection
]

{ #category : #'*StCAD-Misc-StCAD-Misc' }
SequenceableCollection >> with: aCollection parallelDo: aBlock [ 
	| n |
	(n := self size) == aCollection size 
		ifFalse: [self error: #'Parallel collections should match.' << #koh].
	1 to: n do: [:i | aBlock value: (self at: i) value: (aCollection at: i)]
]
