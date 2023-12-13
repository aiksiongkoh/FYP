Extension { #name : #Differator }

{ #category : #'*StCAD-Misc-StCAD-Misc' }
Differator classSide >> newOnFile: aFilename and: bFilename [ 
	| block |
	block := 
			[:argFilename | 
			| aStream aText |
			aStream := argFilename asFilename readStream.
			[aText := aStream contents] ensure: [aStream close].
			aText].
	^self newOn: (block value: aFilename) and: (block value: bFilename)
]
