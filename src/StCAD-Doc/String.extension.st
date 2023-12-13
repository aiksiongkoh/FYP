Extension { #name : #String }

{ #category : #'*StCAD-Doc-StCAD-Doc' }
String >> cleanSourceFromSelf [
	"Return a version of aString which has a cr line-end convention imposed upon it. 
	If the stream actually contains lf, cr-lf or (worse) lf-cr line-ends, replace each 
	single occurrence of a line-end with a single cr. This is to help alleviate problems 
	caused by moving source files between machines with different line-end conventions."

	| lf cr cleanStream prev |
	cleanStream := (String new: self size) writeStream.
	lf := Character lf.
	cr := Character cr.
	prev := nil.
	1 to: self size
		do: 
			[:i | 
			| ch |
			ch := self at: i.
			lf == ch 
				ifTrue: 
					[cr == prev 
						ifTrue: [prev := nil]
						ifFalse: 
							[cleanStream nextPut: cr.
							prev := lf]]
				ifFalse: 
					[cr == ch 
						ifTrue: 
							[lf == prev ifTrue: [prev := nil] ifFalse: [prev := cleanStream nextPut: ch]]
						ifFalse: [prev := cleanStream nextPut: ch]]].
	^cleanStream contents
]

{ #category : #'*StCAD-Doc-StCAD-Doc' }
String >> replaceCRandTabWithMacros [
	| input output cr tab char |
	input := self readStream.
	output := (String new: 256) writeStream.
	cr := Character cr.
	tab := Character tab.
	[input atEnd]
		whileFalse: 
			[char := input next.
			char = cr
				ifTrue: [output nextPutAll: '<n>']
				ifFalse: [char = tab
						ifTrue: [output nextPutAll: '<t>']
						ifFalse: [output nextPut: char]]].
	^output contents
]
