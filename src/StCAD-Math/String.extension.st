Extension { #name : #String }

{ #category : #'*StCAD-Math-StCAD-Math' }
String >> XYZTo123 [
	| answer |
	answer := (self at: 1) asInteger - $X asInteger + 1.
	(answer < 1 or: [answer > 3]) 
		ifTrue: [self error: 'Valid for X, Y, or Z only.'].
	^answer
]

{ #category : #'*StCAD-Math-StCAD-Math' }
String >> expandWithArgument: string [
	"Substitute %1 with string."

	| stream buffer |
	stream := self readStream.
	buffer := (String new: 256) writeStream.
	[stream atEnd] whileFalse: 
			[| char |
			char := stream next.
			char = $%
				ifTrue: [(Integer readFrom: stream) == 1 ifTrue: [buffer nextPutAll: string]]
				ifFalse: [buffer nextPut: char]].
	^buffer contents
]

{ #category : #'*StCAD-Math-StCAD-Math' }
String >> expandWithArguments: arrayOfStrings [
	"Substitute %i with the ith elements of arrayOfStrings."

	| stream buffer |
	stream := self readStream.
	buffer := (String new: 256) writeStream.
	[stream atEnd] whileFalse: 
			[| char |
			char := stream next.
			char = $%
				ifTrue: 
					[| i |
					i := Integer readFrom: stream.
					i > 0 & (i <= arrayOfStrings size)
						ifTrue: 
							[| string |
							string := arrayOfStrings at: i.
							buffer nextPutAll: string]]
				ifFalse: [buffer nextPut: char]].
	^buffer contents
]

{ #category : #'*StCAD-Math-StCAD-Math' }
String >> mbdMessage [
	"Detect prefix 'MbD' or 'ADM'."
	"Then skip pass the first blank space."
	"Then convert all \'s to cr's."

	| prefix stream buffer char |
	^(self size > 2 and: 
			[prefix := self copyFrom: 1 to: 3.
			(prefix = 'ADM' or: [prefix = 'MbD']) or: [prefix = 'StM']])
		ifTrue: 
			[stream := self readStream.
			stream skipThrough: Character space.
			buffer := (String new: 256) writeStream.
			[stream atEnd] whileFalse: 
					[char := stream next.
					buffer nextPut: (char = $\ ifTrue: [Character cr] ifFalse: [char])].
			buffer contents]
		ifFalse: [self withCRs]
]

{ #category : #'*StCAD-Math-StCAD-Math' }
String >> printForExport [
	^self
]

{ #category : #'*StCAD-Math-StCAD-Math' }
String >> startWith: subString [ 
	^(self indexOfSubCollection: subString startingAt: 1) == 1
]

{ #category : #'*StCAD-Math-StCAD-Math' }
String >> xyzTo123 [
	| answer |
	answer := (self at: 1) asInteger - $x asInteger + 1.
	(answer < 1 or: [answer > 3]) 
		ifTrue: [self error: 'Valid for x, y, or z only.'].
	^answer
]
